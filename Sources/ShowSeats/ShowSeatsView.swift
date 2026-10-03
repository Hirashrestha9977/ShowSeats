import SwiftUI

/// A scrollable grid of seats. Clickable seats report taps through `onSeatTap`.
public struct ShowSeatsView: View {
    private let configuration: ShowSeatsConfiguration
    private let onSeatTap: (Seat) -> Void

    @State private var selectedSeats: Set<SeatPosition> = []

    public init(configuration: ShowSeatsConfiguration, onSeatTap: @escaping (Seat) -> Void = { _ in }) {
        self.configuration = configuration
        self.onSeatTap = onSeatTap
    }

    public init(
        rows: Int,
        columns: Int,
        rowColors: [Int: String] = [:],
        nonClickableSeats: Set<SeatPosition> = [],
        onSeatTap: @escaping (Seat) -> Void = { _ in }
    ) {
        self.init(
            configuration: ShowSeatsConfiguration(
                rows: rows,
                columns: columns,
                rowColors: rowColors,
                nonClickableSeats: nonClickableSeats
            ),
            onSeatTap: onSeatTap
        )
    }

    public var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(spacing: configuration.spacing) {
                ForEach(0..<configuration.rows, id: \.self) { row in
                    HStack(spacing: configuration.spacing) {
                        ForEach(0..<configuration.columns, id: \.self) { column in
                            seatCell(row: row, column: column)
                        }
                    }
                }
            }
            .padding(configuration.spacing)
        }
    }

    @ViewBuilder
    private func seatCell(row: Int, column: Int) -> some View {
        let position = SeatPosition(row: row, column: column)
        let isClickable = configuration.isClickable(row: row, column: column)
        let isSelected = selectedSeats.contains(position)
        let hex = configuration.colorHex(row: row, column: column, isSelected: isSelected)
        let shape = RoundedRectangle(cornerRadius: configuration.cornerRadius)

        let cell = shape
            .fill(Color(seatHex: hex) ?? .gray)
            .frame(width: configuration.seatSize.width, height: configuration.seatSize.height)
            .contentShape(shape)
            .accessibilityElement()
            .accessibilityLabel(Text("Row \(row + 1), seat \(column + 1)"))

        if isClickable {
            cell
                .onTapGesture { tap(position) }
                .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
        } else {
            cell
                .accessibilityHint(Text("Unavailable"))
        }
    }

    private func tap(_ position: SeatPosition) {
        var isSelected = false
        if configuration.highlightsSelection {
            if selectedSeats.contains(position) {
                selectedSeats.remove(position)
            } else {
                selectedSeats.insert(position)
                isSelected = true
            }
        }
        onSeatTap(Seat(row: position.row, column: position.column, isClickable: true, isSelected: isSelected))
    }
}

#if DEBUG
struct ShowSeatsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowSeatsView(
            rows: 6,
            columns: 8,
            rowColors: [0: "#FF3B30", 1: "#FF3B30", 2: "#FF9500", 3: "#FF9500"],
            nonClickableSeats: [SeatPosition(row: 0, column: 0), SeatPosition(row: 2, column: 3)]
        ) { seat in
            print("Tapped row \(seat.row), column \(seat.column), selected: \(seat.isSelected)")
        }
    }
}
#endif

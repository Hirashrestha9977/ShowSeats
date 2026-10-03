import Foundation

/// The zero-based location of a seat in the grid.
public struct SeatPosition: Hashable {
    public let row: Int
    public let column: Int

    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}

/// A seat delivered to the tap callback.
public struct Seat: Hashable, Identifiable {
    public let row: Int
    public let column: Int
    public let isClickable: Bool
    /// Selection state of the seat *after* the tap that produced this value.
    public let isSelected: Bool

    public var position: SeatPosition { SeatPosition(row: row, column: column) }
    public var id: SeatPosition { position }

    public init(row: Int, column: Int, isClickable: Bool, isSelected: Bool = false) {
        self.row = row
        self.column = column
        self.isClickable = isClickable
        self.isSelected = isSelected
    }
}

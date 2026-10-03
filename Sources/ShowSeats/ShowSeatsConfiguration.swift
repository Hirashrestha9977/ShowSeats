import CoreGraphics

/// Describes the seat grid: its size, per-row colors and which seats can be tapped.
///
/// Rows and columns are zero-based. Colors are hex codes such as `"#FF0000"`,
/// `"FF0000"`, `"#F00"` or `"#FF0000CC"` (RGBA).
public struct ShowSeatsConfiguration {
    public var rows: Int
    public var columns: Int

    /// Hex color code for each row, keyed by row index. Rows without an entry use `defaultColorHex`.
    public var rowColors: [Int: String]
    public var defaultColorHex: String

    /// Seats that are displayed but do not respond to taps.
    public var nonClickableSeats: Set<SeatPosition>
    public var nonClickableColorHex: String

    /// When `true`, tapping a clickable seat toggles its selected state and paints it with `selectedColorHex`.
    public var highlightsSelection: Bool
    public var selectedColorHex: String

    public var seatSize: CGSize
    public var spacing: CGFloat
    public var cornerRadius: CGFloat

    public init(
        rows: Int,
        columns: Int,
        rowColors: [Int: String] = [:],
        defaultColorHex: String = "#4A90E2",
        nonClickableSeats: Set<SeatPosition> = [],
        nonClickableColorHex: String = "#ffffff",
        highlightsSelection: Bool = true,
        selectedColorHex: String = "#34C759",
        seatSize: CGSize = CGSize(width: 32, height: 32),
        spacing: CGFloat = 8,
        cornerRadius: CGFloat = 6
    ) {
        self.rows = max(0, rows)
        self.columns = max(0, columns)
        self.rowColors = rowColors
        self.defaultColorHex = defaultColorHex
        self.nonClickableSeats = nonClickableSeats
        self.nonClickableColorHex = nonClickableColorHex
        self.highlightsSelection = highlightsSelection
        self.selectedColorHex = selectedColorHex
        self.seatSize = seatSize
        self.spacing = spacing
        self.cornerRadius = cornerRadius
    }

    public func isClickable(row: Int, column: Int) -> Bool {
        !nonClickableSeats.contains(SeatPosition(row: row, column: column))
    }

    /// The hex code used to paint a seat, taking clickability and selection into account.
    public func colorHex(row: Int, column: Int, isSelected: Bool = false) -> String {
        guard isClickable(row: row, column: column) else { return nonClickableColorHex }
        if isSelected && highlightsSelection { return selectedColorHex }
        return rowColors[row] ?? defaultColorHex
    }
}

import XCTest
@testable import ShowSeats

final class ShowSeatsTests: XCTestCase {
    func testHexParsing() {
        XCTAssertEqual(HexColor("#FF0000"), HexColor("f00"))
        XCTAssertEqual(HexColor("#FF0000")?.red, 1)
        XCTAssertEqual(HexColor("#FF0000")?.green, 0)
        XCTAssertEqual(HexColor("#FF0000")?.alpha, 1)
        XCTAssertEqual(HexColor("00FF0080")?.green, 1)
        XCTAssertEqual(HexColor("00FF0080")?.alpha ?? 0, 128.0 / 255, accuracy: 0.0001)
    }

    func testInvalidHexIsRejected() {
        XCTAssertNil(HexColor(""))
        XCTAssertNil(HexColor("#GGGGGG"))
        XCTAssertNil(HexColor("#12345"))
        XCTAssertNil(HexColor("+12345"))
    }

    func testRowColorFallsBackToDefault() {
        let config = ShowSeatsConfiguration(rows: 3, columns: 3, rowColors: [1: "#111111"], defaultColorHex: "#222222")
        XCTAssertEqual(config.colorHex(row: 0, column: 0), "#222222")
        XCTAssertEqual(config.colorHex(row: 1, column: 2), "#111111")
    }

    func testNonClickableSeats() {
        let blocked = SeatPosition(row: 1, column: 1)
        let config = ShowSeatsConfiguration(
            rows: 3,
            columns: 3,
            rowColors: [1: "#111111"],
            nonClickableSeats: [blocked],
            nonClickableColorHex: "#999999"
        )
        XCTAssertFalse(config.isClickable(row: 1, column: 1))
        XCTAssertTrue(config.isClickable(row: 1, column: 0))
        XCTAssertEqual(config.colorHex(row: 1, column: 1, isSelected: true), "#999999")
    }

    func testSelectedColor() {
        var config = ShowSeatsConfiguration(rows: 2, columns: 2, defaultColorHex: "#222222", selectedColorHex: "#00FF00")
        XCTAssertEqual(config.colorHex(row: 0, column: 0, isSelected: true), "#00FF00")
        config.highlightsSelection = false
        XCTAssertEqual(config.colorHex(row: 0, column: 0, isSelected: true), "#222222")
    }

    func testNegativeDimensionsAreClamped() {
        let config = ShowSeatsConfiguration(rows: -1, columns: -5)
        XCTAssertEqual(config.rows, 0)
        XCTAssertEqual(config.columns, 0)
    }
}

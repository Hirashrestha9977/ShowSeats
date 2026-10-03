# ShowSeats

A Swift Package that renders a grid of seats from a row and column count, with a hex color per row, clickable and non-clickable seats, and a tap callback.

Requires iOS 14+ (SwiftUI, with a UIKit wrapper).

## Installation

In Xcode: **File > Add Package Dependencies…** and pick this folder (**Add Local…**) or its Git URL, then add the `ShowSeats` library to your app target.

Or in `Package.swift`:

```swift
.package(path: "../seatsdisplay")
// target dependencies:
.product(name: "ShowSeats", package: "ShowSeats")
```

## SwiftUI

```swift
import ShowSeats

ShowSeatsView(
    rows: 6,
    columns: 8,
    rowColors: [0: "#FF3B30", 1: "#FF3B30", 2: "#FF9500"],   // row index -> hex code
    nonClickableSeats: [SeatPosition(row: 0, column: 0), SeatPosition(row: 2, column: 3)]
) { seat in
    print("Tapped row \(seat.row), column \(seat.column), selected: \(seat.isSelected)")
}
```

Rows and columns are zero-based. Hex codes may be `RGB`, `RRGGBB` or `RRGGBBAA`, with or without `#`.

## Full configuration

```swift
let configuration = ShowSeatsConfiguration(
    rows: 10,
    columns: 12,
    rowColors: [0: "#FF3B30"],
    defaultColorHex: "#4A90E2",        // rows without an entry in rowColors
    nonClickableSeats: [SeatPosition(row: 4, column: 5)],
    nonClickableColorHex: "#C7C7CC",
    highlightsSelection: true,         // tap toggles the seat to selectedColorHex
    selectedColorHex: "#34C759",
    seatSize: CGSize(width: 32, height: 32),
    spacing: 8,
    cornerRadius: 6
)

ShowSeatsView(configuration: configuration) { seat in
    // handle tap
}
```

Set `highlightsSelection: false` if you only want the callback and no selected state.

## UIKit

```swift
let controller = ShowSeatsViewController(configuration: configuration) { seat in
    // handle tap
}
navigationController?.pushViewController(controller, animated: true)
```
# ShowSeats

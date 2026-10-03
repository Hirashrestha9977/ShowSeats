import SwiftUI

/// RGBA components in the 0...1 range parsed from a hex color code.
struct HexColor: Equatable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double

    /// Accepts `RGB`, `RRGGBB` and `RRGGBBAA`, with or without a leading `#`.
    init?(_ hex: String) {
        var digits = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if digits.hasPrefix("#") { digits.removeFirst() }
        if digits.count == 3 {
            digits = digits.map { "\($0)\($0)" }.joined()
        }
        guard digits.count == 6 || digits.count == 8,
              digits.allSatisfy(\.isHexDigit),
              let value = UInt64(digits, radix: 16) else { return nil }

        if digits.count == 8 {
            red = Double((value >> 24) & 0xFF) / 255
            green = Double((value >> 16) & 0xFF) / 255
            blue = Double((value >> 8) & 0xFF) / 255
            alpha = Double(value & 0xFF) / 255
        } else {
            red = Double((value >> 16) & 0xFF) / 255
            green = Double((value >> 8) & 0xFF) / 255
            blue = Double(value & 0xFF) / 255
            alpha = 1
        }
    }
}

extension Color {
    /// Returns `nil` when `hex` is not a valid color code.
    init?(seatHex hex: String) {
        guard let parsed = HexColor(hex) else { return nil }
        self.init(.sRGB, red: parsed.red, green: parsed.green, blue: parsed.blue, opacity: parsed.alpha)
    }
}

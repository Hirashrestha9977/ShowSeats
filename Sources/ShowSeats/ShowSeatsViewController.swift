#if canImport(UIKit)
import SwiftUI
import UIKit

/// UIKit entry point for apps that do not use SwiftUI.
public final class ShowSeatsViewController: UIHostingController<ShowSeatsView> {
    public init(configuration: ShowSeatsConfiguration, onSeatTap: @escaping (Seat) -> Void = { _ in }) {
        super.init(rootView: ShowSeatsView(configuration: configuration, onSeatTap: onSeatTap))
    }

    @available(*, unavailable)
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}
#endif

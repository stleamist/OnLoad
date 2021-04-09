import SwiftUI

struct FirstAppearanceActionModifier: ViewModifier {
    
    var action: (() -> Void)?
    
    @State private var didFirstAppear: Bool = false
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !didFirstAppear else { return }
                didFirstAppear = true
                action?()
            }
    }
}

public extension View {
    
    /// Adds an action to perform when this view appears for the first time.
    ///
    /// - Parameter action: The action to perform. If `action` is `nil`, the
    ///   call has no effect.
    ///
    /// - Returns: A view that triggers `action` when this view appears for the first time.
    func onFirstAppear(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(FirstAppearanceActionModifier(action: action))
    }
}

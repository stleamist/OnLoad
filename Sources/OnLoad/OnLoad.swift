import SwiftUI

#if os(iOS) || os(tvOS)
typealias ViewController = UIViewController
typealias ViewControllerRepresentable = UIViewControllerRepresentable
#elseif os(macOS)
typealias ViewController = NSViewController
typealias ViewControllerRepresentable = NSViewControllerRepresentable
#endif

class LoadingActionViewController: ViewController {
    
    var action: (() -> Void)?
    
    init(action: (() -> Void)?) {
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if os(macOS)
    override func loadView() {
        super.loadView()
        self.view = NSView()
    }
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        action?()
    }
}

struct LoadingActionView: ViewControllerRepresentable {
    
    var action: (() -> Void)?
    
    private func makeViewController(context: Context) -> LoadingActionViewController {
        return LoadingActionViewController(action: action)
    }
    
    private func updateViewController(_ viewController: LoadingActionViewController, context: Context) {
        viewController.action = action
    }
    
    #if os(iOS) || os(tvOS)
    
    func makeUIViewController(context: Context) -> LoadingActionViewController {
        return makeViewController(context: context)
    }
    
    func updateUIViewController(_ viewController: LoadingActionViewController, context: Context) {
        updateViewController(viewController, context: context)
    }
    
    #elseif os(macOS)
    
    func makeNSViewController(context: Context) -> LoadingActionViewController {
        return makeViewController(context: context)
    }

    func updateNSViewController(_ viewController: LoadingActionViewController, context: Context) {
        updateViewController(viewController, context: context)
    }
    
    #endif
}

struct LoadingActionModifier: ViewModifier {
    
    var action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content.background(
            LoadingActionView(action: action)
        )
    }
}

public extension View {
    
    /// Adds an action to perform when this view is loaded.
    ///
    /// - Parameter action: The action to perform. If `action` is `nil`, the
    ///   call has no effect.
    ///
    /// - Returns: A view that triggers `action` when this view is loaded.
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(LoadingActionModifier(action: action))
    }
}

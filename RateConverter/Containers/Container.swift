
import UIKit

class Container {
    static let shared = Container()
    var mainRootViewController: UIViewController?
}

// MARK: - AppDelegate Injection
extension Container {
    func inject() -> UIWindow? {
        guard let window = self.window() else { return nil }
        return window
    }
    
    func window() -> UIWindow? {
        let window = UIWindow(frame: self.screen().bounds)
        guard let rootVC = self.createMainRootViewController() else { return nil }
        window.rootViewController = rootVC
        return window
    }
    
    func screen() -> UIScreen {
        return UIScreen.main
    }
    
    func createMainRootViewController() -> UIViewController? {
        guard let currencyConverterListViewController = currencyListBuilder().buildCurrencyListModule() else {
            assert(false, "Root Module failed to build. Check your DI setup.")
            return nil
        }
        let converterListViewController = BaseNavigationController(rootViewController: currencyConverterListViewController)
        return converterListViewController
    }
}

extension Container {
    func sharedApplication() -> UIApplication {
        return UIApplication.shared
    }
}


import UIKit

class ConverterDefaultRouter: ConverterRouter {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

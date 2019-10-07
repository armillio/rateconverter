
import UIKit

class CurrencyListDefaultRouter: CurrencyListRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK - Navigation funcions
    
    func navigateToCurrencyConverter(_ baseCurrency: String, _ currencyToConvert: String){
        if let converterViewController = self.converterBuilder().buildConverterModule(withBaseCurrency: baseCurrency, withCurrency: currencyToConvert){
            converterViewController.modalPresentationStyle = .pageSheet
            self.viewController?.navigationController?.present(converterViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private
    
    fileprivate func converterBuilder() -> ConverterBuilder {
        return Container.shared.converterBuilder()
    }
}

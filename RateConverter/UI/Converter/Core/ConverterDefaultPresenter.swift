
import Foundation

// MARK: - Main Class
class ConverterDefaultPresenter: ConverterPresenter {
    private let interactorManager: ConverterInteractorManager
    private let router: ConverterRouter
    private weak var view: ConverterView?
    
    lazy var currencyConverter = CurrencyConverter()
    init(interactorManager: ConverterInteractorManager, router: ConverterRouter, view: ConverterView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }
    
    // MARK: - ConverterPresenter
    func convertCurrency(withAmount amount: String, from: String, to: String) {
        interactorManager.getConvertedValue(from: from, to: to, completion: { (result, error) in
            if error != nil {
                print("ERROR synchronizing with server")
            } else {
                if let newCurrencies = result {
                    print("Currencies fetched from server")
                    self.view?.displayConvertedCurrency(exchange: self.currencyConverter.convertRate(fromValue: amount, toValue: newCurrencies[0].value))
                }
            }
        })
    }
}


import UIKit

protocol ConverterBuilder {
    func buildConverterModule(withBaseCurrency baseCurrency: String, withCurrency currencyToConvert: String) -> UIViewController?
}

protocol ConverterInteractorManager {
    func getConvertedValue(from: String, to: String, completion: @escaping (_ response: [Currency]?, _ error: Error?) -> Void)
}

protocol ConverterPresenter {
    func convertCurrency(withAmount amount: String, from: String, to: String)
}

protocol ConverterView: class {
    func displayConvertedCurrency(exchange: String)
}

protocol ConverterRouter {
    
}

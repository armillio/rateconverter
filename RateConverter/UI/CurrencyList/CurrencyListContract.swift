
import UIKit

protocol CurrencyListBuilder {
    func buildCurrencyListModule() -> UIViewController?
}

protocol CurrencyListInteractorManager {
    func getCurrencyListData(_ base: String, completion: @escaping (_ response: [Currency]?, _ error: Error?) -> Void)
}

protocol CurrencyListPresenter {
    func loadCurrencyListData(_ base: String, fromRefresh refresh: Bool)
    func showCurrencyConverter(baseCurrency: String, currencyToConvert: String)
}

protocol CurrencyListView: class {
    func displayActivityIndicator()
    func displayCurrencyList(_ viewModel: CurrencyListViewModel)
    func displayEmptyScreen(withText text: String)
}

protocol CurrencyListRouter {
    func navigateToCurrencyConverter(_ baseCurrency: String, _ currencyToConvert: String)
}


import Foundation

struct CurrencyListViewModel {
    let currencyList: [Currency]
}

struct Currency {
    var symbol: String
    var value: Double
}

// MARK: - Main Class
class CurrencyListDefaultPresenter: CurrencyListPresenter {
    private let interactorManager: CurrencyListInteractorManager
    private let router: CurrencyListRouter
    private weak var view: CurrencyListView?
    
    private let viewModelBuilder = CurrencyListViewModelBuilder()
    private var viewModel: CurrencyListViewModel?
    
    init(interactorManager: CurrencyListInteractorManager, router: CurrencyListRouter, view: CurrencyListView) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
    }
    
    // MARK: - CurrencyListPresenter
    
    func loadCurrencyListData(_ base: String, fromRefresh refresh: Bool){
        interactorManager.getCurrencyListData(base, completion: { (result, error) in
            if error != nil {
                self.view?.displayEmptyScreen(withText: "ERROR synchronizing with server")
            } else {
                if let newCurrencies = result {
                    let viewModel = self.viewModelBuilder.buildViewModel(withCurrencyList: newCurrencies)
                    self.viewModel = viewModel
                    self.view?.displayCurrencyList(viewModel)
                    print("Currencies fetched from server")
                }
            }
        })
    }
    
    func showCurrencyConverter(baseCurrency: String, currencyToConvert: String){
        router.navigateToCurrencyConverter(baseCurrency, currencyToConvert)
    }
}

// MARK: - Model Builder
class CurrencyListViewModelBuilder {
    func buildViewModel(withCurrencyList currencyList:[Currency]) -> CurrencyListViewModel {
        return CurrencyListViewModel(currencyList: currencyList)
    }
}

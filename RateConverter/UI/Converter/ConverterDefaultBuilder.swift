
import UIKit

class ConverterDefaultBuilder: ConverterBuilder {
    var router: ConverterRouter?
    var interactorManager: ConverterInteractorManager?
    var presenter: ConverterPresenter?
    var view: ConverterView?

    // MARK: - ConverterBuilder protocol
    func buildConverterModule(withBaseCurrency baseCurrency: String, withCurrency currencyToConvert: String) -> UIViewController?  {
        buildView(withBaseCurrency: baseCurrency, withCurrency: currencyToConvert)
        buildRouter()
        buildInteractor()
        buildPresenter()
        buildCircularDependencies()
        return view as? UIViewController
    }

    // MARK: - Private
    private func buildView(withBaseCurrency baseCurrency: String, withCurrency currencyToConvert: String) {
        view = ConverterViewController(withBaseCurrency: baseCurrency, withCurrency: currencyToConvert)
    }

    private func buildRouter() {
        guard let view = self.view as? UIViewController else {
            assert(false, "View has to be a UIViewController")
            return
        }
        router = ConverterDefaultRouter(viewController: view)
    }

    private func buildInteractor() {
        interactorManager = ConverterDefaultInteractorManager() // TODO: set dependencies in init (use case/s, services...)
    }

    private func buildPresenter() {
        guard let interactorManager = interactorManager, let router = router, let view = view else {
            assert(false, "No dependencies available")
            return
        }
        presenter = ConverterDefaultPresenter(interactorManager: interactorManager, router: router, view: view)
    }

    private func buildCircularDependencies() {
        guard let presenter = presenter, let view = view as? ConverterViewController else {
            assert(false, "No dependencies available")
            return
        }
        view.presenter = presenter
    }
}

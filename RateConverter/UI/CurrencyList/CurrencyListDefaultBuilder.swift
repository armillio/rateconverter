
import UIKit

class CurrencyListDefaultBuilder: CurrencyListBuilder {
    var router: CurrencyListRouter?
    var interactorManager: CurrencyListInteractorManager?
    var presenter: CurrencyListPresenter?
    var view: CurrencyListView?

    // MARK: - CurrencyListBuilder protocol
    func buildCurrencyListModule() -> UIViewController? {
        buildView()
        buildRouter()
        buildInteractor()
        buildPresenter()
        buildCircularDependencies()
        return view as? UIViewController
    }

    // MARK: - Private
    private func buildView() {
        view = CurrencyListViewController()
    }

    private func buildRouter() {
        guard let view = self.view as? UIViewController else {
            assert(false, "View has to be a UIViewController")
            return
        }
        router = CurrencyListDefaultRouter(viewController: view)
    }

    private func buildInteractor() {
        interactorManager = CurrencyListDefaultInteractorManager() // TODO: set dependencies in init (use case/s, services...)
    }

    private func buildPresenter() {
        guard let interactorManager = interactorManager, let router = router, let view = view else {
            assert(false, "No dependencies available")
            return
        }
        presenter = CurrencyListDefaultPresenter(interactorManager: interactorManager, router: router, view: view)
    }

    private func buildCircularDependencies() {
        guard let presenter = presenter, let view = view as? CurrencyListViewController else {
            assert(false, "No dependencies available")
            return
        }
        view.presenter = presenter
    }
}

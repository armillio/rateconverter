

import UIKit

class CurrencyListViewController: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: CurrencyListPresenter?
    var viewModel: CurrencyListViewModel?
    var didPickerReload = false
    
    lazy var isoConverter = ISOConverter()
    
    var baseCurrency:String?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        configurePickerView()
        
        presenter?.loadCurrencyListData("BGN", fromRefresh: false)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        guard let baseCurrency = self.baseCurrency else{ return }
        presenter?.loadCurrencyListData(baseCurrency, fromRefresh: true)
    }
    
    // MARK: - Configuration
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerNibs()
        tableView.addSubview(refreshControl)
    }
    
    fileprivate func registerNibs() {
        tableView.registerNib(CurrencyTableViewCell.self)
    }
    
    fileprivate func configurePickerView() {
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func configureNavigationBar() {
        navigationItem.title = "Currency Converter"
    }
}

// MARK: - CurrencyListView
extension CurrencyListViewController: CurrencyListView {
    func displayCurrencyList(_ viewModel: CurrencyListViewModel) {
        DispatchQueue.main.async {
            if self.activityIndicator.isAnimating {
                self.activityIndicator.stopAnimating()
            }
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.viewModel = viewModel
            self.tableView.reloadData()
            self.tableView.scrollsToTop = true
            
            if !self.didPickerReload {
                self.didPickerReload = true
                self.pickerView.reloadAllComponents()
            }
        }
    }
    
    func displayActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func displayEmptyScreen(withText text: String ) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.viewModel = nil
            self.showEmptyMessage(withText: text)
        }
    }
    
    fileprivate func showEmptyMessage(withText text: String) {
        let contentView = UIView(frame: CGRect(x: 0, y: 55.0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        let noResultLabel = UILabel(frame: CGRect(x: 0, y: 55.0, width: tableView.bounds.size.width, height: 60))
        noResultLabel.text = text
        noResultLabel.textColor = UIColor.darkGray
        noResultLabel.textAlignment = .center
        contentView.addSubview(noResultLabel)
        tableView.backgroundView = contentView
    }
}

extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.currencyList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.cellIdentifier(), for: indexPath)
    }
}

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CurrencyTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let currencyArray = viewModel?.currencyList, let cell = cell as? CurrencyTableViewCell else { return }
        if indexPath.row < currencyArray.count {
            cell.configure(currencyArray[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let baseCurrency = self.baseCurrency else{ return }
        guard let selectedCurrency = viewModel?.currencyList[indexPath.row].symbol else { return }
        presenter?.showCurrencyConverter(baseCurrency: baseCurrency, currencyToConvert: selectedCurrency)
    }
}

extension CurrencyListViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.view.safeAreaLayoutGuide.layoutFrame.width * 0.75
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard let currencyArray = viewModel?.currencyList else { return UIView() }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width - 30, height: 60))
        
        let convertCode = isoConverter.convertCode(currencyArray[row])
        let symbol = currencyArray[row].symbol
        
        if(convertCode != ""){
            if row == 0 {
                self.baseCurrency = symbol
            }
            
            let flagView = UIImageView(frame: CGRect(x: 20, y: 20, width: 21, height: 15))
            flagView.image = UIImage(named: convertCode)
            
            let label = UILabel(frame: CGRect(x: 60, y: 0, width: pickerView.bounds.width - 90, height: 60 ))
            label.font = UIFont.systemFont(ofSize: 20)
            label.text = symbol
            label.textColor = UIColor.white
            
            view.addSubview(flagView)
            view.addSubview(label)

        }else{
            
        }
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let baseCurrency = viewModel?.currencyList[row].symbol else{ return }
        self.baseCurrency = baseCurrency
        presenter?.loadCurrencyListData(baseCurrency, fromRefresh: true)
    }
}

extension CurrencyListViewController: UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.currencyList.count ?? 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}

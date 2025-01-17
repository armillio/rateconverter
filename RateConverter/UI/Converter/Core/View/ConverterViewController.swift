
import UIKit

class ConverterViewController: UIViewController {
    @IBOutlet weak var baseTextField: UITextField!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var converterLabel: UILabel!
    @IBOutlet weak var converterTextField: UITextField!
    
    private var textMaxLength = 10
    
    var presenter: ConverterPresenter?
    
    lazy var currencyConverter = CurrencyConverter()
    
    var baseCurrency:String?
    var currencyToConvert:String?
    var baseRateValue: Double?
    
    convenience init(withBaseCurrency baseCurrency: String, withCurrency currencyToConvert: String) {
        self.init(nibName: nil, bundle: nil)
        self.baseCurrency = baseCurrency
        self.currencyToConvert = currencyToConvert
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        baseTextField.becomeFirstResponder()
        guard let baseCurrency = self.baseCurrency else{ return }
        guard let currencyToConvert = self.currencyToConvert else{ return }
        guard let amount = self.baseTextField.text else{ return }
        presenter?.convertCurrency(withAmount: amount, from: baseCurrency, to:currencyToConvert)
    }
    
    func configureUI(){
        baseLabel.text = self.baseCurrency?.uppercased()
        converterLabel.text = self.currencyToConvert?.uppercased()
        baseTextField.delegate = self
    }
}

// MARK: - CurrencyConverterView
extension ConverterViewController: ConverterView {
    func updateRateValue(rate: Double){
        self.baseRateValue = rate
    }
    
    func displayConvertedCurrency(exchange: String){
        DispatchQueue.main.async {
            self.converterTextField.text = exchange
        }
    }
}

extension ConverterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        guard let baseTextField = self.baseTextField.text else{ return false }
        guard let rateValue = self.baseRateValue else{ return false }
        self.converterTextField.text = self.currencyConverter.convertRate(fromValue: baseTextField, toValue: rateValue)
        
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        
        guard let baseTextField = self.baseTextField.text else{ return false }
        guard let rateValue = self.baseRateValue else{ return false }
        self.converterTextField.text = self.currencyConverter.convertRate(fromValue: baseTextField, toValue: rateValue)
        
        return newLength <= textMaxLength
    }
}

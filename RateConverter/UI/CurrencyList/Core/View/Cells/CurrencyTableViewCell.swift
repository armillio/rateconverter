
import UIKit

class CurrencyTableViewCell: UITableViewCell, UITableViewCellStaticProtocol {
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var contryCode: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    
    var isoConverter = ISOConverter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func cellHeight() -> CGFloat {
        return 52.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ currency: Currency){
        self.contryCode.text = currency.symbol
        self.currencyValue.text = String.init(format: "%.2f",  currency.value)
        let convertCode = isoConverter.convertCode(currency)
        if(convertCode != ""){
            self.imageView?.image = UIImage.init(named: convertCode)
        }
    }
}

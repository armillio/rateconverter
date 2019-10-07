
import Foundation

final class ISOConverter: NSObject {
    
    func convertCode(_ currency: Currency) -> String{
        var defaultCurrency = ""
        
        let value:[IsoCountryInfo] = IsoCountryCodes.searchByCurrency(currency.symbol)
        if value.count > 0 {
            var countryCode = value[0].alpha2
            switch currency.symbol {
            case "USA":
                countryCode = "US"
                break
            case "AUD":
                countryCode = "AU"
                break
            case "EUR":
                countryCode = "EU"
                break
            default:
                countryCode = value[0].alpha2
            }
            defaultCurrency = countryCode
        }
        
        return defaultCurrency
    }
}

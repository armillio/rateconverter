
import Foundation

final class CurrencyConverter: NSObject {
    
    func convertRate(fromValue: String, toValue: Double) -> String{
        let from = Double(fromValue) ?? 1.00
        let converted = from * toValue
        return String.init(format: "%.2f", converted)
    }
}

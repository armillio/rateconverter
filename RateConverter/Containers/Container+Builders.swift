
import Foundation

// MARK: - Builders Injection
extension Container {

    func currencyListBuilder() -> CurrencyListBuilder {
        return CurrencyListDefaultBuilder()
    }
    
    func converterBuilder() -> ConverterBuilder {
        return ConverterDefaultBuilder()
    }
}

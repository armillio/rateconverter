
import Foundation

struct rates: Decodable {
    var date: String
    var base: String
    var rates: [String: Double]
}

class CurrencyListDefaultInteractorManager: CurrencyListInteractorManager {
    func getCurrencyListData(_ base: String, completion: @escaping (_ response: [Currency]?, _ error: Error?) -> Void){
        let frankfurterURL = ApplicationConstants.frankfurterURL
            + "latest?from="+base
        
        guard let url = URL(string: frankfurterURL) else { return  }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil, let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200, let data = data else { return }
            
            do {
                let fixerRates = try JSONDecoder().decode(rates.self, from: data)
                var currencyList = Array<Currency>()
                let keys = fixerRates.rates.keys.sorted()
                for key in keys {
                    guard let value = fixerRates.rates[key] else { continue }
                    let currency = Currency.init(symbol: key, value: value)
                    currencyList.append(currency)
                }
                
                completion(currencyList, nil)
            }
            catch {
                completion(nil, error)
            }
        }.resume()
    }
}

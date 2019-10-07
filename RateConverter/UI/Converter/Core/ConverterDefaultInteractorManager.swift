
import Foundation

class ConverterDefaultInteractorManager: ConverterInteractorManager {

    func getConvertedValue(from: String, to: String, completion: @escaping (_ response: [Currency]?, _ error: Error?) -> Void){
        let frankfurterURL = ApplicationConstants.frankfurterURL
            + "/latest?from=" + from
            + "&to=" + to

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
    /*
    func convert(withAmount amount: String, , completion: @escaping (_ response: [[String: AnyObject]]?, _ error: Error?) -> Void) {
        let fixerURL = ApplicationConstants.fixerURL
            + "convert?access_key=" + ApplicationConstants.fixerAPIKey
        
        guard let url = URL(string: fixerURL) else {
            completion(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data,
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                    let results = jsonObject["result"] as? [[String: AnyObject]] {
                    completion(results, nil)
                } else {
                    completion(nil, error)
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
 */
}

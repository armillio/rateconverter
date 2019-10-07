
import Foundation

class CurrencyListDefaultInteractorManager: CurrencyListInteractorManager {
    private let frankfurterHTTPRequest = FrankfurterHTTPRequestDefault()
    
    func getCurrencyListData(_ base: String, completion: @escaping ([Currency]?, Error?) -> Void) {
        frankfurterHTTPRequest.fetchCurrencyListData(base) { (currencyList, error) in
            if let currencyList = currencyList, currencyList.count > 0 {
                completion(currencyList, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}

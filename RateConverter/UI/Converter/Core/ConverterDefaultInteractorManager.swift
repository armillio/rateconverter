
import Foundation

class ConverterDefaultInteractorManager: ConverterInteractorManager {
    private let frankfurterHTTPRequest = FrankfurterHTTPRequestDefault()
    
    func getConvertedValue(from: String, to: String, completion: @escaping (_ response: [Currency]?, _ error: Error?) -> Void){
        
        frankfurterHTTPRequest.fetchConvertedValue(from: from, to: to, completion: { (currencyList, error) in
            if let currencyList = currencyList, currencyList.count > 0 {
                completion(currencyList, nil)
            } else {
                completion(nil, error)
            }
        })
    }
}

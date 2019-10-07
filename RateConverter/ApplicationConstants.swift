
import Foundation

struct ApplicationConstants {

    #if DEBUG // DEVELOPMENT
    static let endpoint: Environment = .development
    #elseif RELEASE // APPSTORE
    static let endpoint: Environment = .production
    #endif
    static let APIBaseURL = endpoint.baseURL
    static let APIVersion = endpoint.version
    static let APIPublicKey = endpoint.publicKey
    static let APISecretKey = endpoint.secretKey
    static let fixerAPIKey = endpoint.fixerAPIKey
    static let fixerURL = endpoint.fixerURL
    static let frankfurterURL = endpoint.frankfurterURL
}

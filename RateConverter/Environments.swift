
import Foundation

enum Environment {
    case development
    case production

    var description: String {
        switch self {
        case .development:
            return "Development"
        case .production:
            return "Production"
        }
    }

    var baseURL: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }

    var version: String {
        return "1.0"
    }

    var frankfurterURL: String {
        switch self {
        case .development:
            return "https://frankfurter.app/"
        case .production:
            return "https://frankfurter.app/"
        }
    }
    
    var fixerAPIKey: String {
        switch self {
        case .development:
            return "b8b9def95eb0b764987c80e63ae538bc"
        case .production:
            return "b8b9def95eb0b764987c80e63ae538bc"
        }
    }

    var fixerURL: String {
        switch self {
        case .development:
            return "http://data.fixer.io/api/"
        case .production:
            return "http://data.fixer.io/api/"
        }
    }
    
    var publicKey: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }

    var secretKey: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }
}

import Foundation
import Moya

enum API {
//user
    case login(id: String, password: String)
    case signup(name: String, id: String, password: String, phoneNumber: String)

//auth
    case sendNumber(number: String)

//post
    case getCommunity
    
//offer
    case getOffer
}

extension API: TargetType {

    var baseURL: URL {
        return URL(string: "http://172.20.10.2:8080")!
    }
    var path: String {
        switch self {
        case .login:
            return "/user/signin"
        case .signup:
            return "/user/signup"

        case .sendNumber:
            return "/auth/sms"

        case .getCommunity:
            return "/post"

        case .getOffer:
            return "/offer"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .signup, .sendNumber:
            return .post
        case .getCommunity, .getOffer:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .login(let id, let password):
            return .requestParameters(parameters:
                                        [
                                            "accountId": id,
                                            "password": password
                                        ], encoding: JSONEncoding.default)
        case .signup(let name, let id, let password, let number):
            return .requestParameters(parameters:
                                        [
                                            "nickname": name,
                                            "accountId": id,
                                            "password": password,
                                            "phoneNumber": number
                                        ], encoding: JSONEncoding.default)
        case .sendNumber(let number):
            return .requestParameters(parameters: [
                                                    "phoneNumber": number
                                                  ],
                                      encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login, .signup, .sendNumber:
            return Header.tokenIsEmpty.header()
        case .getCommunity, .getOffer:
            return Header.accessToken.header()

        }
    }
}

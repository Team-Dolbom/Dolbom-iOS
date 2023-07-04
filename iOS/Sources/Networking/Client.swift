import Foundation
import Moya

enum API {
//user
    case login(id: String, password: String)
    case signup(name: String, id: String, password: String, number: String)
}

extension API: TargetType {

    var baseURL: URL {
        return URL(string: "~~")!
    }
    var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .signup:
            return "/user/signup"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .signup:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .login(let id, let password):
            return .requestParameters(parameters:
                                        [
                                            "ID": id,
                                            "PW": password
                                        ], encoding: JSONEncoding.default)
        case .signup(let name, let id, let password, let number):
            return .requestParameters(parameters:
                                        [
                                            "name": name,
                                            "ID": id,
                                            "PW": password,
                                            "phoneNumber": number
                                        ], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login, .signup:
            return Header.tokenIsEmpty.header()
        }
    }
}

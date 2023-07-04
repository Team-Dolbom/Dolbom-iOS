import Foundation
import RxSwift
import RxCocoa
import RxMoya
import Moya

final class Service {
    let provider = MoyaProvider<API>(plugins: [MoyaLoggingPlugin()])
    func login(_ id: String, _ password: String) -> Single<NetworkingResult> {
        return provider.rx.request(.login(id: id, password: password))
            .filterSuccessfulStatusCodes()
            .map(TokenModel.self)
            .map {response -> NetworkingResult in
                Token.accessToken = response.accessToken
                Token.refreshToken = response.refreshToken
                return .okay
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
        
    }
    func signup(_ name: String, _ id: String, _ password: String, _ number: String) -> Single<NetworkingResult> {
        return provider.rx.request(.signup(
            name: name,
            id: id,
            password: password,
            number: number
        ))
        .filterSuccessfulStatusCodes()
        .map { _ -> NetworkingResult in
            return .created
        }
        .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func setNetworkError(_ error: Error) -> NetworkingResult {
        print(error)
        print(error.localizedDescription)
        guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
        return (NetworkingResult(rawValue: status) ?? .fault)
    }
}

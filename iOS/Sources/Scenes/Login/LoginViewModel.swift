import UIKit
import RxCocoa
import RxSwift

class LoginViewModel: BaseViewModel {
    private let disposebag = DisposeBag()

    struct Input {
        let idText: Driver<String>
        let passwordText: Driver<String>
        let loginButtonDidTap: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let service = Service()
        let info = Driver.combineLatest(input.idText, input.passwordText)
        let result = PublishRelay<Bool>()
        input.loginButtonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap { id, password in
                service.login(id, password)
            }.subscribe(onNext: { res in
                switch res {
                case .okay:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposebag)
        return Output(result: result)
    }
}

import Foundation
import RxSwift
import RxCocoa

class SignupViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()


    struct Input {
        let nameText: Driver<String>
        let idText: Driver<String>
        let passwortText: Driver<String>
        let checkPasswordText: Driver<String>
        let numberText: Driver<String>
        let signupButtonDidTap: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>

    }

    func transform(_ input: Input) -> Output {
        let service = Service()
        let result = PublishRelay<Bool>()
        let info = Driver.combineLatest(input.nameText, input.idText, input.passwortText, input.numberText)

        input.signupButtonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap { name, id, password, number in
                service.signup(name, id, password, number)
            }.subscribe(onNext: { res in
                switch res {
                case .created:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
            
        return Output(result: result)
    }
}

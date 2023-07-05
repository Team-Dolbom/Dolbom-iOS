import Foundation
import RxCocoa
import RxSwift

class NumberCheckViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()

    struct Input {
        let numberText: Driver<String>
        let codenumber: Driver<String>
        let nextButtonDidTaped: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
        let codeNumber: PublishRelay<String>
    }
    func transform(_ input: Input) -> Output {
        let service = Service()
        let result = PublishRelay<Bool>()
        let codeNumber = PublishRelay<String>()

        input.nextButtonDidTaped
            .asObservable()
            .withLatestFrom(input.numberText)
            .flatMap { number in
                service.sendNumber(number)
            }.subscribe(onNext: { code, res in
                switch res {
                case .okay:
                    result.accept(true)
                    codeNumber.accept(code?.code ?? "")
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(result: result, codeNumber: codeNumber)
    }

}

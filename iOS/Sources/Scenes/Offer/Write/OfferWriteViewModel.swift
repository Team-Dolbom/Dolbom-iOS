import Foundation
import RxCocoa
import RxSwift


class OfferWriteViewModel: BaseViewModel {
    let disposeBag = DisposeBag()
    struct Input {
        let isBabySitter: Bool
        let titleText: Driver<String>
        let contentText: Driver<String>
        let introText: Driver<String>
        let completeButtonDidTaped: Signal<Void>
        
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let service = Service()
        let result = PublishRelay<Bool>()
        let info = Driver.combineLatest(input.titleText, input.contentText, input.introText)
        
        input.completeButtonDidTaped
            .asObservable()
            .withLatestFrom(info)
            .flatMap { title, content, intro in
                service.writeOffer(input.isBabySitter, title, content, intro)
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

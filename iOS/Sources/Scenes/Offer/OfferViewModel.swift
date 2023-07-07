import Foundation
import RxSwift
import RxCocoa

class OfferViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    struct Input {
        let offerList: PublishRelay<Void>
    }
    struct Output {
        let list: BehaviorRelay<[Offer]>
    }
    func transform(_ input: Input) -> Output {
        let service = Service()
        let list =  BehaviorRelay<[Offer]>(value: [])
        input.offerList.asObservable()
            .flatMap { service.getOffer() }
            .subscribe(onNext: { data, res in
                switch res {
                case .okay:
                    list.accept(data!.offerList)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(list: list)
    }
}

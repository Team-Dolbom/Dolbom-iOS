import Foundation
import RxSwift
import RxCocoa

class CommunityViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()

    struct Input {
        let communityList: Signal<Void>
    }
    struct Output {
        let communityList: BehaviorRelay<[Post]>
    }

    func transform(_ input: Input) -> Output {
        let service = Service()
        let communityList =  BehaviorRelay<[Post]>(value: [])
        input.communityList.asObservable()
            .flatMap { service.getCommunity() }
            .subscribe(onNext: { data, res in
                switch res {
                case .okay:
                    communityList.accept(data!.postList)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(communityList: communityList)
    }
}

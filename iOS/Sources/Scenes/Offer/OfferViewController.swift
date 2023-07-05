import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class OfferViewController: BaseViewController {

    let offerTableView = UITableView().then {
        $0.register(OfferTableViewCell.self, forCellReuseIdentifier: "OfferTableViewCell")
        $0.rowHeight = 93
        $0.separatorStyle = .none
    }
    override func addView() {
        [offerTableView].forEach {view.addSubview($0)}
    }
    override func setLayout() {
        offerTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.leading.trailing.equalToSuperview().inset(0)
            $0.height.equalTo(700)
        }
    }
    
}

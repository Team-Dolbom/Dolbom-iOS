import UIKit
import Then
import SnapKit

class OfferDetailViewController: BaseViewController {

    let categoryView = UIView().then {
        $0.backgroundColor = UIColor(named: "Main")
        $0.layer.cornerRadius = 2
    }
    var categoryLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 6, weight: .light)
    }
    var titleTextLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    var detailLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        $0.textColor = UIColor(named: "CellTextColor")
    }
    
}

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class CommunityViewController: UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    let communityTableView = UITableView().then {
        $0.register(CommunityTableViewCell.self, forCellReuseIdentifier: "CommunityTableViewCell")
        $0.rowHeight = 93
    }
}

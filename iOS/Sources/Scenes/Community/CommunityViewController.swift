import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class CommunityViewController: BaseViewController {
    let viewModel = CommunityViewModel()
    let communityList = PublishRelay<Void>()

    let communityLabel = UILabel().then {
        $0.text = "커뮤니티"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .medium)
    }
    let communityTableView = UITableView().then {
        $0.register(CommunityTableViewCell.self, forCellReuseIdentifier: "CommunityTableViewCell")
        $0.rowHeight = 93
        $0.separatorStyle = .none
    }
    let writeButton = UIButton(type: .system).then {
        $0.setTitle("+글쓰기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor(named: "Main")
    }
    override func configureVC() {
        communityTableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        communityList.accept(())
    }
    override func bind() {
        let input = CommunityViewModel.Input(communityList: communityList.asSignal())
        let output = viewModel.transform(input)
        output.communityList.bind(to: communityTableView.rx.items(
            cellIdentifier: "CommunityTableViewCell",
            cellType: CommunityTableViewCell.self
        )) { _, item, cell in
            cell.checkLabel.text = "\(item.view)"
            cell.detailLabel.text = item.content
            cell.fieldText.text = item.category
            cell.postId = item.id
            cell.titleLabel.text = item.title
            cell.zoneLabel.text = item.region
        }.disposed(by: disposeBag)
    }

    override func addView() {
        [
            communityLabel,
            communityTableView
        ].forEach {view.addSubview($0)}
    }
    override func setLayout() {
        communityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(71)
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(260)
            $0.height.equalTo(44)
        }
        communityTableView.snp.makeConstraints {
            $0.top.equalTo(communityLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(0)
            $0.height.equalTo(650)
        }
    }
}

extension CommunityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        default:
            navigationController?.pushViewController(DetailViewController(), animated: true)
        }

    }
}

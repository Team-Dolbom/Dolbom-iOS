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

    override func configureVC() {
        communityTableView.delegate = self
        communityTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        communityList.accept(())
    }

    override func bind() {
        let input = CommunityViewModel.Input(communityList: communityList.asSignal(onErrorJustReturn: ()))
        let output = viewModel.transform(input)
        output.communityList.bind(to: communityTableView.rx.items(
            cellIdentifier: "CommunityTableViewCell",
            cellType: CommunityTableViewCell.self)
        ) { _, item, cell in
            cell.zoneLabel.text = "\(item.region)"
            cell.checkLabel.text = item.view
            cell.titleLabel.text = item.title
        }
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

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CommunityTableViewCell",
            for: indexPath) as? CommunityTableViewCell else { return UITableViewCell() }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        default:
            navigationController?.pushViewController(DetailViewController(), animated: true)
        }

    }
}

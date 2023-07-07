import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class OfferViewController: BaseViewController {
    let offerList = PublishRelay<Void>()
    let viewModel = OfferViewModel()

    let offerTableView = UITableView().then {
        $0.register(OfferTableViewCell.self, forCellReuseIdentifier: "OfferTableViewCell")
        $0.rowHeight = 93
        $0.separatorStyle = .none
    }
    let offerButton = UIButton().then {
        $0.setTitle("+ 글쓰기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(named: "Main")
    }
    override func configureVC() {
        let viewController = OfferWriteViewController()
        offerTableView.delegate = self
        offerButton.rx.tap
            .bind {
                let viewController = OfferWriteViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
            }.disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        offerList.accept(())
    }

    override func bind() {
        let viewController = OfferWriteViewController()

        let input = OfferViewModel.Input(offerList: offerList)
        let output = viewModel.transform(input)

        output.list.bind(to: offerTableView.rx.items(
            cellIdentifier: "OfferTableViewCell",
            cellType: OfferTableViewCell.self
        )) { _, item, cell in
            cell.checkLabel.text = " 조회 \(item.view)"
            cell.detailLabel.text = item.content
            cell.postId = item.id
            cell.titleLabel.text = item.title
            cell.zoneLabel.text = item.region
            cell.fieldText.text = item.babySitter ? "돌보미": "부모"
        }.disposed(by: disposeBag)
    }
    override func addView() {
        [
         offerTableView,
         offerButton
        ].forEach {view.addSubview($0)}
    }
    override func setLayout() {
        offerTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.leading.trailing.equalToSuperview().inset(0)
            $0.height.equalTo(650)
        }
        offerButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(704)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
            $0.width.equalTo(100)
        }
    }
}

extension OfferViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        default:
            navigationController?.pushViewController(DetailViewController(), animated: true)
            
        }

    }
}

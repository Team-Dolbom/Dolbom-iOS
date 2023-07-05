import UIKit
import SnapKit
import Then

class CommunityTableViewCell: UITableViewCell {

    var postId = 0
    var fieldView = UIView().then {
        $0.backgroundColor = UIColor(named: "Main")
        $0.layer.cornerRadius = 2
    }
    var fieldText = UILabel().then {
//        $0.text = "육아"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 6, weight: .light)
    }
    var titleLabel = UILabel().then {
//        $0.text = "고민입니다"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    var detailLabel = UILabel().then {
//        $0.text = "저는 교대근무를 하는데 어쩌구 저쩌구 ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ"
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        $0.textColor = UIColor(named: "CellTextColor")
    }
    var zoneLabel = UILabel().then {
//        $0.text = "대전 ⋅0"
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        $0.textColor = UIColor(named: "CellTextColor")
    }
    var checkLabel = UILabel().then {
//        $0.text = "조회 430"
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        $0.textColor = UIColor(named: "CellTextColor")
    }
    var bottomLine = UIView().then {
        $0.backgroundColor = UIColor(named: "LineColor")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview()
        setLayout()
    }
    func addSubview() {
        [
            fieldView,
            fieldText,
            titleLabel,
            detailLabel,
            zoneLabel,
            checkLabel,
            bottomLine
        ].forEach {self.addSubview($0)}
    }
    func setLayout() {
        fieldView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().inset(17)
            $0.height.equalTo(10)
            $0.width.equalTo(30)
        }
        fieldText.snp.makeConstraints {
            $0.center.equalTo(fieldView)
            $0.height.equalTo(6)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(fieldView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(17)
            $0.height.equalTo(16)
        }
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(17)
            $0.height.equalTo(20)
        }
        zoneLabel.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(17)
            $0.height.equalTo(13)
        }
        checkLabel.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(7)
            $0.leading.equalTo(zoneLabel.snp.trailing).offset(0)
            $0.height.equalTo(13)
        }
        bottomLine.snp.makeConstraints {
            $0.top.equalTo(checkLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
    }
}

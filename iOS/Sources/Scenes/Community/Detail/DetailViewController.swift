import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class DetailViewController: BaseViewController {
    private let categoryLabel = UILabel().then {
        $0.text = "돌보미"
        $0.textAlignment = .center
        $0.backgroundColor = UIColor(named: "Main")
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    }
    let titleLabel = UITextView().then {
        $0.text = "정성 가득한 아이 돌보미, 아이들과 소중한 추억 만들어드립니다"
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    let contentLabel = UITextView().then {
        $0.text = "안녕하세요, 부모님! 저는 애정과 책임감으로 아이들과 함께 성장하고자 하는 아이 돌보미입니다.\n\n귀중한 아이들에게 안전한 돌봄 환경과 행복한 경험을 제공하며, 그들과 소통하고 이해하는 데 최선을 다하겠습니다.\n\n함께 성장하며 소중한 추억을 만들어 가겠습니다.\n감사합니다."
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    private let categoryInfoLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.text = "돌보미 정보"
    }
    let introLabel = UITextView().then {
        $0.text = "이름:박지영\n경력: 3년 차 아이 돌보미\n자격증: 유아교육자격증, 심리학 전문가\n연락처: 010-9876-5432\n감사합니다."
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    let applicationButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(named: "Main")
        $0.layer.cornerRadius = 12
        $0.setTitle("신청", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }

    override func addView() {
        [
            categoryLabel,
            titleLabel,
            contentLabel,
            categoryInfoLabel,
            introLabel
//            applicationButton
        ].forEach {
            view.addSubview($0)
        }
    }
    override func setLayout() {
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(105)
            $0.leading.equalToSuperview().inset(32)
            $0.width.equalTo(46)
            $0.height.equalTo(26)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(102)
        }
        contentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.height.equalTo(275)
        }
        categoryInfoLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(32)
        }
        introLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.top.equalTo(categoryInfoLabel.snp.bottom).offset(10)
            $0.height.equalTo(125)
        }
    }
}

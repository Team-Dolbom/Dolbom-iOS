import UIKit
import SnapKit
import Then

class MyPageViewController: BaseViewController {
    
    let profileImageView = UIImageView().then {
        $0.image = UIImage(systemName: "person.crop.circle")
        $0.backgroundColor = .white
        $0.tintColor = UIColor(named: "TabbarColor")

    }
    let nickName = UILabel().then {
        $0.text = "qwer1234"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    let licensButton = UIButton().then {
        $0.setTitle("자격증 등록", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(named: "Main")
    }
    let logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.backgroundColor = UIColor(named: "GrayTextField")
        $0.layer.cornerRadius = 20
    }
    override func addView() {
        [
            profileImageView,
            nickName,
            licensButton,
            logoutButton
        ].forEach { view.addSubview($0)}
    }
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(173)
            $0.leading.equalToSuperview().inset(146)
            $0.width.height.equalTo(100)
        }
        nickName.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(7)
            $0.centerX.equalToSuperview().inset(170)
            $0.height.equalTo(24)
        }
        licensButton.snp.makeConstraints {
            $0.top.equalTo(nickName.snp.bottom).offset(196)
            $0.leading.trailing.equalToSuperview().inset(42)
            $0.height.equalTo(66)
        }
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(licensButton.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(42)
            $0.height.equalTo(66)
        }
    }
}

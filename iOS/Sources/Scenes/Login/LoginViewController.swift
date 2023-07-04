import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {

    let viewModel = LoginViewModel()

    let logoTitle = UILabel().then {
        $0.text = "돌봄"
        $0.font = UIFont.systemFont(ofSize: 64, weight: .bold)
    }
    let idTextField = UITextField().then {
        $0.placeholder = "아이디"
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(named: "GrayTextField")
        $0.addLeftPadding()
    }
    let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(named: "GrayTextField")
        $0.addLeftPadding()
    }
    let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(named: "Enabled")
    }

    override func bind() {
        let input = LoginViewModel.Input(
            idText: idTextField.rx.text.orEmpty.asDriver(),
            passwordText: passwordTextField.rx.text.orEmpty.asDriver(),
            loginButtonDidTap: loginButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                  self.navigationController?.pushViewController(CommunityViewController(), animated: true)
                  print("성공")
            case false:
                print("실패")

            }
        }).disposed(by: disposeBag)
        
    }

    override func setLayout() {
        logoTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(235)
            $0.leading.trailing.equalToSuperview().inset(137)
            $0.height.equalTo(77)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(logoTitle.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(41)
            $0.height.equalTo(66)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(41)
            $0.height.equalTo(66)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(61)
        }
    }
    override func addView() {
        [
            logoTitle,
            idTextField,
            passwordTextField,
            loginButton
        ].forEach {view.addSubview($0)}
    }
}

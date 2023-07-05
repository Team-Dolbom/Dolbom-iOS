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
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(named: "Enabled")
    }
    let signupLabel = UILabel().then {
        $0.text = "아직 회원이 아니신가요?"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
        $0.textColor = .gray
    }
    let signupButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
    }
    override func configureVC() {
        let signupView = NumberCheckViewController()
        signupButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(signupView, animated: true)
            }.disposed(by: disposeBag)
        idTextField.addTarget(self, action: #selector(idTextFieldDidChanged), for: .editingChanged)
    }
    @objc func idTextFieldDidChanged() {
        if let text = idTextField.text, !text.isEmpty {
            loginButton.backgroundColor = UIColor(named: "Main")
        } else {
            loginButton.backgroundColor = UIColor(named: "Enabled")
        }
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
                  self.navigationController?.pushViewController(TabBarController(), animated: true)
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
        signupLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(98)
            $0.height.equalTo(21)
        }
        signupButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.equalTo(signupLabel.snp.trailing).offset(1)
            $0.trailing.equalToSuperview().inset(101)
            $0.height.equalTo(21)

        }
    }
    override func addView() {
        [
            logoTitle,
            idTextField,
            passwordTextField,
            loginButton,
            signupLabel,
            signupButton
        ].forEach {view.addSubview($0)}
    }
}

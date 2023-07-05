import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class SignupViewController: BaseViewController {
    public var number: String = ""
    let viewModel = SignupViewModel()
    let nameTextField = UITextField().then {
        $0.setSignupTextField(placeholderText: "닉네임")
    }
    let detailNameLabel = UILabel().then {
        $0.setSignupLabel(text: "영문, 숫자 3 ~ 10 자")
    }
    let idTextField = UITextField().then {
        $0.setSignupTextField(placeholderText: "아이디")
    }
    let detailIdLabel = UILabel().then {
        $0.setSignupLabel(text: "영문, 숫자 6 ~ 20 자")
    }
    let passwordTextField = UITextField().then {
        $0.setSignupTextField(placeholderText: "비밀번호")
    }
    let detailPasswordLabel = UILabel().then {
        $0.setSignupLabel(text: "영문, 숫자, 특수문자 조합 최소 6자")
    }
    let checkPasswordTextField = UITextField().then {
        $0.setSignupTextField(placeholderText: "비밀번호 확인")
    }
    
    let signupButton = UIButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
        $0.layer.cornerRadius = 20
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor(named: "Enabled")
    }
    private func validpassword(mypassword: String) -> Bool {
        let passwordreg =  "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{6,30}"
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }
    override func configureVC() {
        passwordTextField.rx.text.orEmpty
            .filter { !$0.isEmpty && $0 ==  self.checkPasswordTextField.text}
            .map {self.validpassword(mypassword: $0)}
            .subscribe(onNext: { [unowned self] in
                self.signupButton.isEnabled = $0
                switch $0 {
                case true:
                    signupButton.backgroundColor = .gray
                    signupButton.rx.tap
                        .bind {
                            self.navigationController?.pushViewController(LoginViewController(), animated: true)
                        }.disposed(by: disposeBag)
                case false:
                    signupButton.isEnabled = true
                }
            }).disposed(by: disposeBag)
    }

    override func bind() {
        let viewController = LoginViewController()
        let input = SignupViewModel.Input(
            nameText: nameTextField.rx.text.orEmpty.asDriver(),
            idText: idTextField.rx.text.orEmpty.asDriver(),
            passwortText: passwordTextField.rx.text.orEmpty.asDriver(),
            checkPasswordText: checkPasswordTextField.rx.text.orEmpty.asDriver(),
            signupButtonDidTap: signupButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)
        output.result
            .subscribe(onNext: {
                switch $0 {
                case true:
                    print("성공")
                    self.navigationController?.pushViewController(LoginViewController(), animated: true)
                default:
                    print("실패")
                }
            }).disposed(by: disposeBag)
    }

    override func setLayout() {
        nameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(133)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }
        detailNameLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(1)
            $0.leading.equalToSuperview().inset(72)
            $0.height.equalTo(21)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(detailNameLabel.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }
        detailIdLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(0)
            $0.leading.equalToSuperview().inset(71)
            $0.height.equalTo(21)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(detailIdLabel.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }
        detailPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(0)
            $0.leading.equalToSuperview().inset(71)
            $0.height.equalTo(21)
        }
        checkPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(detailPasswordLabel.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }

        signupButton.snp.makeConstraints {
            $0.top.equalTo(checkPasswordTextField.snp.bottom).offset(55)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }

    }
    override func addView() {
        [
            nameTextField,
            detailNameLabel,
            idTextField,
            detailIdLabel,
            passwordTextField,
            detailPasswordLabel,
            checkPasswordTextField,
            signupButton
        ].forEach {view.addSubview($0)}
    }

}

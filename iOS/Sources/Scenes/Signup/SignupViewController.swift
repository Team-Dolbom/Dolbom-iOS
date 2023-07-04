import UIKit
import Then
import SnapKit
import RxSwift

class SignupViewController: BaseViewController {

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
    let numberTextField = UITextField().then {
        $0.setSignupTextField(placeholderText: "전화번호")
    }
    let codeTextField = UITextField().then {
        $0.setSignupTextField(placeholderText: "인증번호")
    }
    let sendCodeButton = UIButton(type: .system).then {
        $0.setTitle("발송", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor(named: "Enabled")
    }
    let signupButton = UIButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
        $0.layer.cornerRadius = 20
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor(named: "Enabled")
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
        numberTextField.snp.makeConstraints {
            $0.top.equalTo(checkPasswordTextField.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(40)
            $0.width.equalTo(238)
            $0.height.equalTo(45)
        }
        sendCodeButton.snp.makeConstraints {
            $0.top.equalTo(numberTextField.snp.top)
            $0.leading.equalTo(numberTextField.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(43)
            $0.width.equalTo(65)
            $0.height.equalTo(45)
        }
        codeTextField.snp.makeConstraints {
            $0.top.equalTo(sendCodeButton.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }
        signupButton.snp.makeConstraints {
            $0.top.equalTo(codeTextField.snp.bottom).offset(55)
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
            numberTextField,
            sendCodeButton,
            codeTextField,
            signupButton
        ].forEach {view.addSubview($0)}
    }

}

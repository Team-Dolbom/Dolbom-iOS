import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class NumberCheckViewController: BaseViewController {
    let viewModel = NumberCheckViewModel()
    let numberTextField = UITextField().then {
        $0.setSignupTextField(placeholderText: "전화번호")
    }
    let sendCodeButton = UIButton(type: .system).then {
        $0.setTitle("발송", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor(named: "Enabled")
    }
    let codeTextField = UITextField().then {
        $0.setSignupTextField(placeholderText: "인증번호")
    }
    let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(named: "Enabled")
    }
    override func configureVC() {
        numberTextField.addTarget(self, action: #selector(numberTextFieldDidchanged(_:)), for: .editingChanged)
        codeTextField.addTarget(self, action: #selector(codeTextFieldDidchanged(_:)), for: .editingChanged)
    }
    @objc func numberTextFieldDidchanged(_ textField: UITextField) {
        if let text = numberTextField.text, !text.isEmpty {
            sendCodeButton.backgroundColor = UIColor(named: "Main")
        } else {
            sendCodeButton.backgroundColor = UIColor(named: "Enabled")
        }
    }
    @objc func codeTextFieldDidchanged(_ textField: UITextField) {
        if let text = codeTextField.text, !text.isEmpty {
            nextButton.backgroundColor = UIColor(named: "Main")
        } else {
            nextButton.backgroundColor = UIColor(named: "Enabled")
        }
    }

    override func bind() {
//        self.nextButton.isEnabled = true
        let viewController = SignupViewController()
        let input = NumberCheckViewModel.Input(
            numberText: numberTextField.rx.text.orEmpty.asDriver(),
            codenumber: codeTextField.rx.text.orEmpty.asDriver(),
            sendButtonDidTaped: sendCodeButton.rx.tap.asSignal(),
            nextButtonDidTaped: nextButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                print("성공")
                viewController.number.onNext(self.numberTextField.text ?? "")
                self.nextButton.rx.tap
                    .bind {
                        self.navigationController?.pushViewController(SignupViewController(), animated: true)
                    }
            case false:
                print("실패")
            }
        })
        output.codeNumber.subscribe(onNext: { code in
            if code == self.codeTextField.text {
                self.nextButton.isEnabled = false
            } else {
                self.nextButton.isEnabled = true
            }
        }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            numberTextField,
            sendCodeButton,
            codeTextField,
            nextButton
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        numberTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(130)
            $0.leading.equalToSuperview().inset(40)
            $0.width.equalTo(238)
            $0.height.equalTo(45)
        }
        sendCodeButton.snp.makeConstraints {
            $0.top.equalTo(numberTextField.snp.top)
            $0.leading.equalTo(numberTextField.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }
        codeTextField.snp.makeConstraints {
            $0.top.equalTo(numberTextField.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }
        nextButton.snp.makeConstraints {
            $0.top.equalTo(codeTextField.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }
    }
}

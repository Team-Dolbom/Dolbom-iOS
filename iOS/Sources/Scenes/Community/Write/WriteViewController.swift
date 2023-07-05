import UIKit
import Then
import SnapKit

class WriteViewController: BaseViewController {
    let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: nil)
    override func viewDidLoad() {
        self.navigationItem.title = "글쓰기"
        self.navigationItem.rightBarButtonItem = doneButton
    }
    let titleTextField = UITextField().then {
        $0.placeholder = "제목을 입력해주세요"
        $0.layer.borderWidth = 0
    }
    let titleTextFieldLine = UIView().then {
        $0.backgroundColor = UIColor(named: "TabbarColor")
    }
    let categoryTextField = UITextField().then {
        $0.placeholder = "카테고리를 입력해주세요"
        $0.layer.borderWidth = 0
    }
    let categoryLine = UIView().then {
        $0.backgroundColor = UIColor(named: "TabbarColor")
    }
    let contentTexField = UITextField().then {
        $0.placeholder = "내용을 입력해주세요."
        $0.layer.borderWidth = 0
    }
    override func addView() {
        [
            titleTextField,
            titleTextFieldLine,
            categoryTextField,
            categoryLine,
            contentTexField
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        titleTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(119)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(28)
        }
        titleTextFieldLine.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(1)
        }
        categoryTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(22)
        }
        categoryLine.snp.makeConstraints {
            $0.top.equalTo(categoryTextField.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(1)
        }
        contentTexField.snp.makeConstraints {
            $0.top.equalTo(categoryLine.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(22)
        }
    }
}

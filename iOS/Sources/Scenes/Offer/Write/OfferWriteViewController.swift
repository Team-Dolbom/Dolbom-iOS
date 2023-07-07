import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class OfferWriteViewController: BaseViewController {
    var bool = false
    let viewModel = OfferWriteViewModel()
    let doneButton = UIBarButtonItem(title: "완료      ", style: .done, target: nil, action: nil)

    @objc func segSelected(_ sender: UISegmentedControl) {
          let selectedIndex = sender.selectedSegmentIndex
          if selectedIndex == 0 {
              bool = false
              print(bool)
          } else {
              bool = true
              print(bool)
          }
      }

    override func bind() {
        let input = OfferWriteViewModel.Input(isBabySitter: bool,
                                              titleText: titleTextFieldd.rx.text.orEmpty.asDriver(), contentText: contentTextField.rx.text.orEmpty.asDriver(),
                                              introText: introTextField.rx.text.orEmpty.asDriver(),
                                              completeButtonDidTaped: doneButton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.result
            .bind {
                switch $0 {
                case true:
                    self.navigationController?.popViewController(animated: true)
                    print("성공")
                default:
                    print("실패")
                }
            }.disposed(by: disposeBag)
    }
    override func configureVC() {
        doneButton.tintColor = .black
        self.navigationItem.title = "글쓰기"
        self.navigationItem.rightBarButtonItem = doneButton
    }
    let babysitterSeg = UISegmentedControl(items: ["돌보미", "부모"]).then {
        $0.selectedSegmentTintColor = UIColor(named: "Main")
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        $0.addTarget(self, action: #selector(segSelected), for: .valueChanged)
    }
    let titleTextFieldd = UITextField().then {
        $0.layer.borderWidth = 0
        $0.placeholder = "제목을 입력해주세요"
    }
    let titleBottonLine = UIView().then {
        $0.backgroundColor = UIColor(named: "TabbarColor")
    }
    let contentTextField = UITextField().then {
        $0.layer.borderWidth = 0
        $0.placeholder = "내용을 입력해주세요."
    }
    let contentLine = UIView().then {
        $0.backgroundColor = UIColor(named: "TabbarColor")
    }
    let introTextField = UITextField().then {
        $0.placeholder = "본인의 정보를 입력해주세요."
        $0.layer.borderWidth = 0
    }
    override func addView() {
        [
            babysitterSeg,
            titleTextFieldd,
            titleBottonLine,
            contentTextField,
            contentLine,
            introTextField
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        babysitterSeg.snp.makeConstraints {
            $0.top.equalToSuperview().inset(119)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(32)
        }
        titleTextFieldd.snp.makeConstraints {
            $0.top.equalTo(babysitterSeg.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(28)
        }
        titleBottonLine.snp.makeConstraints {
            $0.top.equalTo(titleTextFieldd.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(1)
        }
        contentTextField.snp.makeConstraints {
            $0.top.equalTo(titleBottonLine.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(22)
        }
        contentLine.snp.makeConstraints {
            $0.top.equalTo(contentTextField.snp.bottom).offset(204)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(1)
        }
        introTextField.snp.makeConstraints {
            $0.top.equalTo(contentLine.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(22)
        }

    }
}

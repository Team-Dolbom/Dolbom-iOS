import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func setSignupTextField(placeholderText: String) {
        self.placeholder = placeholderText
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor(named: "GrayTextField")
        addLeftPadding()
    }
}

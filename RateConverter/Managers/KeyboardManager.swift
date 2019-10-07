
import UIKit

// MARK: - KeyboardNotificationsDelegate
protocol KeyboardNotificationsDelegate: class {
    func keyboardWillShow(_ keyboardSize: CGRect, keyboardAnimationDuration: Double, userInfo: [AnyHashable: Any])
    func keyboardDidShow(_ keyboardSize: CGRect, keyboardAnimationDuration: Double, userInfo: [AnyHashable: Any])
    func keyboardWillHide(_ keyboardAnimationDuration: Double, userInfo: [AnyHashable: Any])
    func keyboardDidHide(_ keyboardAnimationDuration: Double, userInfo: [AnyHashable: Any])
}

// MARK: - Optional funcs
extension KeyboardNotificationsDelegate {
    func keyboardDidShow(_ keyboardSize: CGRect, keyboardAnimationDuration: Double, userInfo: [AnyHashable: Any]) { }
    func keyboardDidHide(_ keyboardAnimationDuration: Double, userInfo: [AnyHashable: Any]) { }
}

class KeyboardManager: NSObject {
    weak var delegate: KeyboardNotificationsDelegate?

    override init() {
        super.init()
        observeKeyboardNotifications()
    }

    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardManager.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardManager.keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardManager.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardManager.keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let userInfo = (notification as NSNotification).userInfo,
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            delegate?.keyboardWillShow(keyboardSize, keyboardAnimationDuration: keyboardAnimationDuration, userInfo: userInfo)
        }
    }

    @objc func keyboardDidShow(_ notification: Notification) {
        if let userInfo = (notification as NSNotification).userInfo,
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            delegate?.keyboardDidShow(keyboardSize, keyboardAnimationDuration: keyboardAnimationDuration, userInfo: userInfo)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if let userInfo = (notification as NSNotification).userInfo,
            let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            delegate?.keyboardWillHide(keyboardAnimationDuration, userInfo: userInfo)
        }
    }

    @objc func keyboardDidHide(_ notification: Notification) {
        if let userInfo = (notification as NSNotification).userInfo,
            let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            delegate?.keyboardDidHide(keyboardAnimationDuration, userInfo: userInfo)
        }
    }
}

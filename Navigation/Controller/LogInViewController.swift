//
//  LogInViewController.swift
//  Navigation
//
//  Created by Constantin on 08.12.2022.
//

import UIKit

final class LogInViewController: UIViewController {

    private let login = "admin@mail.ru"
    private let password = "12345678"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let textFieldLogin: UITextField = {
        let textField = UITextField()
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = .always
        textField.leftView = spacerView
        textField.text = ""
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.tintColor = UIColor.blue
        textField.autocapitalizationType = .none
        textField.textAlignment = .left
        textField.placeholder = "Email of phone"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let textFieldPassword: UITextField = {
        let textField = UITextField()
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = .always
        textField.leftView = spacerView
        textField.text = ""
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.tintColor = UIColor.blue
        textField.autocapitalizationType = .none
        textField.textAlignment = .left
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        if button.isSelected || button.isHighlighted || !button.isEnabled{
            button.alpha = 0.8
        } else {
            button.alpha = 1
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let labelError: UILabel = {
        let label = UILabel()
        label.text = "Invalid password: The number of password characters is less than 8"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true

        self.view.backgroundColor = .white
        self.scrollView.addSubview(imageView)
        self.scrollView.addSubview(textFieldLogin)
        self.scrollView.addSubview(textFieldPassword)
        self.scrollView.addSubview(button)
        self.scrollView.addSubview(labelError)
        self.view.addSubview(scrollView)

        installConstrains()

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(recognizer)

        textFieldLogin.delegate = self
        textFieldPassword.delegate = self

        NotificationCenter.default.addObserver(self,
            selector: #selector(adjustInsetForKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(self,
            selector: #selector(adjustInsetForKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
    }

    private func installConstrains() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            textFieldLogin.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 120),
            textFieldLogin.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldLogin.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textFieldLogin.heightAnchor.constraint(equalToConstant: 50),

            textFieldPassword.topAnchor.constraint(equalTo: textFieldLogin.bottomAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: textFieldLogin.leadingAnchor),
            textFieldPassword.trailingAnchor.constraint(equalTo: textFieldLogin.trailingAnchor),
            textFieldPassword.heightAnchor.constraint(equalTo: textFieldLogin.heightAnchor),

            button.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: textFieldLogin.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: textFieldLogin.trailingAnchor),
            button.heightAnchor.constraint(equalTo: textFieldLogin.heightAnchor),

            labelError.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
            labelError.leadingAnchor.constraint(equalTo: textFieldLogin.leadingAnchor),
            labelError.trailingAnchor.constraint(equalTo: textFieldLogin.trailingAnchor),
            labelError.heightAnchor.constraint(equalTo: textFieldLogin.heightAnchor),
        ])
    }

    @objc func adjustInsetForKeyboard(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }

        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        let show = (notification.name == UIResponder.keyboardWillShowNotification) ? true : false

        let bottomInset = (keyboardFrame.height + 20) * (show ? 1 : 0)
        scrollView.contentInset.bottom = bottomInset
        scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func touch() {
           self.view.endEditing(true)
    }

    @objc private func buttonAction() {

        guard let login = textFieldLogin.text, !login.isEmpty else {
            textFieldLogin.shake()
            return
        }

        guard let password = textFieldPassword.text, !password.isEmpty else {
            textFieldPassword.shake()
            return
        }

        guard password.count > 7 else {
            labelError.isHidden = false
            return
        }

        labelError.isHidden = true

        guard self.login == login && self.password == password else {
            let alert = UIAlertController(title: "Invalid login or password", message: "Please, enter correct login and password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default))
            self.present(alert, animated: true, completion: nil)
            return
        }

        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UITextField {

    func shake() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 6
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = CGPoint(x: self.center.x - 4, y: self.center.y)
        shakeAnimation.toValue = CGPoint(x: self.center.x + 4, y: self.center.y)
        layer.add(shakeAnimation, forKey: "position")
    }
}

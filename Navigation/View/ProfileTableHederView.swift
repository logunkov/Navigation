//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Constantin on 01.12.2022.
//

import UIKit

final class ProfileHeaderView: UIView {

    private var statusText: String?

    private let labelName: UILabel = {
        let labelName = UILabel()
        labelName.text = "Popeye the Sailor"
        labelName.font = UIFont.boldSystemFont(ofSize: 18)
        labelName.textColor = .black
        labelName.textAlignment = .center
        labelName.translatesAutoresizingMaskIntoConstraints = false
        return labelName
    }()

    private let labelStatus: UILabel = {
        let labelStatus = UILabel()
        labelStatus.text = "Шпинат - Сила!"
        labelStatus.numberOfLines = 0
        labelStatus.font = UIFont.boldSystemFont(ofSize: 14)
        labelStatus.textColor = .gray
        labelStatus.textAlignment = .center
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        return labelStatus
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
//        button.setTitle("Show status", for: .normal)
        button.setTitle("Set status", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let imageView: UIImageView = {
        let size = 150
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        imageView.image = UIImage(named: "popeye")
        imageView.layer.borderWidth = 3
        imageView.layer.backgroundColor = UIColor.purple.cgColor
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let textField: UITextField = {
        let textField = UITextField()
//        textField.isHidden = true
        textField.text = ""
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    init() {
        super.init(frame: .zero)

        self.addSubview(labelName)
        self.addSubview(labelStatus)
        self.addSubview(imageView)
        self.addSubview(button)
        self.addSubview(textField)

        installConstrains()

        textField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonPressed() {
//        if textField.isHidden {
//            button.setTitle("Set status", for: .normal)
//        } else {
//            guard let text = textField.text, !text.isEmpty else {
//                textField.shake()
//                return
//            }
//            button.setTitle("Show status", for: .normal)
//            labelStatus.text = statusText
//            print(labelStatus.text ?? "nil")
//        }
//        textField.isHidden = !textField.isHidden

        guard let text = textField.text, !text.isEmpty else {
            textField.shake()
            return
        }

        labelStatus.text = statusText
        print(labelStatus.text ?? "nil")
    }

    @objc private func statusTextChanged(_ textField: UITextField) {
        if let text = textField.text {
            statusText = text
        }
    }

    private func installConstrains() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -6),
            button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 50),

            labelName.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 160),
            labelName.trailingAnchor.constraint(equalTo: button.trailingAnchor),

            textField.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 30),

            labelStatus.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelStatus.trailingAnchor.constraint(equalTo: button.trailingAnchor),

//            labelStatus.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20)
//            textField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8),

            labelStatus.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -40),
            textField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -4),
        ])
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

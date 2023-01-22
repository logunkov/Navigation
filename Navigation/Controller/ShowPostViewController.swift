//
//  ShowPostViewController.swift
//  Navigation
//
//  Created by Constantin on 28.12.2022.
//

import UIKit

final class ShowPostViewController: UIViewController {

    var idPost: Int = -1
    var likeDelegate: TapLikedDelegate?
    private var numberOfClicks = 0

    let author: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageNews: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let likes: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let views: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tapGestureRecognizer = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Post"
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .systemGray6

        view.addSubview(author)
        view.addSubview(imageNews)
        view.addSubview(descriptionText)
        view.addSubview(likes)
        view.addSubview(views)

        installConstrains()
        installRecognizer()
    }

    private func installConstrains() {
        let size = CGFloat(floor((view.frame.width)))

        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            author.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            author.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            imageNews.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 16),
            imageNews.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageNews.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageNews.heightAnchor.constraint(equalToConstant: size),

            descriptionText.topAnchor.constraint(equalTo: imageNews.bottomAnchor, constant: 16),
            descriptionText.leadingAnchor.constraint(equalTo: author.leadingAnchor),
            descriptionText.trailingAnchor.constraint(equalTo: author.trailingAnchor),

            likes.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
            likes.leadingAnchor.constraint(equalTo: author.leadingAnchor),

            views.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
            views.trailingAnchor.constraint(equalTo: author.trailingAnchor),
        ])
    }

    private func installRecognizer() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(tapLiked))
        self.likes.addGestureRecognizer(self.tapGestureRecognizer)
    }

    @objc func tapLiked() {
        numberOfClicks += 1
        let tmpNumber = Int(likes.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())! + 1
        likes.text = "Likes: \(tmpNumber)"
    }

    deinit {
        likeDelegate?.tapLiked(index: idPost, numberOfClicks: numberOfClicks)
    }
}

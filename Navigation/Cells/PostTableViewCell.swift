//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Constantin on 13.12.2022.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    var idPost: Int = -1
    var likeDelegate: TapLikedDelegate?
    
    var author: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageNews: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var likes: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var views: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tapGestureRecognizer = UITapGestureRecognizer()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(author)
        contentView.addSubview(imageNews)
        contentView.addSubview(descriptionText)
        contentView.addSubview(likes)
        contentView.addSubview(views)

        installConstrains()
        installRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func installConstrains() {

        let size = CGFloat(floor((contentView.frame.width)))

        NSLayoutConstraint.activate([
            author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

            imageNews.heightAnchor.constraint(equalToConstant: size),
            imageNews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageNews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageNews.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 16),

            descriptionText.leadingAnchor.constraint(equalTo: author.leadingAnchor),
            descriptionText.trailingAnchor.constraint(equalTo: author.trailingAnchor),
            descriptionText.topAnchor.constraint(equalTo: imageNews.bottomAnchor, constant: 16),

            likes.leadingAnchor.constraint(equalTo: author.leadingAnchor),
            likes.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),

            views.trailingAnchor.constraint(equalTo: author.trailingAnchor),
            views.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
            views.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }

    private func installRecognizer() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(tapLiked))
        self.likes.addGestureRecognizer(self.tapGestureRecognizer)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        author.text = nil
        imageNews.image = nil
        descriptionText.text = nil
        likes.text = nil
        views.text = nil
    }

    @objc func tapLiked() {
        likeDelegate?.tapLiked(index: idPost, numberOfClicks: 1)
    }
}

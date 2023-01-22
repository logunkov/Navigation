//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Constantin on 14.12.2022.
//

import UIKit

final class PhotosViewController: UIViewController {

    private var imageWidthConstraint: NSLayoutConstraint!
    private var imageHeightConstraint: NSLayoutConstraint!
    private var imageXCenterConstraint: NSLayoutConstraint!
    private var imageYCenterConstraint: NSLayoutConstraint!
    private var imageSize:CGFloat!
    private var imageSizeCenter:CGFloat!
    private var numberRow: CGFloat = -1
    private var numberColumn: CGFloat = -1
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let dataSource: [UIImageView] = {
        var images: [UIImageView] = []
        for index in 1...20 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "photo\(index)")
            images.append(imageView)
        }
        return images
    }()

    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.alpha = 0
        button.isHidden = true
        button.setBackgroundImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.addTarget(self, action: #selector(imageClosed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Photo Gallery"
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .lightGray
        
        view.addSubview(collectionView)
        view.addSubview(backView)
        view.addSubview(imageView)
        view.addSubview(closeButton)
        installConstrains()
    }
    
    private func installConstrains() {
        imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 119)
        imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 119)
        imageXCenterConstraint = imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 91)
        imageYCenterConstraint = imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 91 )

        NSLayoutConstraint.activate([
            self.imageWidthConstraint, self.imageHeightConstraint,
            self.imageXCenterConstraint, self.imageYCenterConstraint,

            collectionView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.trailingAnchor),

            backView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func imageSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let width = floor((width - 4 * spacing) / 3)
        imageSize = width
        imageSizeCenter = 8 + width / 2
        return CGSize(width: width, height: width)
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let photos = dataSource[indexPath.row]
        cell.photoImage.image = photos.image
        cell.photoImage.contentMode = .scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let size: CGFloat = 8
        return UIEdgeInsets(top: size, left: size, bottom: size, right: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let  spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return imageSize(for: collectionView.frame.width, with: spacing ?? 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        numberRow = CGFloat(indexPath.row / 3)
        numberColumn = CGFloat(indexPath.row) - 3 * numberRow

        imageView.image = UIImage(named: "photo\(indexPath.row + 1)")
        let sizeWidth = CGFloat(floor((view.safeAreaLayoutGuide.layoutFrame.width)))
        let sizeHeight = CGFloat(floor((view.safeAreaLayoutGuide.layoutFrame.height)))

        imageXCenterConstraint.constant = imageSizeCenter + (imageSize + 8) * numberColumn
        imageYCenterConstraint.constant = imageSizeCenter + (imageSize + 8) * numberRow - collectionView.contentOffset.y
        self.view.layoutIfNeeded()

        getInvisibility()

        imageWidthConstraint.constant = sizeWidth
        imageHeightConstraint.constant = sizeWidth

        imageXCenterConstraint.constant = sizeWidth / 2
        imageYCenterConstraint.constant = sizeHeight / 2

        UIView.animate(withDuration: 0.5) {
            self.backView.alpha = 0.7
            self.view.layoutIfNeeded()
        }

        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.closeButton.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    @objc func imageClosed() {
        UIView.animate(withDuration: 0.3) {
            self.closeButton.alpha = 0
            self.view.layoutIfNeeded()
        }

        imageWidthConstraint.constant = imageSize
        imageHeightConstraint.constant = imageSize

        imageXCenterConstraint.constant = imageSizeCenter + (imageSize + 8) * numberColumn
        imageYCenterConstraint.constant = imageSizeCenter + (imageSize + 8) * numberRow - collectionView.contentOffset.y

        UIView.animate(withDuration: 0.5, delay: 0.3) {
            self.backView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.getInvisibility()
        }
    }

    private func getInvisibility() {
        self.closeButton.isHidden.toggle()
        self.imageView.isHidden.toggle()
    }
}

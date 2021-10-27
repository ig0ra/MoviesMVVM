// MovieTableViewCell.swift
// Copyright © Igor Obrizko. All rights reserved.

import UIKit
/// MovieTableViewCell
final class MovieTableViewCell: UITableViewCell {
    // MARK: - Private properties

    private let posterImageView: UIImageView = {
        let imgView = UIImageView(image: .init(systemName: "film"))
        imgView.tintColor = .darkGray
        imgView.backgroundColor = .gray
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 10
        return imgView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 6
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()

    private let imageService = ImageService()

    // MARK: - UITableViewCell

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .random().withAlphaComponent(0.3)

        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)

        addAnchors()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func addAnchors() {
        posterImageView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: nil,
            paddingTop: 5,
            paddingLeft: 5,
            paddingBottom: 5,
            paddingRight: 0,
            width: UIScreen.main.bounds.width / 3,
            height: UIScreen.main.bounds.height / 5,
            enableInsets: false
        )
        titleLabel.anchor(
            top: topAnchor,
            left: posterImageView.rightAnchor,
            bottom: nil,
            right: nil,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 0,
            paddingRight: 0,
            width: frame.size.width - posterImageView.frame.width - 35,
            height: 0,
            enableInsets: false
        )
        descriptionLabel.anchor(
            top: titleLabel.bottomAnchor,
            left: posterImageView.rightAnchor,
            bottom: nil,
            right: nil,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 0,
            paddingRight: 0,
            width: frame.size.width - posterImageView.frame.width - 35,
            height: 0,
            enableInsets: false
        )
        dateLabel.anchor(
            top: descriptionLabel.bottomAnchor,
            left: nil,
            bottom: nil,
            right: descriptionLabel.rightAnchor,
            paddingTop: 5,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 10,
            width: frame.size.width - posterImageView.frame.width - 35,
            height: 0,
            enableInsets: false
        )
    }

    // MARK: - Public methods

    func getData(title: String?, description: String?, date: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
        dateLabel.text = date
    }

    func downloadImage(with posterPath: String) {
        imageService.getImage(urlPath: posterPath) { [weak self] image in
            DispatchQueue.main.async {
                self?.posterImageView.image = image
            }
        }
    }
}

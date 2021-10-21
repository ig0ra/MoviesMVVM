// PosterTableViewCell.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class PosterTableViewCell: UITableViewCell {
    // MARK: - Visual components

    @IBOutlet private var posterImageView: UIImageView!

    // MARK: - Private properties

    private let imageService = ImageService()

    // MARK: - Public methods

    func getImage(with posterPath: String) {
        imageService.getImage(urlPath: posterPath) { [weak self] image in
            DispatchQueue.main.async {
                self?.posterImageView.image = image
            }
        }
    }
}

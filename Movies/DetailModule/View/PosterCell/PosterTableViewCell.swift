// PosterTableViewCell.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class PosterTableViewCell: UITableViewCell {
    // MARK: - Visual components

    @IBOutlet private var posterImageView: UIImageView!

    // MARK: - Private properties

    private let imageAPIService = ImageAPIService()

    // MARK: - Public methods

    func getImage(with posterPath: String) {
        imageAPIService.fetchImage(with: posterPath) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                guard let data = data,
                      let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async { self.posterImageView.image = image }
            case let .failure(error):
                print(error)
            }
        }
    }
}

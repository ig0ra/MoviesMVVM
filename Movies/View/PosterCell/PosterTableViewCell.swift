// PosterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Pooster cell
class PosterTableViewCell: UITableViewCell {
    // MARK: - Visual components

    @IBOutlet private var posterImageView: UIImageView!

    // MARK: - Private properties

    private let networkManager = NetworkManager()

    // MARK: - Public methods

    func getImage(with posterPath: String) {
        let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"

        networkManager.fetchImage(with: urlString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async { self.posterImageView.image = image }
            case let .failure(error):
                print(error)
            }
        }
    }
}

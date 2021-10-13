// DetailViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit
/// Detail view controller
final class DetailViewController: UIViewController {
    // MARK: - Private properties

    private let tableView = UITableView()
    // private let networkManager = MovieAPIService()

    private let posterCellIdentifier = "PosterTableViewCell"
    private let titleCellIdentifier = "TitleTableViewCell"
    private let descriptionCellIdentifier = "DecsriptionTableViewCell"

    // MARK: - Public properties

    var titleString: String?
    var descriptionString: String?
    var posterPath: String?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTableView()
    }

    // MARK: - Private methods

    private func setupTableView() {
        tableView.dataSource = self

        tableView.register(
            UINib(nibName: posterCellIdentifier, bundle: nil),
            forCellReuseIdentifier: posterCellIdentifier
        )
        tableView.register(
            UINib(nibName: titleCellIdentifier, bundle: nil),
            forCellReuseIdentifier: titleCellIdentifier
        )
        tableView.register(
            UINib(nibName: descriptionCellIdentifier, bundle: nil),
            forCellReuseIdentifier: descriptionCellIdentifier
        )

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension

        tableView.separatorStyle = .none

        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(tableView)
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: posterCellIdentifier, for: indexPath) as? PosterTableViewCell
            else { return UITableViewCell() }

            if let path = posterPath {
                cell.getImage(with: path)
            }

            return cell
        case 1:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: titleCellIdentifier, for: indexPath) as? TitleTableViewCell
            else { return UITableViewCell() }
            cell.addTitle(title: titleString)

            return cell
        case 2:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: descriptionCellIdentifier,
                    for: indexPath
                ) as? DecsriptionTableViewCell
            else { return UITableViewCell() }
            cell.addDescription(descriptionString)

            return cell
        default:
            return UITableViewCell()
        }
    }
}

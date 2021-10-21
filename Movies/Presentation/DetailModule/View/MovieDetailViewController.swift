// MovieDetailViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class MovieDetailViewController: UIViewController {
    // MARK: - Private properties

    private let tableView = UITableView()
    private var viewModel: MovieDetailViewModelProtocol?
    private var movieViewData: ViewData<Movie> = .initial {
        didSet {
            view.setNeedsLayout()
        }
    }

    private let posterCellIdentifier = "PosterTableViewCell"
    private let titleCellIdentifier = "TitleTableViewCell"
    private let descriptionCellIdentifier = "DecsriptionTableViewCell"

    // MARK: - UIViewController

    convenience init(viewModel: MovieDetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTableView()
        getInfo()
        fetchData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        switch movieViewData {
        case .initial:
            break
        case .success:
            tableView.reloadData()
        case let .failure(error):
            print(error)
        }
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

    private func getInfo() {
        viewModel?.updateViewData = { [weak self] viewData in
            self?.movieViewData = viewData
        }
    }

    private func fetchData() {
        viewModel?.fetchMovie()
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: posterCellIdentifier, for: indexPath) as? PosterTableViewCell
            else { return UITableViewCell() }

            if case let .success(movie) = movieViewData, let posterPath = movie.posterPath {
                cell.getImage(with: posterPath)
            }

            return cell
        case 1:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: titleCellIdentifier, for: indexPath) as? TitleTableViewCell
            else { return UITableViewCell() }

            if case let .success(movie) = movieViewData {
                cell.addTitle(title: movie.title)
            }

            return cell
        case 2:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: descriptionCellIdentifier,
                    for: indexPath
                ) as? DecsriptionTableViewCell
            else { return UITableViewCell() }

            if case let .success(movie) = movieViewData {
                cell.addDescription(movie.overview)
            }

            return cell
        default:
            return UITableViewCell()
        }
    }
}

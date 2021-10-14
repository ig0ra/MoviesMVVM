// MoviesViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class MoviesViewController: UIViewController {
    // MARK: - Public properties

    var tapCell: ((Int?) -> ())?

    // MARK: - Private properties

    private var viewModel: MoviesViewModelProtocol?

    private let tableView = UITableView()
    private let movieCellIdentifier = "cell"

    var moviesViewData: ViewData<Movies> = .initial {
        didSet {
            view.setNeedsLayout()
        }
    }

    // MARK: - UIViewController

    convenience init(viewModel: MoviesViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        setupTableView()
        getInfo()
        fetchData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        switch moviesViewData {
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
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: movieCellIdentifier)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension

        tableView.separatorStyle = .none

        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(tableView)
    }

    private func getInfo() {
        viewModel?.updateViewData = { [weak self] viewData in
            self?.moviesViewData = viewData
        }
    }

    private func fetchData() {
        viewModel?.fetchMovies()
    }
}

// MARK: - UITableViewDataSource

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case let .success(movies) = moviesViewData,
              let results = movies.results else { return 0 }
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: movieCellIdentifier,
            for: indexPath
        ) as? MovieTableViewCell,
            case let .success(movies) = moviesViewData,
            let results = movies.results?[indexPath.row],
            let path = results.posterPath
        else { return UITableViewCell() }

        cell.getData(
            title: results.title,
            description: results.overview,
            date: results.releaseDate
        )
        cell.downloadImage(with: path)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tapCell?(indexPath.row)
    }
}

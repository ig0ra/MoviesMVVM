// MoviesViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit
///
final class MoviesViewController: UIViewController {
    // MARK: - Private properties

    private let tableView = UITableView()
    private let networkManager = NetworkManager()
    private let movieCellIdentifier = "cell"
    private lazy var dataSource: Movies? = nil {
        didSet {
            guard let dataSource = dataSource?.results else { return }
            movies = dataSource
        }
    }

    private var movies: [MovieResult] = [] {
        didSet { tableView.reloadData() }
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movies"

        setupTableView()

        getInfo()
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
        networkManager.fetchData { [weak self] result in
            switch result {
            case let .success(movies: movies):
                self?.dataSource = movies

                DispatchQueue.main.async { self?.tableView.reloadData() }
            case let .failure(error: error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { movies.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: movieCellIdentifier,
            for: indexPath
        ) as? MovieTableViewCell
        else { return UITableViewCell() }

        let resuls = movies[indexPath.row]

        cell.getData(title: resuls.title, description: resuls.overview, date: resuls.releaseDate)

        guard let path = resuls.posterPath else { return UITableViewCell() }
        cell.downloadImage(with: path)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let detailVC = DetailViewController()

        detailVC.posterPath = movies[indexPath.row].posterPath
        detailVC.titleString = movies[indexPath.row].title
        detailVC.descriptionString = movies[indexPath.row].overview

        show(detailVC, sender: self)
    }
}

// MoviesCoordinatorTests.swift
// Copyright © Roadmap. All rights reserved.

@testable import Movies
import UIKit
import XCTest

final class MockAssemblyModule: AssemblyProtocol {
    func createMoviesModule() -> UIViewController {
        let mockViewModel = MockMoviesViewModule()
        let mockMoviesViewController = MoviesViewController(viewModel: mockViewModel)
        return mockMoviesViewController
    }

    func createDetailModule(indexOfMovie: Int?) -> UIViewController {
        UIViewController()
    }
}

final class MockMoviesViewModule: MoviesViewModelProtocol {
    var updateViewData: ((ViewData<Movies>) -> ())?

    func fetchMovies() {}
}

final class MoviesCoordinatorTests: XCTestCase {
    var moviesCoordinator: MoviesCoordinator?
    var mockAssemblyModule: AssemblyProtocol?
    var applicationCoordinator: ApplicationCoordinator?
    var navigetionConroller: UINavigationController?

    override func setUpWithError() throws {
        mockAssemblyModule = MockAssemblyModule()
        guard let mockAssemblyModule = mockAssemblyModule else { return }
        applicationCoordinator = ApplicationCoordinator(assemblyModule: mockAssemblyModule)
        moviesCoordinator = MoviesCoordinator(assemblyModule: mockAssemblyModule)
    }

    override func tearDownWithError() throws {
        mockAssemblyModule = nil
        navigetionConroller = nil
        moviesCoordinator = nil
        applicationCoordinator = nil
    }

    func testShowingMoviesModule() {
        moviesCoordinator?.start()
        XCTAssertTrue(moviesCoordinator?.rootViewController?.viewControllers.first is MoviesViewController)
    }
}

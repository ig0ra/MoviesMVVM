// MoviesCoordinatorTests.swift
// Copyright © Roadmap. All rights reserved.

@testable import Movies
import UIKit
import XCTest

final class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

final class MoviesCoordinatorTests: XCTestCase {
    var applicationCoordinator: ApplicationCoordinator?
    var mockNavigationConroller: MockNavigationController?

    override func setUpWithError() throws {
        mockNavigationConroller = MockNavigationController()
        applicationCoordinator = ApplicationCoordinator(
            assemblyModule: AssemblyModule(),
            navigationController: mockNavigationConroller
        )
    }

    override func tearDownWithError() throws {
        applicationCoordinator = nil
        mockNavigationConroller = nil
    }

    func testPresentingMoviesModule() {
        applicationCoordinator?.start()
        guard let moviesViewController = mockNavigationConroller?.presentedVC as? MoviesViewController else { return }
        moviesViewController.tapCell?(2)
        XCTAssertTrue(moviesViewController.presentedViewController is MovieDetailViewController)
    }
}

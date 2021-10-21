// ImageServiceTest.swift
// Copyright © Roadmap. All rights reserved.

//
//  ImageServiceTest.swift
//  MoviesTests
//
//  Created by Admin on 17.10.2021.
//
@testable import Movies
import XCTest

final class ImageServiceTest: XCTestCase {
    var imageService: ImageServiceProtocol?

    override func setUpWithError() throws {
        imageService = ImageService()
    }

    override func tearDownWithError() throws {
        imageService = nil
    }

    func testGettingImage() {
        var myImage: UIImage?
        // "https://www.themoviedb.org/t/p/w600_and_h900_bestv2"
        imageService?.getImage(urlPath: "/iSHovbdANmUUwp4tTCYc9gTSFlj.jpg", completion: { image in
            guard let image = image else { return }
            myImage = image
        })

        XCTAssertNil(myImage)
    }
}

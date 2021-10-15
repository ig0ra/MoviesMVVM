// MoviesViewData.swift
// Copyright © Roadmap. All rights reserved.

import Foundation
import RealmSwift

/// Optionst for fetched data handling
enum ViewData<Model> {
    case initial
    case success(Model)
    case failure(Error)
}

/// Movies
struct Movies: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

/// Movies
final class Movie: Object, Codable {
    @objc dynamic var adult = false
    @objc dynamic var backdropPath: String?
    @objc dynamic var id = Int()
    @objc dynamic var originalLanguage, originalTitle, overview: String?
    @objc dynamic var popularity = Double()
    @objc dynamic var posterPath, releaseDate, title: String?
    @objc dynamic var video = false
    @objc dynamic var voteAverage = Double()
    @objc dynamic var voteCount = Int()

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    override class func primaryKey() -> String? {
        "id"
    }
}

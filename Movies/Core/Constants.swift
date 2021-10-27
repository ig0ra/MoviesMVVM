// Constants.swift
// Copyright © Igor Obrizko. All rights reserved.

import Foundation

/// App constants
struct Constants {
    static let mainUrlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=8e0fd47116b402cc2a7d63678e0b939e"

    static func getPosterURLString(path: String) -> String {
        "https://image.tmdb.org/t/p/w500\(path)"
    }
}

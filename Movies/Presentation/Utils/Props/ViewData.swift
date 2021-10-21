//
//  ViewData.swift
//  Movies
//
//  Created by Admin on 21.10.2021.
//

import Foundation

/// Optionst for fetched data handling
enum ViewData<Model> {
    case initial
    case success(Model)
    case failure(Error)
}

// ViewData.swift
// Copyright © Igor Obrizko. All rights reserved.

import Foundation

/// Optionst for fetched data handling
enum ViewData<Model> {
    case initial
    case success(Model)
    case failure(Error)
}

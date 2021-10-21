// CustomError.swift
// Copyright © Roadmap. All rights reserved.

import Foundation

/// Custom errors
enum CustomError: Error {
    case fetchedDataIsNil
    case urlIsNil
}

extension CustomError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .fetchedDataIsNil:
            return "Fethed data is nil"
        case .urlIsNil:
            return "URL is nil"
        }
    }
}

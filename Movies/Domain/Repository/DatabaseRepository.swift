// DatabaseRepository.swift
// Copyright © Roadmap. All rights reserved.

import Foundation

protocol DatabaseRepositoryProtocol {
    associatedtype Entity

    func save(_ objects: [Entity])
    func get() -> [Entity]?
}

/// Base repository class
class DatabaseRepository<Entity>: DatabaseRepositoryProtocol {
    func save(_ objects: [Entity]) {
        fatalError("Override required")
    }

    func get() -> [Entity]? {
        fatalError("Override required")
    }
}

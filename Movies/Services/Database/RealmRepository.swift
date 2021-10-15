// RealmRepository.swift
// Copyright © Roadmap. All rights reserved.

import Foundation
import RealmSwift

final class RealmRepository<Model: Object>: DatabaseRepository<Model> {
    override func get() -> [Model]? {
        do {
            let realm = try Realm()
            let objects = realm.objects(Model.self)
            let models = Array(objects)
            return models
        } catch {
            return nil
        }
    }

    override func save(_ objects: [Model]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

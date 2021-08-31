//
//  DatabaseManager.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import UIKit
import RealmSwift
import Realm

class DatabaseManager: NSObject {
    
    //MARK: - Variables
    
    static let shared = DatabaseManager()
    var realm: Realm {
        return try! Realm()
    }
    
    //MARK: - Override Functions
    
    private override init() {
        super.init()
    }
    
}

class RealmManager {

    private let NotificationError = Notification.Name.init(rawValue: "Realm")

    let realm:Realm = DatabaseManager.shared.realm

    func save<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            post(error)
        }
    }

    func save<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            post(error)
        }
    }

    func list<T: Object>(_ object: T.Type ) -> Results<T> {
        let query = realm.objects(object.self)
        return query
    }

    func update<T: Object>(_ object: T, with dictionary: [String: Any]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }

    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }

    func post(_ error: Error) {
        NotificationCenter.default.post(name: NotificationError, object: error)
    }

    func observeRealErrors(in viewController: UIViewController, complation: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NotificationError, object: viewController, queue: nil) { (notification) in
            complation(notification.object as? Error)
        }
    }

    func stopObserveRealErrors(in viewController: UIViewController) {
        NotificationCenter.default.removeObserver(viewController, name: NotificationError, object: nil)
    }
}



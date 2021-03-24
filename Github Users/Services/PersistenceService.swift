//
//  PersistenceService.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import UIKit
import RealmSwift


class PersistenceService{
    static let shared = PersistenceService()
    let realm = try! Realm()
    
    private func saveObjects<T:Object>(objects: [T], completion:@escaping(Error?)->()){
        do {
            for object in objects {
                try realm.write{
                    realm.add(object)
                }
            }
            completion(nil)
        }catch{
            completion(error)
        }
    }
}

extension PersistenceService {
    
    public func getUsers() -> Results<User>{
        return realm.objects(User.self)
    }
    
    public func persistUsers(users:[User], completion:@escaping(Error?)->()){
        self.saveObjects(objects: users, completion: completion)
    }
}

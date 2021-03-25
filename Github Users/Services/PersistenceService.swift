//
//  PersistenceService.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import UIKit
import RealmSwift

enum PersistenceError:Error {
    case loginDuplicate
    case noLoginValue
    case valueIsNil
}

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
    
    private func updateObject<T:Object>(object: T, withDictionary dictionary:[String:Any], completion:@escaping(Error?)->()){
        do {
            try realm.write{
                object.setValuesForKeys(dictionary)
            }
            completion(nil)
        }catch{
            completion(error)
        }
    }
    
    private func getObjectWithKey<T:Object>(object: T, key:String,value:Any?, completion:@escaping(Result<T,Error>)->()){
        
        guard let value = value else {
            completion(.failure(PersistenceError.valueIsNil))
            return
        }
        
        let query = "\(key) == %@"
        
        let objectResult = realm.objects(type(of: object)).filter(query,value)
        
        guard objectResult.count == 1,
              let object = objectResult.first else {
            completion(.failure(PersistenceError.loginDuplicate))
            return
        }
        
        completion(.success(object))
    }
}

extension PersistenceService {
    
    public func getUsers() -> Results<User>{
        return realm.objects(User.self)
    }
    
    public func persistUsers(users:[User], completion:@escaping(Error?)->()){
        self.saveObjects(objects: users, completion: completion)
    }
    
    public func updateUser(user:User, completion:@escaping(Result<User,Error>)->()){
        guard let login = user.login,
              let userDictionary = user.toDictionary() else {
            completion(.failure(PersistenceError.noLoginValue))
            return
        }
        
        self.getObjectWithKey(object: user, key: "login", value: login) { result in
            switch(result){
            
            case .success(let userToUpdate):

                self.updateObject(object: userToUpdate, withDictionary: userDictionary) { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    self.getObjectWithKey(object: user, key: "login", value: login) { result in
                        switch(result){
                        case .success(let updatedUser):
                            completion(.success(updatedUser))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        

        

        
    }
}

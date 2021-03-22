//
//  PersistenceService.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import UIKit
import CoreData

class PersistenceService{
    static let shared = PersistenceService()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func requestAll(withPredicates predicates:[NSPredicate] = [], withRequest request:NSFetchRequest<User>, completion: @escaping((Result<[User], Error>)->())){
        
        let attributeSortDescriptor = NSSortDescriptor(key: "id", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
            request.sortDescriptors = [attributeSortDescriptor]
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.predicate = compoundPredicate
        
        do {
            let data = try context.fetch(request)
            completion(.success(data))
           
        } catch {
            completion(.failure(error))
            return
        }
        
    }
    
    private func save(completion:@escaping(Error?)->()){
        do{
            try context.save()
            completion(nil)
        }catch{
            completion(error)
        }
    }
    
    
}

extension PersistenceService{
    
    public func retrieveUsers(completion:@escaping((Result<[User], Error>)->()))  {
        let requestItem: NSFetchRequest<User> = User.fetchRequest()
        self.requestAll(withRequest: requestItem, completion: completion)
    }
    
    public func exist(githubUser:ResponseGithubUser) -> Bool{
        let requestItem: NSFetchRequest<User> = User.fetchRequest()
        let predicateCategory = NSPredicate( format: "id == %i", githubUser.id)
        var resultBool: Bool!
        self.requestAll(withPredicates: [predicateCategory], withRequest: requestItem) { result in
            
            switch (result) {
            case .success(let users):
                if users.isEmpty {
                    resultBool = false
                }else{
                    resultBool = true
                }
            case .failure(_):
                resultBool = true
            }
        }
        return resultBool
    }
    
    public func saveUsers(githubUsers:[ResponseGithubUser],completion:@escaping(Result<[User],Error>)->()){
        
        let newlyAddedUsers = githubUsers.map { githubUser -> User in
            let newUser = User(context: self.context)
            newUser.login = githubUser.login
            newUser.id = Int64(githubUser.id)
            newUser.node_id = githubUser.node_id
            newUser.avatar_url = githubUser.avatar_url
            newUser.type = githubUser.type
            newUser.site_admin = githubUser.site_admin

            return newUser
        }
        
        self.save { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(newlyAddedUsers))
        }
    }
}

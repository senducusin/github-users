//
//  UserService.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import Foundation

class UserService {
    
    static public func pullUsers(withPagination pagination:Int, completion:@escaping(Result<[User], Error>)->()){
        guard let resource = ResponseGithubUser.all(pagination: pagination) else {
            return
        }
        
        WebService().load(resource: resource) { result in
            switch(result){
            
            case .success(let users):
                                
                DispatchQueue.main.async {
                    PersistenceService.shared.saveUsers(githubUsers: users, completion: completion)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static public func pullUser(withLogin login:String, completion:@escaping(Result<User,Error>)->()){
        
    }
}

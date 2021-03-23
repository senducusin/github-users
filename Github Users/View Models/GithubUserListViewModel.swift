//
//  GithubUserListViewModel.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import Foundation

struct GitUserListViewModel {
    private var _users = [User]()
    var appStarted = false
    var pagination = 0
    
    var users: [User] = [User]() {
        didSet {
            
            if pagination == 0 {
                _users = users
            }else{
                _users.append(contentsOf: users)
            }
            
            if let lastUser = _users.last {
                pagination = Int(lastUser.id)
            }
        }
    }
    
   
    var numberOfrows: Int {
        return _users.count
    }
    
    func userAtIndex(_ index:Int) -> User{
        return _users[index]
    }
}

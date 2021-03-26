//
//  GithubUserListViewModel.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import Foundation
import RealmSwift

struct GitUserListViewModel {
    var appStarted = false
    
    var users = PersistenceService.shared.getUsers().sorted(byKeyPath: "id", ascending: true)
    
    var numberOfrows: Int {
        return users.count
    }
    
    var pagination: Int {
        if let lastUser = users.last {
            return lastUser.id
        }
        return 0
    }
    
    func userAtIndex(_ index:Int) -> User{
        return users[index]
    }
    
    var searchText: String? {
        didSet {
            guard let searchText = self.searchText else {return}
            
            if searchText.isEmpty {
                self.users = PersistenceService.shared.getUsers()
            }else{
                self.users = PersistenceService.shared.getUsersWithLoginFilter(keyword: searchText)
            }
        }
    }
}

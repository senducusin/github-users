//
//  GithubUserDetailsViewModel.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/26/21.
//

import Foundation

struct GithubUserDetailsViewModel {
    
    var user: User? {
        didSet { self.setupDetails() }
    }
    
    var details = [Detail]()
    
    private mutating func setupDetails(){
        
        guard let user = self.user else {
            return
        }
        
        if let userDictionary = user.toDictionary(){
            self.details = userDictionary
                .filter{ (key, value) -> Bool in
                                return !"\(value)".isEmpty && "\(value)" != "<null>"  }
                .map({ Detail(name: self.detailName(name: $0.key), value: $0.value) })
                .sorted(by: {$0.name < $1.name})
        }
    }
    
    var numberOfDetails: Int {
        return self.details.count
    }
    
    func detailAtIndex(index:Int) -> Detail{
        return self.details[index]
    }
    
    func detailName(name:String) -> String {
        var newName: String!
        
        newName = name.replacingOccurrences(of: "_", with: " ")
        newName = newName.camelCaseToWords()
        
        if name == "login"{
            newName = "username"
        }
        
        return newName.capitalized
    }
    
}

extension GithubUserDetailsViewModel{
    init(user:User){
        self.user = user
        self.setupDetails()
    }
}

//
//  User+CoreDataClass.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/23/21.
//
//

import Foundation
import CoreData

/*
@objc(User)
public class User: NSManagedObject, Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(login , forKey: .login)
            try container.encode(node_id , forKey: .node_id)
            try container.encode(avatar_url , forKey: .avatar_url)
            try container.encode(type , forKey: .type)
            try container.encode(site_admin , forKey: .site_admin)
            try container.encode(id, forKey: .id)
            try container.encode(company, forKey: .company)
        } catch {
            print("DEBUG: Error encoding User")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context else {
            fatalError("contextUserInfoKey failure")
        }
        
        guard let  managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else {
            fatalError("managedObjectContext failure")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            
            login = try values.decode(String.self, forKey: .login)
            node_id = try values.decode(String.self, forKey: .node_id)
            avatar_url = try values.decode(String.self, forKey: .avatar_url)
            type = try values.decode(String.self, forKey: .type)
            site_admin = try values.decode(Bool.self, forKey: .site_admin)
            id = try values.decode(Int64.self, forKey: .id)
            company = try values.decode(String.self, forKey: .company)

        } catch {
            print("DEBUG: 2error")
        }
    }

    private enum CodingKeys: CodingKey {
        case login
        case node_id
        case avatar_url
        case type
        case site_admin
        case id
        case company
    }

}

extension User {
    static func all(pagination:Int = 0) -> Resource<[User]>? {
        guard let url = URL(string: "https://api.github.com/users?since=\(pagination)") else {
            return nil
        }

        return Resource(url: url)
    }

    static func user(withLogin login: String) -> Resource<User>? {
        guard let url = URL(string: "https://api.github.com/users/\(login)") else {
            return nil
        }
        return Resource(url: url)
    }
}
*/

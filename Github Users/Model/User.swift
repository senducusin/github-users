//
//  User.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/24/21.
//

import Foundation
import Realm
import RealmSwift

class User: Object, Codable {
    @objc dynamic var uuid = UUID().uuidString
    @objc dynamic var login: String? = ""
    @objc dynamic var node_id: String? = ""
    @objc dynamic var avatar_url: String? = ""
    @objc dynamic var type: String? = ""
    @objc dynamic var site_admin: Bool = false
    @objc dynamic var id: Int = 0
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
    private enum CodingKeys: String, CodingKey {
        case login
        case node_id
        case avatar_url
        case type
        case site_admin
        case id
    }
    
    convenience init(login:String, node_id:String, avatar_url:String, type:String, site_admin:Bool, id:Int){
        self.init()
        self.login = login
        self.node_id = node_id
        self.avatar_url = avatar_url
        self.type = type
        self.site_admin = site_admin
        self.id = id
    }
    
    convenience required init(form decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let login = try container.decode(String.self, forKey: .login)
        let node_id = try container.decode(String.self, forKey: .node_id)
        let avatar_url = try container.decode(String.self, forKey: .avatar_url)
        let type = try container.decode(String.self, forKey: .type)
        let site_admin = try container.decode(Bool.self, forKey: .site_admin)
        let id = try container.decode(Int.self, forKey: .id)

        
        self.init(login:login, node_id:node_id, avatar_url:avatar_url, type:type, site_admin:site_admin, id:id)
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

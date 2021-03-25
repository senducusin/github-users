//
//  User.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/24/21.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class User: Object, Codable {
    dynamic var uuid = UUID().uuidString
    dynamic var login: String? = ""
    dynamic var id: Int = 0
    dynamic var node_id: String? = ""
    dynamic var avatar_url: String? = ""
    dynamic var gravatar_id: String? = ""
    dynamic var url: String? = ""
    dynamic var html_url: String? = ""
    dynamic var followers_url: String? = ""
    dynamic var following_url: String? = ""
    dynamic var gists_url: String? = ""
    dynamic var starred_url: String? = ""
    dynamic var subscriptions_url: String? = ""
    dynamic var organizations_url: String? = ""
    dynamic var repos_url: String? = ""
    dynamic var events_url: String? = ""
    dynamic var received_events_url: String? = ""
    dynamic var type: String? = ""
    dynamic var site_admin: Bool = false
    dynamic var name: String? = ""
    dynamic var company: String? = ""
    dynamic var blog : String? = ""
    dynamic var location : String? = ""
    dynamic var email : String? = ""
    dynamic var hireable: Bool? = false
    dynamic var bio : String? = ""
    dynamic var twitter_username : String? = ""
    var public_repos = RealmOptional<Int>()
    var public_gists = RealmOptional<Int>()
    var followers = RealmOptional<Int>()
    var following = RealmOptional<Int>()
    dynamic var created_at : String? = ""
    dynamic var updated_at : String? = ""
    
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
        
        case gravatar_id
        case url
        case html_url
        case followers_url
        case following_url
        case gists_url
        case starred_url
        case subscriptions_url
        case organizations_url
        case repos_url
        case events_url
        case received_events_url
        case name
        case company
        case blog
        case location
        case email
        case hireable
        case bio
        case twitter_username
        
        case public_repos
        case public_gists
        case followers
        case following
        
        case created_at
        case updated_at
    }
    
    convenience init(
        login:String,
        node_id:String, avatar_url:String, type:String,
        site_admin:Bool, id:Int, gravatar_id: String? = "", url: String? = "",
        html_url: String? = "", followers_url: String? = "", following_url: String? = "",
        gists_url: String? = "", starred_url: String? = "", subscriptions_url: String? = "",
        organizations_url: String? = "", repos_url: String? = "", events_url: String? = "",
        received_events_url: String? = "", name: String? = "", company: String? = "",
        blog : String? = "", location : String? = "", email : String? = "",
        hireable: Bool? = false, bio : String? = "", twitter_username : String? = "",
        
        public_repos : Int?,
        public_gists : Int?,
        followers : Int?,
        following : Int?,
        
        created_at : String? = "", updated_at : String? = ""){
        
        self.init()
        
        self.login = login
        self.node_id = node_id
        self.avatar_url = avatar_url
        self.type = type
        self.site_admin = site_admin
        self.id = id
        
        self.gravatar_id = gravatar_id
        self.url = url
        self.html_url = html_url
        self.followers_url = followers_url
        self.following_url = following_url
        self.gists_url = gists_url
        self.starred_url = starred_url
        self.subscriptions_url = subscriptions_url
        self.organizations_url = organizations_url
        self.repos_url = repos_url
        self.events_url = events_url
        self.received_events_url = received_events_url
        self.name = name
        self.company = company
        self.blog = blog
        self.location = location
        self.email = email
        self.hireable = hireable
        self.bio = bio
        self.twitter_username = twitter_username
        
        self.public_repos.value = public_repos
        self.public_gists.value = public_gists
        self.followers.value = followers
        self.following.value = following
        
        self.created_at = created_at
        self.updated_at = updated_at
    }
    
    convenience required init(form decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let login = try container.decode(String.self, forKey: .login)
        let node_id = try container.decode(String.self, forKey: .node_id)
        let avatar_url = try container.decode(String.self, forKey: .avatar_url)
        let type = try container.decode(String.self, forKey: .type)
        let site_admin = try container.decode(Bool.self, forKey: .site_admin)
        let id = try container.decode(Int.self, forKey: .id)

        let gravatar_id = try container.decode(String.self, forKey: .gravatar_id)
        let url = try container.decode(String.self, forKey: .url)
        let html_url = try container.decode(String.self, forKey: .html_url)
        let followers_url = try container.decode(String.self, forKey: .followers_url)
        let following_url = try container.decode(String.self, forKey: .following_url)
        let gists_url = try container.decode(String.self, forKey: .gists_url)
        let starred_url = try container.decode(String.self, forKey: .starred_url)
        let subscriptions_url = try container.decode(String.self, forKey: .subscriptions_url)
        let organizations_url = try container.decode(String.self, forKey: .organizations_url)
        let repos_url = try container.decode(String.self, forKey: .repos_url)
        let events_url = try container.decode(String.self, forKey: .events_url)
        let received_events_url = try container.decode(String.self, forKey: .received_events_url)
        let name = try container.decode(String.self, forKey: .name)
        let company = try container.decode(String.self, forKey: .company)
        let blog = try container.decode(String.self, forKey: .blog)
        let location = try container.decode(String.self, forKey: .location)
        let email = try container.decode(String.self, forKey: .email)
        let hireable = try container.decode(Bool.self, forKey: .hireable)
        let bio = try container.decode(String.self, forKey: .bio)
        let twitter_username = try container.decode(String.self, forKey: .twitter_username)
        
        let public_repos = try container.decode(Int.self, forKey: .public_repos)
        let public_gists = try container.decode(Int.self, forKey: .public_gists)
        let followers = try container.decode(Int.self, forKey: .followers)
        let following = try container.decode(Int.self, forKey: .following)
        let created_at = try container.decode(String.self, forKey: .created_at)
        let updated_at = try container.decode(String.self, forKey: .updated_at)
        
        self.init(login:login,
                  node_id:node_id,
                  avatar_url:avatar_url,
                  type:type,
                  site_admin:site_admin,
                  id:id,
                  
                  gravatar_id: gravatar_id,
                  url: url,
                  html_url: html_url,
                  followers_url: followers_url,
                  following_url: following_url,
                  gists_url: gists_url,
                  starred_url: starred_url,
                  subscriptions_url: subscriptions_url,
                  organizations_url: organizations_url,
                  repos_url: repos_url, events_url: events_url,
                  received_events_url:received_events_url,
                  name: name,
                  company: company,
                  blog : blog,
                  location : location,
                  email : email,
                  hireable: hireable,
                  bio : bio,
                  twitter_username : twitter_username,
                  public_repos : public_repos,
                  public_gists : public_gists,
                  followers : followers,
                  following : following,
                  created_at : created_at, updated_at : updated_at)
    }
}

extension User {
    
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





//
//  ResponseUser.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/25/21.
//

import Foundation
// Temporary fix while bug exist in RealmSwift
// Reference: https://github.com.cnpmjs.org/realm/realm-cocoa/issues/6991

struct ResponseUser:Codable {
    let login: String
    let id: Int
    let node_id: String
    let avatar_url: String
    let type:String
    let site_admin:Bool
}

extension ResponseUser {
    static func all(pagination:Int = 0) -> Resource<[ResponseUser]>? {
        guard let url = URL(string: "https://api.github.com/users?since=\(pagination)") else {
            return nil
        }

        return Resource(url: url)
    }
}

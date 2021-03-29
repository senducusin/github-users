//
//  Encodable+Extensions.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/25/21.
//

import Foundation
extension Encodable {
    func toDictionary() -> [String: Any]? {
        if let data = try? JSONEncoder().encode(self) {
            if let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] {
                return dictionary
            }
        }
        
        return nil
    }
}

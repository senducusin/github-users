//
//  Detail.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/26/21.
//

import Foundation

struct Detail {
    let name: String
    var value: Any
    
    func valueString() ->String {
        return "\(value)"
    }
}

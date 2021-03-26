//
//  String+Extensions.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/26/21.
//

import Foundation
extension String {

    func camelCaseToWords() -> String {
        return unicodeScalars.reduce("") {
            if CharacterSet.uppercaseLetters.contains($1) {
                if $0.count > 0 {
                    return ("\($0) \(String($1))")
                }
            }
            return $0 + String($1)
        }
    }
}

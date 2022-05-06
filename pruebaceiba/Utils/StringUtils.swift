//
//  StringUtils.swift
//  pruebaceiba
//
//  Created by Juan Camilo Rodriguez Betacourt on 5/05/22.
//

import Foundation

class StringUtils{
    
    static func normalize(string: String)-> String{
        return string.lowercased().trimmingCharacters(in: .whitespaces)
        
    }
 
}

//
//  Resources_Model.swift
//  pruebaceiba
//
//  Created by Juan Camilo Rodriguez Betacourt on 3/05/22.
//

import Foundation



struct Request_d: Codable {

    let values: [Example]
  
    private enum CodingKeys: String, CodingKey {
       
            case values = "values"
          
        }
    init(values: [Example]){
        self.values = values
    }
}



struct Example: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
 
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case phone = "phone"
        case website = "website"
    }
    
    init(id: Int, name: String, username: String, email: String,phone: String, website: String){
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
       
    }
    
        
    
}
struct ExamplePosts: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
 
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
     
    }
    
    init(userId: Int, id: Int, title: String, body: String){
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
   
       
    }
    
        
    
}
struct ExamplePostsId: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
 
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
     
    }
    
    init(userId: Int, id: Int, title: String, body: String){
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
   
       
    }
    
        
    
}

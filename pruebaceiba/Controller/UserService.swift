//
//  UserService.swift
//  pruebaceiba
//
//  Created by Juan Camilo Rodriguez Betacourt on 3/05/22.
//

import Foundation
class ResourceService{

    private static var url =   "https://jsonplaceholder.typicode.com/"
    

   static func getUsers(completion:@escaping ([Example]) -> ()) {
       guard let url = URL(string: url + "users") else {
                print("Invalid url...")
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                let user = try! JSONDecoder().decode([Example].self, from: data!)
               
                DispatchQueue.main.async {
                    completion(user)
                }
            }.resume()
            
        }
    
    static func getPosts(completion:@escaping ([ExamplePosts]) -> ()) {
        guard let url = URL(string: url + "posts") else {
                 print("Invalid url...")
                 return
             }
             URLSession.shared.dataTask(with: url) { data, response, error in
                 let post = try! JSONDecoder().decode([ExamplePosts].self, from: data!)
                 print("post")
                
                 DispatchQueue.main.async {
                     completion(post)
                 }
             }.resume()
             
         }
    static func getPostsId(path: Int, completion:@escaping ([ExamplePostsId]) -> ()) {
        guard let url = URL(string: url + "posts?userId=\(path)") else {
                 print("Invalid url...")
                 return
             }
             URLSession.shared.dataTask(with: url) { data, response, error in
                 let post = try! JSONDecoder().decode([ExamplePostsId].self, from: data!)
                 print("post")
                
                 DispatchQueue.main.async {
                     completion(post)
                 }
             }.resume()
             
         }
  
}

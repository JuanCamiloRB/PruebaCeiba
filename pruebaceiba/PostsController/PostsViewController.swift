//
//  PostsViewController.swift
//  pruebaceiba
//
//  Created by Juan Camilo Rodriguez Betacourt on 6/05/22.
//

import UIKit

class PostsViewController: UIViewController {
    var idUser = Int()
    var postsId = [ExamplePostsId]()
    @IBOutlet weak var bkcBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.register(UINib(nibName: "PostViewCell", bundle: nil), forCellReuseIdentifier: "PostViewCell")
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            print(self.postsId)
        }
        ResourceService.getPostsId(path: idUser) { (books) in
            self.postsId = books
            print(books)
        }
        ResourceService.getPostsId(path: idUser,completion: { (result) -> () in
            self.makeGetCall(species: result)})
        // Do any additional setup after loading the view.
    }
    func makeGetCall(species: [ExamplePostsId]){
        var specieslbl = [String]()
        for i in species{
        
            let userId = i.userId as! Int
            let id = i.id as! Int
            let title = i.title as! String
            let body = i.body as! String
            self.postsId.append(ExamplePostsId(userId: userId, id: id, title: title, body: body))
          
                self.tableView.reloadData()
        }
        
    }
    
    
    @IBAction func onBkcBtn(_ sender: UIButton) {
        
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterViewController")as? FilterViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PostsViewController:  UITableViewDataSource, UITableViewDelegate{
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 140
   }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 49
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("postid")
        print(postsId.count)
        return postsId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell") as! PostViewCell
           
        
        DispatchQueue.main.async {
            
                var breedItem = self.postsId[indexPath.row]
                cell.titleLbl.text = breedItem.title
                cell.postLbl.text = breedItem.body
                cell.tag = indexPath.row
            cell.layer.cornerRadius = 15
                
        
        }
      
        return cell
    }
    
    
    
    
    
}

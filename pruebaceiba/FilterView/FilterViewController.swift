//
//  FilterViewController.swift
//  pruebaceiba
//
//  Created by Juan Camilo Rodriguez Betacourt on 3/05/22.
//

import UIKit
import MaterialComponents.MaterialTextFields

class FilterViewController: UIViewController {
  
    
    var users = [Example]()
    var usersList = [Example]()
    var posts = [ExamplePosts]()
    var filtered:[Example] = []
    var tmpUserdList = [Example]()
    var updatedString = String()
    var userUp = String()
    var keyboardHeight = CGFloat(0)
    var userFilt = String()
    var idUser = Int()
    
    private var placeHolderText = "Buscar Usuario"
    private var textIn: MDCTextField!
    private var controller: MDCTextInputControllerOutlined!
    private let textColor = UIColor(red: (0/255.0), green: (85/255.0), blue: (0/255.0), alpha: 1.0)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBInspectable var setPlaceholder: String{
        get{
            
            return placeHolderText
        }
        set(str){
            placeHolderText = str
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        textField.isHidden = true
        tableView.reloadData()
        setupInputView()
        setupContoller()
        placeHolderText = "Buscar Usuario"
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            print(self.filtered)
        }
        DispatchQueue.main.async {
        
            self.textField.becomeFirstResponder()
            
        }
        
        ResourceService.getUsers { (books) in
            self.users = books
            
        }
        ResourceService.getPosts { (books) in
            self.posts = books
        }
        ResourceService.getUsers(completion: { (result) -> () in
            self.makeGetCall(species: result)})
        
    }
    
    
    @objc func keyboardWillShow(notification:NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            // The 1st keyboardWillShow gets the keyboard size height then observer removed as no need to get keyboard height every time it shows or hides
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            
            // Store KeyboardHeight in UserDefaults to use when in Edit Mode
            UserDefaults.standard.set(keyboardHeight, forKey: "KeyboardHeight")
            UserDefaults.standard.synchronize()
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
    func makeGetCall(species: [Example]){
        var specieslbl = [String]()
        for i in species{
            let id = i.id as! Int
            let name = i.name as! String
            let username = i.username as! String
            let email = i.email as! String
            let phone = i.phone as! String
            let website = i.website as! String
            self.users.append(Example(id: id, name: name, username: username, email: email,phone: phone, website: website))
          
                self.tableView.reloadData()
        }
        
    }
    private func setupInputView(){
        //MARK: Text Input Setup
        
        if let _ = view.viewWithTag(1){return}
        textIn = MDCTextField()
        textIn.tag = 1
        textIn.font = UIFont(name: "Rubik", size: 16)
        textIn.translatesAutoresizingMaskIntoConstraints = false
        textIn.placeholderLabel.isEnabled = true
        textIn.isEnabled = true
        textIn.sizeToFit()
        textIn.rightViewMode = .always
        textIn.clearButton.isHidden = true
        textIn.placeholderLabel.font = UIFont(name: "Rubik", size: 40)
        textIn.placeholderLabel.backgroundColor =  UIColor(red: (247/255.0), green: (243/255.0), blue: (240/255.0), alpha: 1.0)
        view.addSubview(textIn)
        textIn.placeholder = placeHolderText
        textIn.delegate = self
        
        textIn.textColor = UIColor(red: (0/255.0), green: (85/255.0), blue: (0/255.0), alpha: 1.0)
        NSLayoutConstraint.activate([
            (textIn.topAnchor.constraint(equalTo: textField.topAnchor)),
            (textIn.bottomAnchor.constraint(equalTo: textField.bottomAnchor)),
            (textIn.leadingAnchor.constraint(equalTo: textField.leadingAnchor)),
            (textIn.trailingAnchor.constraint(equalTo: textField.trailingAnchor))
        ])
    }
    
    private func setupContoller(){
        // MARK: Text Input Controller Setup
        
        controller = MDCTextInputControllerOutlined(textInput: textIn)
        
        controller.activeColor = textColor
        controller.normalColor = textColor
        controller.textInput?.textColor = UIColor(red: (0/255.0), green: (85/255.0), blue: (0/255.0), alpha: 1.0)
        controller.inlinePlaceholderColor = UIColor(red: (128/255.0), green: (125/255.0), blue: (124/255.0), alpha: 1.0)
        controller.floatingPlaceholderActiveColor = UIColor(red: (128/255.0), green: (125/255.0), blue: (124/255.0), alpha: 1.0)
        controller.floatingPlaceholderNormalColor = UIColor(red: (128/255.0), green: (125/255.0), blue: (124/255.0), alpha: 1.0)
        controller.textInputFont = UIFont(name: "Rubik", size: 16)
        controller.textInputClearButtonTintColor =  UIColor(red: (128/255.0), green: (125/255.0), blue: (124/255.0), alpha: 1.0)
        controller.borderRadius = 12
        controller.leadingUnderlineLabelFont = UIFont(name: "Rubik", size: 40)
        controller.inlinePlaceholderFont = UIFont(name: "Rubik", size: 16)
        controller.trailingUnderlineLabelFont = UIFont(name: "Rubik", size: 40)
        controller.floatingPlaceholderScale = 1.0000001
        controller.isAccessibilityElement = true
        controller.isFloatingEnabled = true
        controller.underlineHeightNormal = 20
        controller.underlineHeightActive = 20
        
    }
    
    
    func filter(){
        var updatedStrigNormalize = StringUtils.normalize(string: updatedString)
        
        filtered = users.filter({ (userUp) -> Bool in
            var breedUpNormalize = StringUtils.normalize(string: userUp.name)
            return breedUpNormalize.contains(updatedStrigNormalize) && ((usersList.first(where: {breedUpNormalize  == StringUtils.normalize(string: $0.name)})) == nil)
            
        })
        if users.first(where: {StringUtils.normalize(string: $0.name) == updatedStrigNormalize}) == nil && usersList.first(where: {StringUtils.normalize(string: $0.name) == updatedStrigNormalize}) == nil{
            
        }
        self.tableView.reloadData()
        print(updatedString)
        print("updatestring")
        print(filtered)
        
    }
    func animateViewMoving (_ up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        UIView.commitAnimations()
        print("Moviendo")
        
    }
    
}

    
  
extension FilterViewController:  UITableViewDataSource, UITableViewDelegate, UserCellCellDelegate{
   
   
    func btnPosts(sender: UIButton, at index: IndexPath) {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostsViewController")as? PostsViewController
            if self.filtered.count == 2 && !self.updatedString.isEmpty {
                for i in filtered{
                    let id = i.id as! Int
                    let name = i.name as! String
                    let username = i.username as! String
                    let email = i.email as! String
                    let phone = i.phone as! String
                    let website = i.website as! String
                    idUser = id
                }
             
                print(idUser)
               
                
                vc!.idUser =  idUser
               
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        if self.filtered.count == 0 && self.updatedString.isEmpty {
            
            print("button tapped at index:\(index.item)")
            
            vc!.idUser =  index.item + 1
           
            self.navigationController?.pushViewController(vc!, animated: true)

            }
          
            
        }
     
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 130
   }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 49
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filtered.count > 0 && !self.updatedString.isEmpty{
            return filtered.count/2
        }else{
        if filtered.count == 0 && !updatedString.isEmpty{
            return 1
         }
        }
        
        return users.count/2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
           cell.delegate = self
           cell.indexPath = indexPath
        
        DispatchQueue.main.async {
            if self.filtered.count > 0 && self.updatedString.count < 5{
                
                var breedItem = self.filtered[indexPath.row]
                cell.nameLbl.text = breedItem.name
                cell.emailLbl.text = breedItem.email
                cell.phoneLbl.text = breedItem.phone
                self.userFilt = breedItem.name
                cell.posBtn.isHidden = false
                cell.imgEmail.isHidden = false
                cell.imgPhone.isHidden = false
                cell.indexPath = indexPath
                cell.tag = indexPath.row
           
                
            }else{
                if self.filtered.count == 0 && self.updatedString.isEmpty {
                    var breedItem = self.users[indexPath.row]
                    cell.nameLbl.text = breedItem.name
                    cell.emailLbl.text = breedItem.email
                    cell.phoneLbl.text = breedItem.phone
                    cell.posBtn.isHidden = false
                    cell.imgEmail.isHidden = false
                    cell.imgPhone.isHidden = false
                    self.userFilt = breedItem.name
                }else{
                    if self.filtered.count == 0 && !self.updatedString.isEmpty {
                        var breedItem = self.users[indexPath.row]
                        cell.nameLbl.text = "List is Empty"
                        cell.emailLbl.text = ""
                        cell.phoneLbl.text = ""
                        cell.posBtn.isHidden = true
                        cell.imgEmail.isHidden = true
                        cell.imgPhone.isHidden = true
                        
                        self.userFilt = breedItem.name
            }
        }
            
        }
        
        }
        cell.layer.cornerRadius = 30
        return cell
    }
    
    
    
    
    
}
extension FilterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        
        if textField == textIn {
            
            DispatchQueue.main.async{
                
                var text: String = self.textIn.text!
                
                self.updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
                
                let replaced = self.updatedString.replacingOccurrences(of: "Optional", with: "Small")
                self.updatedString = replaced
                print(self.updatedString)
                self.filter()
            }
            
            let allowedCharacters = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        DispatchQueue.main.async {
            self.animateViewMoving(false, moveValue: self.keyboardHeight + 50)
        }
        print("down")
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.animateViewMoving(true, moveValue: self.keyboardHeight + 50 )
        }
    
        
    }
    
    
    
}


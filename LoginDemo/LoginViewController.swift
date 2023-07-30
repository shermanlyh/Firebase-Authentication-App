//
//  LoginViewController.swift
//  LoginDemo
//
//  Created by Shermanlyh on 2023/7/28.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
   
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var createAcBtn: UIButton!
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        //Hide Error label
        errorLabel.alpha = 0
        //style the element
        Utilities.styleTextField(pwField)
        Utilities.styleTextField(userNameField)
        Utilities.styleFilledButton(loginBtn)
        Utilities.styleHollowButton(createAcBtn)
        
    }

    //c@t.com
    //test12345!
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func validateFields() -> String? {
        // check field
        
        if userNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || pwField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all field"
        }
        
      
        
        
        return nil
    }
    func transistToHome(uid:String){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController
        homeViewController?.userID = uid
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        //Validate Text Field
        let err = validateFields()
        
        
        
        if err != nil{
            showError(err!)
        }else{ //Sign in
            let email = userNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pw = pwField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: pw){(result,err) in
                if err != nil{
                    self.showError(err!.localizedDescription)
                }else{
                    self.transistToHome(uid: result!.user.uid)
                   
                    
                }
                
            }
        }
        
       
    }
}

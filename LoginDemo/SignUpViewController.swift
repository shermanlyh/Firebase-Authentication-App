//
//  SignUpViewController.swift
//  LoginDemo
//
//  Created by Shermanlyh on 2023/7/28.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class SignUpViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var lNField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var fNField: UITextField!
    var userData = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(pwField)
        Utilities.styleTextField(emailField)
        Utilities.styleTextField(lNField)
        Utilities.styleTextField(fNField)
        Utilities.styleFilledButton(signUpBtn)
        Utilities.styleHollowButton(loginBtn)
        
    }
    // func that return nil when validation success, return error message when occur failure
    func validateFields() -> String? {
        // check field
        
        if fNField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lNField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || pwField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all field"
        }
        
        //check password
        let cleanPassword = pwField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(Utilities.isPasswordValid(cleanPassword) == false){
            return "Please make sure your password is at least 8 characters ,contain a special character and a number."
        }
    
        
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        //validate fields
        //create user
        //transition to home screen
        let error = validateFields()
        
        if error != nil{
            
            showError(error!)
        }else{
            let firstName = fNField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lNField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = pwField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        
            
            
            Auth.auth().createUser(withEmail: emailField.text!, password: pwField.text!){(result,error) in
                //check error
                if let error = error{
                    //error exist
                    self.showError("Error creating user")
                }else{
                    
                    print("what is user id ",result!.user.uid)
                    self.userData = result!.user.uid
                    //Success, now store first and last name
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstName,"lastname":lastName,"uid":result!.user.uid]){(error) in
                        
                        if error != nil{
                            self.showError("Error saving user data")
                        }
                    }
                    //past to home screen
                    self.transistToHome()
                }
                
            }
        }
    }
    
    func transistToHome(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController
        homeViewController?.userID = userData
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}

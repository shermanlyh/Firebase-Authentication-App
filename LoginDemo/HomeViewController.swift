//
//  HomeViewController.swift
//  LoginDemo
//
//  Created by Shermanlyh on 2023/7/28.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var logOutBtn: UIButton!
    var userID :String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Utilities.styleFilledButton(logOutBtn)
        displayData()
    }
    
    //display first and last name of user
    func displayData(){
        let db = Firestore.firestore()
        let docRef = db.collection("users").whereField("uid", isEqualTo: userID)
        docRef
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var lastName = ""
                    var firstName = ""
                    for document in querySnapshot!.documents {
                        lastName = document.data()["lastname"] as! String
                        firstName = document.data()["firstname"] as! String
                        
                    }
                    self.welcomeLabel.text! = "Welcome \(firstName) \(lastName)"
                    
                }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func transistToHome(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "firstPageVC") as? ViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    @IBAction func logOutTapped(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            print("Successfully Log Out")
            self.transistToHome()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

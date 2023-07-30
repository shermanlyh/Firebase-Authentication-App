//
//  ViewController.swift
//  LoginDemo
//
//  Created by Shermanlyh on 2023/7/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }

    func setUpElements(){
      
        //style the element
        Utilities.styleFilledButton(loginBtn)
        Utilities.styleHollowButton(signUpBtn)
      
        
    }
}


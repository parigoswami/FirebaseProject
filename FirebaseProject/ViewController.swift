//
//  ViewController.swift
//  FirebaseProject
//
//  Created by pari on 02/08/17.
//  Copyright © 2017 pari. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userx =  Auth.auth().currentUser
        if userx != nil{
            let uid = userx?.uid
            let eml = userx?.email
            print(uid ?? "nil")
            print(eml ?? "nil")
            let strbd = UIStoryboard.init(name: "Main", bundle: nil)
            let svc = strbd.instantiateViewController(withIdentifier: "secondvc")
            navigationController?.pushViewController(svc, animated: true)
        }
    }
    
    
    @IBAction func LogInAction(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
            if(error == nil){
                print(user?.uid ?? "nilllll")
                print(user?.email ?? "nillll")
            }
        }
        
    }
    
    @IBAction func googleSignIn(_ sender: Any){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


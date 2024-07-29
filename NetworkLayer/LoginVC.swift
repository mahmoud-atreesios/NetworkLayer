//
//  LoginVC.swift
//  NetworkLayer
//
//  Created by Mahmoud Mohamed Atrees on 29/07/2024.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let uaserName = userName.text , let password = password.text{
            let userCredntials = verifyUser(userName: uaserName, password: password)
            if userCredntials{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC {
                    self.present(vc, animated: true, completion: nil)
                }
            }else{
                print("credntials are incorrect")
            }
        }
        
    }
    
}

extension LoginVC{
    func verifyUser(userName: String, password: String) -> Bool{
        if userName == "mahmoud" && password == "123456"{
            return true
        }else{
            return false
        }
    }
}

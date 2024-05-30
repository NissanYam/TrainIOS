//
//  LogInController.swift
//  TrainTrack
//
//  Created by user262074 on 5/27/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LogInController: UIViewController {
    let db = Firestore.firestore()

    @IBOutlet weak var UserPassword: UITextField!
    @IBOutlet weak var UserEmail: UITextField!
    var email : String?
    var password : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("In LogIn Page!")
        
    }
    
    @IBAction func clickOnLogIn(_ sender: UIButton){
        if let email = UserEmail.text ,let password = UserPassword.text{
            if isValidEmail(email) && isValidPassword(password){
                FirebaseCalls.signIn(email: email, password: password) { success, error in
                    if let error = error {
                        print("Error signing in: \(error.localizedDescription)")
                    } else if success {
                        FirebaseCalls.readUser(email: email) { user, error in
                            if let error = error {
                                print("Error reading user: \(error.localizedDescription)")
                            } else if user != nil {
                                HomePageController.userEmail = email
                                self.performSegue(withIdentifier: "goToHomePageStoryboard", sender: self)
                            } else {
                                print("No user found with this email")
                            }
                        }
                    }
                }
            }else{
                print("isValidEmail(email!) = \(isValidEmail(email)) , \(String(describing: email))")
                print("isValidPassword(password!) = \(isValidPassword(password)) , \(String(describing: password))")
                UserEmail.text = nil
                UserPassword.text = nil
            }
            UserEmail.text = nil
            UserPassword.text = nil
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomePageStoryboard"{
            guard let vc = segue.destination as? HomePageController else {return}
            vc.modalPresentationStyle = .fullScreen
        }
    }
}

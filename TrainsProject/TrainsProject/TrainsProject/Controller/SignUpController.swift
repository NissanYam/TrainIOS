//
//  SignUpController.swift
//  TrainTrack
//
//  Created by user262074 on 5/27/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SignUpController: UIViewController {
    let db = Firestore.firestore()
    
    
    @IBOutlet weak var UserEmail: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var UserWeight: UITextField!
    @IBOutlet weak var UserHeight: UITextField!
    @IBOutlet weak var UserAge: UITextField!
    var userEmailStr : String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func SignInClicked(_ sender: UIButton) {
        print("Sign UP Clicked")
        if let userEmail = UserEmail.text,
           let userName = UserName.text,
           let userPassword = UserPassword.text,
           let userWeightText = UserWeight.text,
           let userHeightText = UserHeight.text,
           let userAgeText = UserAge.text,
           let userWeight = Double(userWeightText),
           let userHeight = Double(userHeightText),
           let userAge = Int(userAgeText) {
            guard userAge > 0 else {
                print("Invalid age")
                return
            }
            guard userWeight >= 0 else {
                print("Invalid weight")
                return
            }
            guard userHeight >= 0 else {
                print("Invalid height")
                return
            }
            FirebaseCalls.signUp(email: userEmail, password: userPassword) { success, error in
                if let error = error {
                    print("Error signing up: \(error.localizedDescription)")
                } else if success {
                    let user = User(email: userEmail, name: userName, age: Int(userAge), weight: Double(userWeight), height: Double(userHeight),trains: [])
                    self.userEmailStr = user.email
                    FirebaseCalls.writeUser(user: user) { success, error in
                        if let error = error {
                            print("Error writing user: \(error.localizedDescription)")
                        } else if success {
                            print("User data written successfully")
                            HomePageController.userEmail = user.email
                            self.performSegue(withIdentifier: "goToHomePageStoryboard", sender: self)
                        }
                    }
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomePageStoryboard" {
            guard let vc = segue.destination as? HomePageController else {return}
            vc.modalPresentationStyle = .fullScreen
        }
    }
}

//
//  WelcomeController.swift
//  TrainTrack
//
//  Created by user262074 on 5/27/24.
//
import UIKit

class WelcomeController: UIViewController {


    @IBOutlet weak var LogInBotton: UIButton!
    
    @IBOutlet weak var SignInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LogInBotton.layer.cornerRadius = 10
        LogInBotton.clipsToBounds = true
        
    }

    @IBAction func LogInPress(_ sender: UIButton) {
        print("Log In Pressed")
        performSegue(withIdentifier: "goToLogInStoryboard" ,sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "goToLogInStoryboard":
                if let vc = segue.destination as? LogInController {
                }
            case "goToSignUpStoryboard":
                if let vc = segue.destination as? SignUpController {
                }
            default:
                break
            }
        }
    }
    
    
    @IBAction func SignInPress(_ sender: UIButton) {
        print("Sign Up Pressed")
        let signinVC = SignUpController()
        performSegue(withIdentifier: "goToSignUpStoryboard" ,sender: self)
    }
}

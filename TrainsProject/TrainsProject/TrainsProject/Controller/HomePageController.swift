//
//  HomePageController.swift
//  TrainTrack
//
//  Created by user262074 on 5/28/24.
//

import UIKit
import FirebaseAuth

class HomePageController: UIViewController {
    @IBOutlet weak var UserNameLable: UILabel!
    @IBOutlet weak var tableViewTrainings: UITableView!
    @IBOutlet weak var titleTrainings: UILabel!
    static var userEmail : String?
    var user : User? = nil
    func getUser(){
        if let userEmail = HomePageController.userEmail {
            FirebaseCalls.readUser(email: userEmail) { [weak self] user, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error reading user: \(error.localizedDescription)")
                } else if let user = user {
                    self.user = user
                    self.UserNameLable.text = "Hello \(user.name)"
                    if user.trains.count == 0{
                        titleTrainings.isHidden = true
                    }else{
                        titleTrainings.isHidden = false
                    }
                    self.tableViewTrainings.reloadData()
                    print("reload data")
                }
            }
        } else {
            print("User email is nil")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            getUser()
            
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewTrainings.delegate = self
        tableViewTrainings.dataSource = self
        tableViewTrainings.register(UINib(nibName: "TrainingCell",bundle: nil),forCellReuseIdentifier: "TrainingCellID")
        getUser()
        
    }
    @IBAction func addNewTrain(_ sender: UIButton) {
        print("Add new train")
        performSegue(withIdentifier: "goToAddingNewTrainingStoryboard", sender: self)
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        print("Log out pressed")
        FirebaseCalls.signOut { success, error in
            if success {
                print("Log out successful")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            } else if let error = error {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddingNewTrainingStoryboard"{
            guard let vc = segue.destination as? AddNewTrainingController else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.userEmail = self.user!.email
        }
    }
}
extension HomePageController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let user = self.user{
            return user.trains.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewTrainings.dequeueReusableCell(withIdentifier: "TrainingCellID", for: indexPath) as! TrainingCell
        if self.user != nil{
            cell.trainNameLable.text = self.user!.trains[indexPath.row].trainName
            cell.trainDateLabe.text = self.user!.trains[indexPath.row].trainDate
            cell.trainDurationTimeLabe.text = self.user!.trains[indexPath.row].durationTime
            cell.caloriesLable.text = "cal :\(self.user!.trains[indexPath.row].calories)"
        }
        return cell
    }
    
    
}
extension HomePageController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

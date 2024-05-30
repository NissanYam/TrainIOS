//
//  AddNewTrainingController.swift
//  TrainsProject
//
//  Created by user262074 on 5/29/24.
//

import UIKit

class AddNewTrainingController: UIViewController {
    
    @IBOutlet weak var trainingTakedTime: UITextField!
    @IBOutlet weak var trainingCalories: UITextField!
    @IBOutlet weak var TrainingDate: UITextField!
    @IBOutlet weak var trainingName: UITextField!
    @IBOutlet weak var exerciseName: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var numberOfRepets: UITextField!
    @IBOutlet weak var numberOfSets: UITextField!
    @IBOutlet weak var tableViewExercises: UITableView!
    @IBOutlet weak var dayInput: UITextField!
    @IBOutlet weak var mounthInput: UITextField!
    @IBOutlet weak var yearInput: UITextField!
    @IBOutlet weak var hourInput: UITextField!
    @IBOutlet weak var minInput: UITextField!
    var exercises : [Exercise] = []
    var userEmail : String?
    override func viewDidLoad() {
        tableViewExercises.delegate = self
        tableViewExercises.dataSource = self
        tableViewExercises.register(UINib(nibName: "ExerciseCell",bundle: nil),forCellReuseIdentifier: "ExerciseCellID")
    }
    @IBAction func addNewExercise(_ sender: Any) {
        if let exerName = exerciseName.text,
           let repe = numberOfRepets.text,
           let sets = numberOfSets.text,
           let w = weight.text,
           let rep = Int(repe),
           let set = Int(sets),
           let wei = Double(w) {
            if wei <= 0 || rep <= 0 || set <= 0 {
                return
            }
            let exer = Exercise(name: exerName, sets: set, repets: rep, weight: wei)
            exerciseName.text = nil
            numberOfSets.text = nil
            numberOfRepets.text = nil
            weight.text = nil
            self.exercises.append(exer)
            tableViewExercises.reloadData()
        }
    }
    
    @IBAction func addNewTraining(_ sender: Any) {
        var date = ""
        var time = ""
        if let day = dayInput.text,
           let month = mounthInput.text,
           let year = yearInput.text,
           let dayI = Int(day),
           let monthI = Int(month),
           let yearI = Int(year){
            if checkValidDay(day: dayI, month: monthI, year: yearI) == false{
                return
            }
            date = "\(dayI)/\(monthI)/\(yearI)"
        }
        if let hour = hourInput.text,
           let minute = minInput.text,
           let hourI = Int(hour),
           let minuteI = Int(minute){
            if checkValidHour(hour: hourI, minutes: minuteI) == false{
                return
            }
            time = "\(hour) : \(minute)"
            
        }
        guard let trainName = trainingName.text,
              let caloriesText = trainingCalories.text,
              let calories = Int(caloriesText) else {
            return
        }
        
        let train = Train(trainName: trainName,
                          trainDate: date,
                          calories: calories,
                          durationTime: time,
                          exercises: self.exercises)
        FirebaseCalls.readUser(email: self.userEmail!) { user, error in
            if let error = error {
                print("Error reading user: \(error.localizedDescription)")
            } else if let user = user {
                user.trains.append(train) // Assuming trains is an array in your User model
                FirebaseCalls.updateUser(user: user) { success, error in
                    if let error = error {
                        print("Error updating user: \(error.localizedDescription)")
                    } else if success {
                        print("User data updated successfully")
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            } else {
                print("No user found with this email")
            }
        }
    }
}
extension AddNewTrainingController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewExercises.dequeueReusableCell(withIdentifier: "ExerciseCellID", for: indexPath) as! ExerciseCell
        cell.exerciseNameLabel.text = exercises[indexPath.row].name
        cell.ExercsieReipitsLable.text = "R : \(exercises[indexPath.row].repets)"
        cell.exerciseSetsLable.text = "S : \(exercises[indexPath.row].sets)"
        cell.exerciseWeightLable.text = "W :\(exercises[indexPath.row].weight)"
        return cell
    }
    
    
}
extension AddNewTrainingController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

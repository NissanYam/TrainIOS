import Foundation

class Train {
    var trainName: String
    var trainDate: String
    var calories: Int
    var durationTime: String
    var exercises: [Exercise]
    
    init(trainName: String, trainDate: String, calories: Int, durationTime: String, exercises: [Exercise]) {
        self.trainName = trainName
        self.trainDate = trainDate
        self.calories = calories
        self.durationTime = durationTime
        self.exercises = exercises
    }
    
    func toDict() -> [String: Any] {
        let trainData: [String: Any] = [
            "trainName": self.trainName,
            "trainDate": self.trainDate,
            "calories": self.calories,
            "durationTime": self.durationTime,
            "exercises": self.exercises.map { $0.toDict() }
        ]
        return trainData
    }
    
    static func fromDict(_ dict: [String: Any]) -> Train? {
        guard
            let trainName = dict["trainName"] as? String,
            let trainDate = dict["trainDate"] as? String,
            let calories = dict["calories"] as? Int,
            let durationTime = dict["durationTime"] as? String,
            let exerciseDicts = dict["exercises"] as? [[String: Any]]
        else {
            return nil
        }
        
        let exercises = exerciseDicts.compactMap { Exercise.fromDict($0) }
        return Train(trainName: trainName, trainDate: trainDate, calories: calories, durationTime: durationTime, exercises: exercises)
    }
}

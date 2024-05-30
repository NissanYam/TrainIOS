class User {
    var email: String
    var name: String
    var age: Int
    var weight: Double
    var height: Double
    var trains: [Train]
    
    init(email: String, name: String, age: Int, weight: Double, height: Double, trains: [Train]) {
        self.email = email
        self.name = name
        self.age = age
        self.weight = weight
        self.height = height
        self.trains = trains
    }
    
    func toDict() -> [String: Any] {
        let userData: [String: Any] = [
            "email": self.email,
            "name": self.name,
            "age": self.age,
            "weight": self.weight,
            "height": self.height,
            "trains": self.trains.map { $0.toDict() }
        ]
        return userData
    }
    
    static func fromDict(_ dict: [String: Any]) -> User? {
        guard
            let email = dict["email"] as? String,
            let name = dict["name"] as? String,
            let age = dict["age"] as? Int,
            let weight = dict["weight"] as? Double,
            let height = dict["height"] as? Double,
            let trainDicts = dict["trains"] as? [[String: Any]]
        else {
            return nil
        }
        
        let trains = trainDicts.compactMap { Train.fromDict($0) }
        return User(email: email, name: name, age: age, weight: weight, height: height, trains: trains)
    }
}

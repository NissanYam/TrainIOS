import Foundation

class Exercise {
    var name: String
    var sets: Int
    var repets: Int
    var weight: Double
    
    init(name: String, sets: Int, repets: Int, weight: Double) {
        self.name = name
        self.sets = sets
        self.repets = repets
        self.weight = weight
    }
    
    func toDict() -> [String: Any] {
        return [
            "name": self.name,
            "sets": self.sets,
            "repets": self.repets,
            "weight": self.weight
        ]
    }
    
    static func fromDict(_ dict: [String: Any]) -> Exercise? {
        guard
            let name = dict["name"] as? String,
            let sets = dict["sets"] as? Int,
            let repets = dict["repets"] as? Int,
            let weight = dict["weight"] as? Double
        else {
            return nil
        }
        
        return Exercise(name: name, sets: sets, repets: repets, weight: weight)
    }
}

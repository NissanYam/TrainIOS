import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseCalls {
    let db = Firestore.firestore()

    static func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    static func signUp(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                completion(false, error)
            } else {
                // User created successfully
                completion(true, nil)
            }
        }
    }
    static func signOut(completion: @escaping (Bool, Error?) -> Void) {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                print("Sign out successful")
                completion(true, nil)
            } catch let signOutError as NSError {
                print("Error signing out: \(signOutError.localizedDescription)")
                completion(false, signOutError)
            }
        }
    static func readUser(email: String, completion: @escaping (User?, Error?) -> Void) {
        let userCollection = Firestore.firestore().collection("Users")
        let query = userCollection.whereField("email", isEqualTo: email)
        query.getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            if let documents = querySnapshot?.documents {
                if documents.isEmpty {
                    print("No user found with this email")
                    completion(nil, nil)
                    return
                }
                let userData = documents[0].data()
                let user = User.fromDict(userData)
                completion(user, nil)
            }
        }
    }
    static func writeUser(user: User, completion: @escaping (Bool, Error?) -> Void) {
        let userData: [String: Any] = user.toDict()
        
        // Add user data to Firestore
        Firestore.firestore().collection("Users").document(user.email).setData(userData) { error in
            if let error = error {
                print("Error writing user data: \(error.localizedDescription)")
                completion(false, error)
            } else {
                print("User data written successfully")
                completion(true, nil)
            }
        }
    }
    static func updateUser(user: User, completion: @escaping (Bool, Error?) -> Void) {
            let userData: [String: Any] = user.toDict()
            
            Firestore.firestore().collection("Users").document(user.email).updateData(userData) { error in
                if let error = error {
                    print("Error updating user data: \(error.localizedDescription)")
                    completion(false, error)
                } else {
                    print("User data updated successfully")
                    completion(true, nil)
                }
            }
        }

}

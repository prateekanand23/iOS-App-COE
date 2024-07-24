import SwiftUI
import Foundation
import FirebaseDatabase

class FirebaseManager: ObservableObject {
    private var ref: DatabaseReference = Database.database().reference()
    
    func insertUser(username: String, email: String, password: String, completion: @escaping (String?) -> Void) {
        let newUser = [
            "username": username,
            "email": email,
            "password": password
        ]
        ref.child("users").childByAutoId().setValue(newUser) { (error, reference) in
            if let error = error {
                completion("Error: \(error.localizedDescription)")
            } else {
                completion("User data inserted successfully")
            }
        }
    }
    
    func authenticateUser(username: String, password: String, completion: @escaping (String?) -> Void) {
        ref.child("users").observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let userData = childSnapshot.value as? [String: String],
                       let storedUsername = userData["username"],
                       let storedPassword = userData["password"],
                       storedUsername == username,
                       storedPassword == password {
                        completion(nil) // Authentication successful
                        return
                    }
                }
                completion("Invalid username or password")
            } else {
                completion("No users found")
            }
        }
    }

    func enrollUserInCourse(username: String, course: String, completion: @escaping (String?) -> Void) {
        let enrollment = [
            "username": username,
            "course": course
        ]
        ref.child("enrollments").childByAutoId().setValue(enrollment) { (error, reference) in
            if let error = error {
                completion("Error: \(error.localizedDescription)")
            } else {
                completion("Enrollment successful")
            }
        }
    }
}

struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var message: String = ""
    @ObservedObject private var firebaseManager = FirebaseManager()
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .disableAutocorrection(true)
                .textContentType(.oneTimeCode)
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .disableAutocorrection(true)
                .textContentType(.oneTimeCode)
            Button(action: {
                if password == confirmPassword {
                    firebaseManager.insertUser(username: username, email: email, password: password) { result in
                        message = result ?? "Unknown error"
                    }
                } else {
                    message = "Passwords do not match"
                }
            }) {
                Text("Sign Up")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Text(message)
                .foregroundColor(.red)
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

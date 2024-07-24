import SwiftUI

struct SignInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String = ""
    @State private var isSignedIn: Bool = false
    @ObservedObject private var firebaseManager = FirebaseManager()
    
    var body: some View {
        NavigationStack {
            
                VStack {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.6))
                        .cornerRadius(19)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.6))
                        .cornerRadius(19)
                        .disableAutocorrection(true)
                        .textContentType(.oneTimeCode)
                    Button(action: {
                        firebaseManager.authenticateUser(username: username, password: password) { result in
                            if result == nil {
                                isSignedIn = true
                            } else {
                                message = result!
                            }
                        }
                    }) {
                        Text("Sign In")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Text(message)
                        .foregroundColor(.red)
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                    }
                    
                    NavigationLink(destination: WelcomeView(username: username), isActive: $isSignedIn) {
                        EmptyView()
                    }
                }
                NavigationLink(destination: CoursesView(username: username), isActive: $isSignedIn) {
                    EmptyView()
                }
                .padding()
                .navigationTitle("Sign In")
            }
        }
    }
    
    struct SignInView_Previews: PreviewProvider {
        static var previews: some View {
            SignInView()
        }
    }


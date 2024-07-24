import SwiftUI

struct WelcomeView: View {
    let username: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image
                Image("background1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 3)
                VStack {
                    
                    Text("Welcome, \(username)!")
                        .font(.largeTitle)
                        .padding()
                    Text("You have successfully signed in.")
                    NavigationLink(destination: CoursesView(username: username)) {
                        Text("View Courses")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.top, 20)
                    }
                }
                .padding()
                .navigationTitle("Welcome")
            }
        }
    }
    
    struct WelcomeView_Previews: PreviewProvider {
        static var previews: some View {
            WelcomeView(username: "testuser")
        }
    }
}

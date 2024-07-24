import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("User Profile")
                .font(.largeTitle)
                .padding()
            Button(action: {
                // Handle log out action
            }) {
                Text("Log Out")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Profile")
    }
}

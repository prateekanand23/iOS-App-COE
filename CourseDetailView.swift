import SwiftUI

struct CourseDetailView: View {
    let course: String
    let username: String
    @State private var message: String = ""
    @ObservedObject private var firebaseManager = FirebaseManager()
    
    var body: some View {
        VStack {
            Text(course)
                .font(.largeTitle)
                .padding()
            Text("Course description and details go here.")
            Button(action: {
                firebaseManager.enrollUserInCourse(username: username, course: course) { result in
                    message = result ?? "Unknown error"
                }
            }) {
                Text("Enroll")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Text(message)
                .foregroundColor(message == "Enrollment successful" ? .green : .red)
        }
        .padding()
        .navigationTitle("Course Details")
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(course: "iOS App Development", username: "testuser")
    }
}

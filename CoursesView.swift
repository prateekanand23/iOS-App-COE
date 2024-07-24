import SwiftUI

struct CoursesView: View {
    let username: String
    let courses = ["Cloud Security COE","AI/ML COE", "HPC Intel High Performance Computation", "iOS App Development"]

    var body: some View {
        NavigationStack {
            List(courses, id: \.self) { course in
                NavigationLink(destination: CourseDetailView(course: course, username: username)) {
                    Text(course)
                }
            }
            .navigationTitle("Courses")
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView(username: "testuser")
    }
}

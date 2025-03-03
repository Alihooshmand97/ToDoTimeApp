import SwiftUI

struct CreatorInfoView: View {
    @State private var navigateToMainApp = false

    var body: some View {
        NavigationView {
            VStack {
                Text("ToDoTime")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                Text("Created by:")
                    .font(.headline)
                    .padding(.bottom, 5)

                Text("Ali Hooshmandghasrodashti\nStudent ID: 101261322")
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)

                Text("Hooman Afsharnia\nStudent ID: 101466119")
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)

                Text("Group 13")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                Spacer()

                NavigationLink(destination: ContentView(), isActive: $navigateToMainApp) {
                    EmptyView()
                }

                Button(action: {
                    navigateToMainApp = true
                }) {
                    Text("Continue to App")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    CreatorInfoView()
}

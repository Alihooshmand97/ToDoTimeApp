import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            CreatorInfoView() // Moves to the Creator Info Screen after 3 seconds
        } else {
            VStack {
                Image("ToDoTimeLogo") // Your logo from Assets.xcassets
                    .resizable()
                    .frame(width: 150, height: 150)

                Text("ToDoTime")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white) // Ensures a clean background
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}

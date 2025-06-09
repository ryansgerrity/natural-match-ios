import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                // App Logo/Icon Area
                Image(systemName: "heart.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.pink)
                
                // App Title
                VStack(spacing: 8) {
                    Text("Natural Match")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Connecting people naturally")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Action Buttons
                VStack(spacing: 16) {
                    Button(action: {
                        // TODO: Implement sign up
                    }) {
                        Text("Get Started")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        // TODO: Implement sign in
                    }) {
                        Text("Already have an account? Sign In")
                            .font(.subheadline)
                            .foregroundColor(.pink)
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
} 
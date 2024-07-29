import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignedIn: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Self")
                .font(.system(size: 36, weight: .semibold))
                .frame(width: 350, height: 50)
            
            TextField("Email", text: $email)
                .padding()
                .frame(width: 330, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 330, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            Button(action: {
                if email.isEmpty {
                    errorMessage = "Please enter an email"
                    showError = true
                } else if password.isEmpty {
                    errorMessage = "Please enter an password"
                    showError = true
                } else {
                    showError = false
                    isSignedIn = true
                }
            }) {
                Text("Sign in")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 330, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .shadow(color: .gray, radius: 4, x: 3, y: 3)
            if showError {
                          Text(errorMessage)
                              .foregroundColor(.red)
                              .padding()
                      }
        }
        .padding()
        .fullScreenCover(isPresented: $isSignedIn) {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

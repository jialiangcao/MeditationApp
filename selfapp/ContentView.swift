import SwiftUI
import FirebaseCore
import FirebaseAuth

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
            
            Button(action: signIn) {
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
            
            Button(action: signUp) {
                Text("Sign up")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isSignedIn) {
            HomeView()
        }
    }
    
    private func signIn() {
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please enter both email and password"
            showError = true
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
                showError = true
            } else {
                isSignedIn = true
                showError = false
            }
        }
    }
    
    private func signUp() {
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please enter both email and password"
            showError = true
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
                showError = true
            } else {
                isSignedIn = true
                showError = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

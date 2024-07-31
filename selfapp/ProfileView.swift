import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isSignedOut: Bool = false
    @Binding var showProfile: Bool
    var days: [Int] = [0, 1, 1, 0, 1, 0, 1]
    
    let counterMap: [Int: String] = [
        0: "Mon",
        1: "Tue",
        2: "Wed",
        3: "Thu",
        4: "Fri",
        5: "Sat",
        6: "Sun"
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        showProfile = false
                        dismiss()
                    }) {
                        Text("Back")
                    }
                    Spacer()
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Weekly Log")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 12) {
                        ForEach(days.indices, id: \.self) { index in
                            VStack(spacing: 8) {
                                Text(counterMap[index] ?? "")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(days[index] == 0 ? Color.green : Color.secondary.opacity(0.3))
                                        .frame(width: 32, height: 32)
                                    
                                    if days[index] == 0 {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

                Button(action: {
                    signOut()
                }) {
                    Text("Sign Out")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
        }
        .fullScreenCover(isPresented: $isSignedOut) {
            ContentView()
        }
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            isSignedOut = true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(showProfile: .constant(true))
    }
}

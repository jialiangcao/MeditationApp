import SwiftUI
import FirebaseFirestore

struct ResultView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isCompleted: Bool
    @State private var rating: Double = 5.0
    @State private var feedback: String = "Hello"
    
    private func postSession(rating: Double, feedback: String) {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "rating": rating,
            "feedback": feedback
        ]
        db.collection("sessions").addDocument(data: data)
    }


var body: some View {
    VStack {
        Text("Congratulations!")
            .font(.system(size:36, weight:.semibold))
        Text("You've completed your meditation. Please rate how you felt")
            .font(.system(size:24))
        
        VStack {
            Slider(value: $rating, in: 1...5, step: 1)
            
            HStack (spacing: 20.0){
                Text("Very Negative")
                Text("Neutral")
                Text("Very Positive")
            }
            .padding(.bottom)
        }
        
        Button(action: {
            isCompleted=false
            postSession(rating: rating, feedback: feedback)
            dismiss()
        }) {
            Text("Save")
        }
        .font(.system(size: 24, weight: .semibold))
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(Color.blue)
        .cornerRadius(10)
    }
    .padding()
}
}

struct Result_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(isCompleted: .constant(true))
    }
}

import SwiftUI

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    var timerDuration = [5, 10, 20, 30, 40, 50, 60]
    @State private var timerRemaining = 5
    @State private var selection = 5
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .position(x: 50, y: 0)
                .font(.system(size: 36, weight: .semibold))
                .padding()
            Text("Choose a duration")
                .font(.system(size: 36))
            Picker("duration", selection: $selection) {
                ForEach(timerDuration, id: \.self) { timer in
                    Text("\(timer) minutes")
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            Text("\(timerRemaining)")
                .font(.system(size:80, weight: .semibold))
            
            Button(action: {
                timerRemaining = timerRemaining-1
            }) {
                Text("Start")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 330, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Button(action: {
                timerRemaining = selection
            }) {
                Text("Reset Timer")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 330, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Sign Out")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

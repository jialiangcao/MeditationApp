import SwiftUI

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var timerDuration: [Int] = [1, 5, 10, 20, 30, 40, 50, 60]
    @State private var selectedDuration: Int = 5
    @State private var timerRemaining: Double = 5 * 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isRunning = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Home")
                    .font(.system(size: 36, weight: .semibold))
                Spacer()
            }
            .padding(.bottom)
            
            VStack(spacing: 10) {
                Text("Choose a duration")
                    .font(.system(size: 36))
                
                Picker("duration", selection: $selectedDuration) {
                    ForEach(timerDuration, id: \.self) { timer in
                        Text("\(timer) minutes")
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedDuration) { newValue in
                    timerRemaining = Double(newValue * 60)
                    isRunning = false
                }
            }
            
            Spacer()
            
            let minutes = Int(timerRemaining / 60)
            let seconds = Int(timerRemaining.truncatingRemainder(dividingBy: 60))
            let secondsString = seconds < 10 ? "0\(seconds)" : "\(seconds)"
            
            Text("\(minutes):\(secondsString)")
                .font(.system(size: 80, weight: .semibold))
                .onReceive(timer) { _ in
                    if isRunning && timerRemaining > 0 {
                        timerRemaining -= 1
                    }
                }
            ProgressView(value: timerRemaining, total: Double(selectedDuration * 60))
              
            Spacer()
            
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Button(action: { isRunning = true }) {
                        Text("Start")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    
                    Button(action: { isRunning = false }) {
                        Text("Stop")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                
                Button(action: {
                    timerRemaining = Double(selectedDuration * 60)
                    isRunning = false
                }) {
                    Text("Reset Timer")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
            
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

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var timerDuration: [Int] = [1, 5, 10, 20, 30, 40, 50, 60]
    @State private var selectedDuration: Int = 5
    @State private var timerRemaining: Double = 5 * 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isRunning: Bool = false
    @State private var isCompleted: Bool = false
    @State private var showProfile: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Home")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    showProfile.toggle()
                }) {
                    Image(systemName: "person.crop.circle")
                        .font(.largeTitle)
                }
                .fullScreenCover(isPresented: $showProfile) {
                    ProfileView(showProfile: $showProfile)
                }
            }
            .padding(.bottom)
            
            VStack(spacing: 10) {
                Text("Choose a duration")
                    .font(.title2)
                    .fontWeight(.medium)
                
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
                    } else if timerRemaining == 0 {
                        isRunning = false
                        isCompleted = true
                        timerRemaining = Double(selectedDuration * 60)
                    }
                }
            
            ProgressView(value: timerRemaining, total: Double(selectedDuration * 60))
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
            
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
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                    
                    Button(action: { isRunning = false }) {
                        Text("Stop")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.red)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
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
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .fullScreenCover(isPresented: $isCompleted) {
            ResultView(isCompleted: $isCompleted)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

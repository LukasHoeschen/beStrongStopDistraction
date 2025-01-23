//
//  ContentView.swift
//  Be Strong, Stop Distraction
//
//  Created by Lukas Marius Hoeschen on 20.01.25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("timerTime") var timerTime = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var runTimer = true
    @AppStorage("userName") var name = ""
    @State var timerTimeString = "30"
    @State var showSettings: Bool = false
    @State var counterFinished = false
    
    @State var randomForMessage: Int = 0
    
    @AppStorage("strongModeEnabled") var strongMode = false
    @AppStorage("AutoEnableStrongModeAfterTimes") var autoEnableStrongMode = 5
    @AppStorage("LastDayStrongModeCount") var lastDayStrongModeCount: Date = .now
    @AppStorage("AppOpenedThisDate") var appOpenedThisDay: Int = 0
    @AppStorage("closeAppImmediately") var closeAppImmediately: Bool = false
    
    
    @AppStorage("extendedModeStart") var extendedModeStart: Date = Date()
    @AppStorage("extendedModeEnd") var extendedModeEnd: Date = Date()
    @AppStorage("changeAppAfterSeconds") var changeAppAfterSeconds: Double = 120
    
    @AppStorage("showAppSetup") var showAppSetup = true

    var body: some View {
        NavigationStack {
            VStack {
                if !counterFinished {
                    Spacer()
                }
                HStack {
                    Spacer()
                    ZStack {
                        CircularProgressView(progress: Double(counter) / Double(timerTime))
                            .frame(width: 300, height: 300)
                        
                        Text("\(counter)")
                            .font(.system(size: 72, weight: .bold, design: .default))
                            .onAppear() {
                                counter = timerTime
                            }
                            .onReceive(timer) { input in
                                if runTimer {
                                    if counter > 0 {
                                        counter -= 1
                                    } else if counter == 0 {
                                        setShortcutChangeImmediately(changeImmediately: false)
                                        counterFinished = true
                                    }
                                }
                            }
                            .onChange(of: scenePhase) { oldPhase, newPhase in
                                if newPhase == .background {
                                    counter = timerTime
                                    counterFinished = false
                                    runTimer = false
                                } else if newPhase == .active {
                                    randomForMessage = Int.random(in: 0..<11)
                                    if strongMode {
                                        setShortcutChangeImmediately(changeImmediately: true)
                                    }
                                    runTimer = true
                                }
                                if !Calendar.current.isDateInToday(lastDayStrongModeCount) {
                                    appOpenedThisDay = 0
                                    lastDayStrongModeCount = Date()
                                    print("date set back")
                                }
                                if appOpenedThisDay == autoEnableStrongMode {
                                    strongMode = true
                                }
                                
                            }
                    }.scaleEffect(counterFinished ? 0.3 : 1)
                    Spacer()
                }
                
                if !counterFinished {
                    Spacer()
                }
                
                VStack {
                    if !counterFinished {
                        VStack {
                            // random show some other supporting messages
                            switch randomForMessage {
                            case 0:
                                Text("\(name), you've got this!")
                            case 1:
                                Text("Stay focused, \(name)!")
                            case 2:
                                Text("One step at a time, \(name)!")
                            case 3:
                                Text("Keep going, \(name), you're doing great!")
                            case 4:
                                Text("\(name), every small step counts!")
                            case 5:
                                Text("Believe in yourself, \(name)!")
                            case 6:
                                Text("You're stronger than any distraction, \(name)!")
                            case 7:
                                Text("Focus on what matters most, \(name)!")
                            case 8:
                                Text("You've made it this far, \(name)!")
                            case 9:
                                Text("\(name), don't let distractions win!")
                            default:
                                Text("\(name), be strong, I know you can do this!")
                            }
                        }
                    } else {
                        Text("Congrats, you did it, \(name)! Please consider if you really want to continue being distracted.")
                    }
                }.animation(.default, value: counter)
                Spacer()
                if counterFinished {
                    Spacer()
                }
            }
            .animation(.bouncy, value: counterFinished)
            .toolbar{
                Button("Info", systemImage: "info.circle") {
                    showSettings = true
                }
            }
            .fullScreenCover(isPresented: $showAppSetup) {
                SetUpView()
            }
            .sheet(isPresented: $showSettings) {
                NavigationStack {
                    Form {
                        Section {
                            NavigationLink("Settings") {
                                Form {
                                    Section("General") {
                                        HStack {
                                            Text("Your Name:")
                                            TextField("Your Name", text: $name)
                                        }
                                        HStack {
                                            Text("Timer Duration")
                                            TextField("Timer Duration", value: $timerTime, format: .number)
#if !os(macOS)
                                                .keyboardType(.decimalPad)
#endif
                                        }
                                        HStack {
                                            DatePicker("Lockdown Mode Start", selection: $extendedModeStart, displayedComponents: .hourAndMinute)
                                        }
                                        HStack {
                                            DatePicker("Lockdown Mode End", selection: $extendedModeEnd, displayedComponents: .hourAndMinute)
                                        }
                                        VStack {
                                            Text("Close distracting App in Lockdown Mode after \(Int(changeAppAfterSeconds)) Seconds")
                                            Slider(value: $changeAppAfterSeconds, in: 15...300, step: 15)
                                        }
                                    }
                                    Section {
                                        HStack {
                                            Toggle("Strong Mode", isOn: $strongMode)
                                        }
                                        VStack {
                                            Stepper(value: $autoEnableStrongMode, in: 1...30) {
                                                Text("Auto Strong Mode: \(autoEnableStrongMode)")
                                            }
                                            Text("")
                                                .padding(0)
                                        }
                                    } header: {
                                        Text("Strong Mode")
                                    } footer: {
                                        Text("When you opened the App  \(autoEnableStrongMode) times in Lockdown Mode, the Strong Mode will be activated.")
                                    }
                                }
                            }
                        }
                        
                        Section {
                            NavigationLink("Setup") {
                                Form {
                                    Section {
                                        VStack(alignment: .leading) {
                                            Text("Please download this Shortcut.")
                                            Link("https://www.icloud.com/shortcuts/cca6a6d83d794efabe470ff27ef79e4b", destination: URL(string: "https://www.icloud.com/shortcuts/cca6a6d83d794efabe470ff27ef79e4b")!)
                                        }
                                        NavigationLink("Or build the Shortcut on your own") {
                                            Image("Shortcut")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                    }
                                    
                                    Section {
                                        VStack(alignment: .leading, spacing: 16) {
                                            Text("1. In the Shortcuts App, go to the Automations tab.")
                                                .font(.body)
                                                .foregroundColor(.primary)
//
                                            Text("2. Create a new Automation by tapping the \"+\" button.")
                                                .font(.body)
                                                .foregroundColor(.primary)
//
                                            Text("3. Select 'When App is Opened'. Choose all your distracting apps (e.g., Instagram, TikTok, etc.), then select 'Run Immediately'.")
                                                .font(.body)
                                                .foregroundColor(.primary)
//
                                            Text("4. Tap 'Next' and choose the downloaded 'Setup' Shortcut.")
                                                .font(.body)
                                                .foregroundColor(.primary)
                                            
                                            Text("5. Congratulations, you're all set! 🎉")
                                                .fontWeight(.semibold)
                                                .font(.body)
                                                .foregroundStyle(Color.primary)
                                            
                                            NavigationLink ("Step-By-Step Example") {
                                                SetUpDetailView()
                                            }
                                        }
                                    }
                                }.navigationTitle("Setup")
                            }
                        }
                        
                        Section("Information") {
                            Text("Hi, my name is Lukas. I made this App to help me to close distracting Apps. I hope it helps you too! \nThe App works with together with an Apple Shortcut to detect if a certain App was opened. If you spend to much time on that App, my App will open and the Timer will start. You then need to be strong an stay in my App until the timer is done, and hopefully you won't reopen the distracting App.")
                        }
                        
                        Section("Privacy") {
                            Text("My App isn't collecting any data at all of course and all Information you enter such as your Name are stored on your device.")
                        }
                        
                        Section("Support Me") {
                            Text("Currently I'm studying Mechatronics and if you like my App, I would be very happy if you could support me by buying me a coffee.")
                            Link("Buy Me A Coffee", destination: URL(string: "https://buymeacoffee.com/hoeschenDevelopment")!)
                        }
                    }.navigationTitle("Settings")
                        .toolbar {
                            #if os(macOS)
                            Button("Close") {
                                showSettings = false
                            }
                            #endif
                        }
                }
            }
        }
        .onChange(of: strongMode) { old, new in
            setShortcutChangeImmediately(changeImmediately: new)
        }
    }
    
    func setShortcutChangeImmediately(changeImmediately: Bool) {
//        if let sharedDefaults = UserDefaults(suiteName: "group.org.hoeschen.lukas.BeStrongApp") {
//            sharedDefaults.set(changeImmediately, forKey: "sharedStrongModeOn")
//            sharedDefaults.synchronize() // Ensure the data is saved immediately
//            print("strong mode: \(changeImmediately)")
//        }
        
        closeAppImmediately = changeImmediately
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

struct CircularProgressView: View {
    
    var progress: Double = 0.3
    
    var body: some View {
        Circle()
            .stroke( // 1
                Color.cyan.opacity(0.5),
                lineWidth: 30
            )
            
        Circle() // 2
            .trim(from: 0, to: progress)
            .stroke(
                Color.pink,
                style: StrokeStyle(
                    lineWidth: 30,
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(-90))
            .animation(.easeOut, value: progress)
    }
}

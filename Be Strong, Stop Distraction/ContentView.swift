//
//  ContentView.swift
//  Be Strong, Stop Distraction
//
//  Created by Lukas Marius Hoeschen on 20.01.25.
//

import SwiftUI
import SwiftData
import StoreKit

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.requestReview) var requestReview
    
    @State var showSettings: Bool = false

    @State var randomForMessage: Int = 0
    
    @StateObject var dataManager: DataControler = DataControler()

    var body: some View {
        NavigationStack {
            VStack {
                if dataManager.LastTimeDistractedAppWasOpened.distance(to: .now) < 1800 {
                    if !dataManager.counterFinished {
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        ZStack {
                            CircularProgressView(progress: Double(dataManager.counter) / Double(dataManager.timerTime))
                                .frame(width: 300, height: 300)
                            
                            Text("\(dataManager.counter)")
                                .font(.system(size: 72, weight: .bold, design: .default))
                                .onReceive(dataManager.timer) { input in
                                    dataManager.timerStep()
                                }
                                .onChange(of: scenePhase) { oldPhase, newPhase in
                                    dataManager.newScenePhase(newPhase: newPhase)
                                }
                        }.scaleEffect(dataManager.counterFinished ? 0.3 : 1)
                        Spacer()
                    }
                    
                    if !dataManager.counterFinished {
                        Spacer()
                    }
                    
                    VStack {
                        if !dataManager.counterFinished {
                            VStack {
                                // random show some other supporting messages
                                switch randomForMessage {
                                case 0:
                                    Text("\(dataManager.name), you've got this!")
                                case 1:
                                    Text("Stay focused, \(dataManager.name)!")
                                case 2:
                                    Text("One step at a time, \(dataManager.name)!")
                                case 3:
                                    Text("Keep going, \(dataManager.name), you're doing great!")
                                case 4:
                                    Text("\(dataManager.name), every small step counts!")
                                case 5:
                                    Text("Believe in yourself, \(dataManager.name)!")
                                case 6:
                                    Text("You're stronger than any distraction, \(dataManager.name)!")
                                case 7:
                                    Text("Focus on what matters most, \(dataManager.name)!")
                                case 8:
                                    Text("You've made it this far, \(dataManager.name)!")
                                case 9:
                                    Text("\(dataManager.name), don't let distractions win!")
                                default:
                                    Text("\(dataManager.name), be strong, I know you can do this!")
                                }
                            }.onAppear {
                                randomForMessage = Int.random(in: 1...10)
                            }
                        } else {
                            Text("Congrats, you did it, \(dataManager.name). Please consider if you really want to continue being distracted.")
                        }
                    }.animation(.default, value: dataManager.counter)
                    Spacer()
                    if dataManager.counterFinished {
                        Spacer()
                    }
                } else {
                    Spacer()
                    Text("🎉")
                        .font(.system(size: 50))
                    Text("Here isn't a timer, because it seams like you didn't opened a distracting App for the last 30 Minutes. Congratulations")
                    Spacer()
                }
            }
            .animation(.bouncy, value: dataManager.counterFinished)
            .toolbar{
                Button("Info", systemImage: "info.circle") {
                    showSettings = true
                }
            }
            .fullScreenCover(isPresented: $dataManager.showAppSetup) {
                SetUpView()
            }
            .sheet(isPresented: $showSettings) {
                NavigationStack {
                    Form {
                        Section {
                            NavigationLink("Settings") {
                                Form {
                                    Section {
                                        HStack {
                                            Text("Your Name:")
                                            TextField("Your Name", text: $dataManager.name)
                                        }
                                        HStack {
                                            DatePicker("Lockdown Mode Start", selection: $dataManager.extendedModeStart, displayedComponents: .hourAndMinute)
                                        }
                                        HStack {
                                            DatePicker("Lockdown Mode End", selection: $dataManager.extendedModeEnd, displayedComponents: .hourAndMinute)
                                        }
                                        VStack(alignment: .leading) {
                                            Text(String(format: NSLocalizedString("Timer Duration %d Seconds", comment: "Displayed when showing timer duration"), Int(dataManager.timerTime)))
//                                            TextField("Timer Duration", value: $dataManager.timerTime, format: .number)
//#if !os(macOS)
//                                                .keyboardType(.decimalPad)
//#endif
                                            Slider(value: $dataManager.timerTime, in: 10...150, step: 10)
                                        }
                                        VStack(alignment: .leading) {
                                            Text(String(format: NSLocalizedString("Close distracting App in Lockdown Mode after %d Seconds", comment: "Displayed when showing  something i dont care"), Int(dataManager.changeAppAfterSeconds)))
                                            Slider(value: $dataManager.changeAppAfterSeconds, in: 15...300, step: 15)
                                        }
                                    } header: {
                                        Text("General")
                                    } footer: {
                                        Text("When not in Lockdown Mode, distracting Apps get closed after 5 Minutes")
                                    }
                                    Section {
                                        HStack {
                                            Toggle("Strong Mode", isOn: $dataManager.strongMode)
                                                .disabled(dataManager.inLockDownMode)
                                        }
//                                        VStack {
//                                            Stepper(value: $dataManager.autoEnableStrongMode, in: 1...30) {
//                                                Text("Auto Strong Mode: \(dataManager.autoEnableStrongMode)")
//                                            }
//                                            Text("")
//                                                .padding(0)
//                                        }
                                    } header: {
                                        Text("Strong Mode")
                                    } footer: {
                                        Text("Strong Mode makes it hard to continue to the distracting App while the counter is still counting. Strong Mode is automatically active in Lockdown Mode.")
                                    }
                                }
                            }
                            .foregroundStyle(Color.accentColor)
                        }
                        
                        Section {
                            NavigationLink("Setup") {
                                SetUPInstructions()
                            }
                            .foregroundStyle(Color.accentColor)
                        }
                        
                        Section("Information") {
                            Text("Hi, my name is Lukas. I made this App to help me to close distracting Apps. I hope it helps you too! \nThe App works with together with an Apple Shortcut to detect if a certain App was opened. If you spend to much time on that App, my App will open and the Timer will start. You then need to be strong an stay in my App until the timer is done, and hopefully you won't reopen the distracting App.")
                        }
                        
                        Section("Privacy") {
                            Text("My App isn't collecting any data at all of course and all Information you enter such as your Name are stored on your device.")
                        }
                        
                        Section("Support Me") {
                            Text("I'm a Mechatronics student developing this app in my free time. If you like it, I'd really appreciate your support and I would love to hear your Feedback!")
                            Link("Buy Me a Coffee", destination: URL(string: "https://buymeacoffee.com/hoeschenDevelopment")!)
                            Link("Contact Me", destination: URL(string: "mailto:development@hoeschen.org")!)
                        }
                        
                        Section("FAQ") {
                            NavigationLink("Frequently Asked Questions", destination: FAQView())
                                .foregroundStyle(Color.accentColor)
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
        .onChange(of: dataManager.strongMode) { old, new in
            dataManager.closeAppImmediately = new
        }
        .onChange(of: dataManager.appOpenedCounter) {
            if let counter = dataManager.appOpenedCounter {
                if counter % 500 == 70 {
                    requestReview()
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataControler())
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

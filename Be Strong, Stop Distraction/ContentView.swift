//
//  ContentView.swift
//  Be Strong, Stop Distraction
//
//  Created by Lukas Marius Hoeschen on 20.01.25.
//

import SwiftUI
import SwiftData
import SwiftDate
import StoreKit

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.requestReview) var requestReview
    
//    @State var showSettings: Bool = false
//    @AppStorage("showSupportMe") var showSupportMe: Bool = false
//    @State var showSupportMe: Bool = true
//    @State var showSupportMeMore = false

//    @State var randomForMessage: Int = 0
    
    @EnvironmentObject var dataManagerV2: DataControlerV2
    
    @State var showSuccess: Bool = false

    var body: some View {
//        ZStack {
//            NavigationStack {
//                VStack {
//                    if dataManager.LastTimeDistractedAppWasOpened.distance(to: .now) < 1800 {
//                        if !dataManager.counterFinished {
//                            Spacer()
//                        }
//                        HStack {
//                            Spacer()
//                            ZStack {
//                                CircularProgressView(progress: Double(dataManager.counter) / Double(dataManager.timerTime))
//                                    .frame(width: 300, height: 300)
//                                
//                                Text("\(dataManager.counter)")
//                                    .font(.system(size: 72, weight: .bold, design: .default))
//                                    .onReceive(dataManager.timer) { input in
//                                        dataManager.timerStep()
//                                    }
//                                    .onChange(of: scenePhase) { oldPhase, newPhase in
//                                        dataManager.newScenePhase(newPhase: newPhase)
//                                    }
//                            }.scaleEffect(dataManager.counterFinished ? 0.3 : 1)
//                            Spacer()
//                        }
//                        
//                        if !dataManager.counterFinished {
//                            Spacer()
//                        }
//                        
//                        VStack {
//                            if !dataManager.counterFinished {
//                                VStack {
//                                    // random show some other supporting messages
//                                    switch randomForMessage {
//                                    case 0:
//                                        Text("\(dataManager.name), you've got this!")
//                                    case 1:
//                                        Text("Stay focused, \(dataManager.name)!")
//                                    case 2:
//                                        Text("One step at a time, \(dataManager.name)!")
//                                    case 3:
//                                        Text("Keep going, \(dataManager.name), you're doing great!")
//                                    case 4:
//                                        Text("\(dataManager.name), every small step counts!")
//                                    case 5:
//                                        Text("Believe in yourself, \(dataManager.name)!")
//                                    case 6:
//                                        Text("You're stronger than any distraction, \(dataManager.name)!")
//                                    case 7:
//                                        Text("Focus on what matters most, \(dataManager.name)!")
//                                    case 8:
//                                        Text("You've made it this far, \(dataManager.name)!")
//                                    case 9:
//                                        Text("\(dataManager.name), don't let distractions win!")
//                                    default:
//                                        Text("\(dataManager.name), be strong, I know you can do this!")
//                                    }
//                                }.onAppear {
//                                    randomForMessage = Int.random(in: 1...10)
//                                }
//                            } else {
//                                Text("Congrats, you did it, \(dataManager.name). Please consider if you really want to continue being distracted.")
//                            }
//                        }.animation(.default, value: dataManager.counter)
//                        Spacer()
//                        if dataManager.counterFinished {
//                            Spacer()
//                        }
//                    } else {
//                        Spacer()
//                        Text("🎉")
//                            .font(.system(size: 50))
//                        Text("Here isn't a timer, because it seams like you didn't opened a distracting App for the last 30 Minutes. Congratulations")
//                        Spacer()
//                    }
//                }
//                .animation(.bouncy, value: dataManager.counterFinished)
//                .toolbar{
//                    Button("Info", systemImage: "info.circle") {
//                        showSettings = true
//                    }
//                }
//                .fullScreenCover(isPresented: $dataManager.showAppSetup) {
//                    SetUpView()
//                }
//                .sheet(isPresented: $showSettings) {
//                    NavigationStack {
//                        Form {
//                            Section {
//                                NavigationLink("Settings") {
//                                    Form {
//                                        Section {
//                                            HStack {
//                                                Text("Your Name:")
//                                                TextField("Your Name", text: $dataManager.name)
//                                            }
//                                            HStack {
//                                                DatePicker("Lockdown Mode Start", selection: $dataManager.extendedModeStart, displayedComponents: .hourAndMinute)
//                                            }
//                                            HStack {
//                                                DatePicker("Lockdown Mode End", selection: $dataManager.extendedModeEnd, displayedComponents: .hourAndMinute)
//                                            }
//                                            VStack(alignment: .leading) {
//                                                Text(String(format: NSLocalizedString("Timer Duration %d Seconds", comment: "Displayed when showing timer duration"), Int(dataManager.timerTime)))
//                                                //                                            TextField("Timer Duration", value: $dataManager.timerTime, format: .number)
//                                                //#if !os(macOS)
//                                                //                                                .keyboardType(.decimalPad)
//                                                //#endif
//                                                Slider(value: $dataManager.timerTime, in: 10...150, step: 10)
//                                            }
//                                            VStack(alignment: .leading) {
//                                                Text(String(format: NSLocalizedString("Close distracting App in Lockdown Mode after %d Seconds", comment: "Displayed when showing  something i dont care"), Int(dataManager.changeAppAfterSeconds)))
//                                                Slider(value: $dataManager.changeAppAfterSeconds, in: 15...300, step: 15)
//                                            }
//                                        } header: {
//                                            Text("General")
//                                        } footer: {
//                                            Text("When not in Lockdown Mode, distracting Apps get closed after 5 Minutes")
//                                        }
//                                        Section {
//                                            HStack {
//                                                Toggle("Strong Mode", isOn: $dataManager.strongMode)
//                                                    .disabled(dataManager.inLockDownMode)
//                                            }
//                                            //                                        VStack {
//                                            //                                            Stepper(value: $dataManager.autoEnableStrongMode, in: 1...30) {
//                                            //                                                Text("Auto Strong Mode: \(dataManager.autoEnableStrongMode)")
//                                            //                                            }
//                                            //                                            Text("")
//                                            //                                                .padding(0)
//                                            //                                        }
//                                        } header: {
//                                            Text("Strong Mode")
//                                        } footer: {
//                                            Text("Strong Mode makes it hard to continue to the distracting App while the counter is still counting. Strong Mode is automatically active in Lockdown Mode.")
//                                        }
//                                    }
//                                }
//                                .foregroundStyle(Color.accentColor)
//                            }
//                            
//                            Section {
//                                NavigationLink("Setup") {
//                                    SetUPInstructions()
//                                }
//                                .foregroundStyle(Color.accentColor)
//                            }
//                            
//                            Section("Privacy") {
//                                Text("My App isn't collecting any data at all of course and all Information you enter such as your Name are stored on your device.")
//                            }
//                            
//                            Section("Support Me") {
//                                Text("I'm a Mechatronics student developing this app in my free time. If you like it, I'd really appreciate your support and I would love to hear your Feedback!")
//                                Text("Donate via [buyMeACoffee.com](https://buymeacoffee.com/hoeschenDevelopment)")
//                                Text("Donate via [PayPal](https://paypal.me/hoeschenDevelopment)")
//                            }
//                            
//                            Section("FAQ") {
//                                NavigationLink("Frequently Asked Questions", destination: FAQView())
//                                    .foregroundStyle(Color.accentColor)
//                                Link("Contact Me", destination: URL(string: "mailto:development@hoeschen.org")!)
//                            }
//                        }.navigationTitle("Settings")
//                            .toolbar {
//#if os(macOS)
//                                Button("Close") {
//                                    showSettings = false
//                                }
//#endif
//                            }
//                    }
//                }
//            }
//            .onChange(of: dataManager.strongMode) { old, new in
//                dataManager.closeAppImmediately = new
//            }
//            .onChange(of: dataManager.appOpenedCounter) {
//                if let counter = dataManager.appOpenedCounter {
//                    if counter % 200 == 30 {
//                        requestReview()
//                    }
//                    if counter % 400 == 70 {
//                        showSupportMe = true
//                    }
//                }
//                
//            }
//            .sheet(isPresented: $showSupportMe) {
//                NavigationStack {
//                    HStack(alignment: .top) {
//                        VStack(alignment: .leading, spacing: 20) {
//                            
//                            Text("As a student, I don’t earn much, and keeping apps available on the App Store comes with costs. If you enjoy using \"Be Strong, Stop Distraction\", I’d really appreciate your support!")
//                                .font(.body)
//                            
//                            Text("Donate via [buyMeACoffee.com](https://buymeacoffee.com/hoeschenDevelopment)")
//                                .font(.headline)
//                            Text("Donate via [PayPal](https://paypal.me/hoeschenDevelopment)")
//                                .font(.headline)
//                            
//                            Button(action: {
//                                requestReview()
//                            }) {
//                                Label("Rate \"Be Strong, Stop Distraction\"", systemImage: "star.fill")
//                                    .font(.headline)
//                                    .foregroundColor(.yellow)
//                            }
//                            
//                            ShareLink(item: URL(string: "https://apps.apple.com/us/app/be-strong-stop-distraction/id6740876234")!) {
//                                Label("Share with Friends", systemImage: "square.and.arrow.up")
//                                    .font(.headline)
//                                    .foregroundColor(.blue)
//                            }
//                            
//                            Spacer()
//                        }
//                    }
//                    .padding(.horizontal)
//                    .navigationTitle("Support Me")
//                }
//                .presentationDetents([.height(400), .large])
//            }
//        }
        
        switch dataManagerV2.showView {
        case -1: // -1    -> Setup
            NavigationStack {
                VStack(alignment: .leading) {
//                    Text("register new app \(dataManagerV2.lastOpenedApp)")
//                    Button("Tap me") {
//                        UIApplication.shared.open(URL(string: "\(dataManagerV2.lastOpenedApp)://")!)
//                    }
                    HStack {
                        Text(dataManagerV2.lastOpenedApp)
                            .font(.largeTitle)
                            .foregroundStyle(Color.accentColor)
                        Spacer()
                    }
                    Button {
                        showSuccess = dataManagerV2.registerApp(mode: "shortBreak")
                    } label: {
                        GroupBox ("Short break") {
                            HStack {
                                Text("You can use \(dataManagerV2.lastOpenedApp), but after a given time you need to take a break till you can continue (60 Seconds, but active waiting)")
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .symbolEffect(.breathe.plain.wholeSymbol, options: .repeat(.continuous))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                    }
                    
                    Button {
                        showSuccess = dataManagerV2.registerApp(mode: "timeout")
                    } label: {
                        GroupBox ("Timeout") {
                            HStack {
                                Text("After using \(dataManagerV2.lastOpenedApp) for five Minutes, you need to make a timeout for at least 60 Minutes.")
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .symbolEffect(.breathe.plain.wholeSymbol, options: .repeat(.continuous))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                    }
                    
                    Button {
                        showSuccess = dataManagerV2.registerApp(mode: "session")
                    } label: {
                        GroupBox ("Session") {
                            HStack {
                                Text("You can use \(dataManagerV2.lastOpenedApp) only three times a day for each five minutes.")
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .symbolEffect(.breathe.plain.wholeSymbol, options: .repeat(.continuous))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                    }
                    Text("You can adjust all times afterwards.")
                        .font(.footnote)
                    Spacer()
                    
                    HomeButtonView()
                }.navigationTitle("Choose Mode for")
                    .padding(.horizontal)
                    .buttonStyle(.plain)
            }
        case -2: // -2    -> Session
            NavigationStack {
                if let app = dataManagerV2.apps.first(where: {$0.name == dataManagerV2.lastOpenedApp}) {
//                let app = distractingApp(name: "Instagram", mode: "session", closeAfter: 10, lastDayOpened: .now, sessionsToday: 1, allowedOpenedCount: 3, timeoutTime: 60)
//                if true {
                    VStack {
                        //                    Text("register new app \(dataManagerV2.lastOpenedApp)")
                        //                    Button("Tap me") {
                        //                        UIApplication.shared.open(URL(string: "\(dataManagerV2.lastOpenedApp)://")!)
                        //                    }
                        HStack {
                            Text(app.name)
                                .font(.largeTitle)
                                .foregroundStyle(Color.accentColor)
                            Spacer()
                        }
                        ZStack {
                            if app.allowedOpenedCount <= app.sessionsToday {
                                VStack {
                                    GroupBox("Maximum reached") {
                                        HStack {
                                            Text("You already used all daily sessions of \(app.name). You can use \(app.name) tomorrow again.")
                                        }
                                    }

                                    Spacer()
                                    
                                    HomeButtonView()
                                }
                            } else {
                                VStack(alignment: .center) {
                                    GroupBox ("Start Session") {
                                        HStack {
                                            Text("You have \(app.allowedOpenedCount - app.sessionsToday) more times left to open \(app.name) today.")
                                            Spacer()
                                        }
                                    }
                                    
                                    Button("Start Session now") {
                                        dataManagerV2.apps[dataManagerV2.apps.firstIndex(where: {$0.name == app.name})!].sessionsToday += 1
                                        dataManagerV2.apps[dataManagerV2.apps.firstIndex(where: {$0.name == app.name})!].beginSession = true
                                        dataManagerV2.storeData()
                                        dataManagerV2.returnToCurrentApp()
                                        dataManagerV2.showView = nil
                                    }.buttonStyle(.borderedProminent)
                                        .font(.title2)
                                    Spacer()
                                    HomeButtonView()
                                }
                            }
                            VStack(alignment: .center) {
                                let a = app.sessionsToday
                                let b = app.allowedOpenedCount
                                Spacer()
                                Text("\(a)/\(b)")
                                    .foregroundStyle(a == b ? .red : a+1 == b ? .yellow : .green)
                                    .font(.system(size: 50))
                                Spacer()
                            }
                        }
                    }.navigationTitle("Start Session for")
                        .padding(.horizontal)
                        .buttonStyle(.plain)
                } else {
                    Text("Sorry, an error occurred")
                        .onAppear {
                            dataManagerV2.showView = nil
                            print("ERROR: App not known in Content View")
                        }
                }
            }
        case 0: //   0    -> Start Timer
            NavigationStack {
                if let app = dataManagerV2.apps.first(where: {$0.name == dataManagerV2.lastOpenedApp}) {
                    VStack {
                        HStack {
                            Text(dataManagerV2.lastOpenedApp)
                                .font(.largeTitle)
                                .foregroundStyle(Color.accentColor)
                            Spacer()
                        }
                        GroupBox("Timer") {
                            HStack {
                                Text("Please wait until you can continue to \(app.name).")
                                Spacer()
                            }
                        }
                        Spacer()
                        
                        ZStack {
                            CircularProgressView(progress: Double(dataManagerV2.counter) / Double(app.counter))
                                .frame(width: 300, height: 300)
                            
                            Text("\(dataManagerV2.counter)")
                                .font(.system(size: 72, weight: .bold, design: .default))
                                .onReceive(dataManagerV2.timer) { input in
                                    dataManagerV2.timerStep()
                                }
                                .onChange(of: scenePhase) { oldPhase, newPhase in
                                    dataManagerV2.newScenePhase(newPhase: newPhase, app: app)
                                }
                                .animation(.none, value: dataManagerV2.counter)
                        }.scaleEffect(dataManagerV2.counter == 0 ? 0 : 1)
                        
                        Text("You can now continue to \(app.name).")
                            .scaleEffect(dataManagerV2.counter == 0 ? 1 : 0)
                        
                        Spacer()
                        HomeButtonView()
                    }.navigationTitle("Wait to return to")
                        .padding(.horizontal)
                        .animation(.default, value: dataManagerV2.counter)
                } else {
                    Text("Sorry, an error occurred")
                        .onAppear {
                            dataManagerV2.showView = nil
                            print("ERROR: App not known in Content View")
                        }
                }
            }
        case -4: // -4    -> Show Timeout
            NavigationStack {
                if let app = dataManagerV2.apps.first(where: {$0.name == dataManagerV2.lastOpenedApp}) {
                    VStack {
                        HStack {
                            Text(app.name)
                                .font(.largeTitle)
                                .foregroundStyle(Color.accentColor)
                            Spacer()
                        }
                        GroupBox("Timeout") {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(app.name) is in a timeout right know. You can use it again in \(dataManagerV2.timeBetweenDates(date1: app.lastDayOpened, date2: .now)).")
                                    Text("Use again after: " + dataManagerV2.dateToNiceString(date: app.lastDayOpened))
                                }
                                Spacer()
                            }
                        }
                        Spacer()
                        HomeButtonView()
                        
                    }.padding(.horizontal)
                        .navigationTitle("Timeout for")
                } else {
                    Text("Sorry, an error occurred")
                        .onAppear {
                            dataManagerV2.showView = nil
                            print("ERROR: App not known in Content View")
                        }
                }
            }
        default:
            NavigationStack {
//                Text("Default stuff")
//                Text("Welcome to Version 2!")
//                    .font(.largeTitle)
//                    .foregroundStyle(Color.accentColor)
//                Button("Delete Data") {
//                    dataManagerV2.apps.removeAll()
//                    dataManagerV2.storeData()
//                }
                
//                List(dataManagerV2.apps) { app in
//                    AppDetailView(app: app)
//                }.navigationTitle("Stop Distraction")
                
                ScrollView {
                    HStack {
                        Text("Stop Distraction")
                            .font(.largeTitle)
                            .foregroundStyle(Color.accentColor)
                        Spacer()
                    }
                    
                    ForEach(0..<dataManagerV2.apps.count, id: \.self) { i in
                        AppDetailView(app: $dataManagerV2.apps[i])
                    }
                    
                    if dataManagerV2.apps.count == 0 {
                        GroupBox("Nothing here yet") {
                            Text("Open a distracting App to add it!")
                        }
                    }
                }.navigationTitle("Home")
                    .padding(.horizontal)
            }//.onAppear {
//                dataManagerV2.apps.append(distractingApp(name: "Instagram", mode: "session", closeAfter: 30, lastDayOpened: .now, allowedOpenedCount: 3, timeoutTime: 2091))
//                dataManagerV2.apps.append(distractingApp(name: "TikTok", mode: "timeout", closeAfter: 30, lastDayOpened: (.now + 5 .minutes), allowedOpenedCount: 3, timeoutTime: 2093))
//                dataManagerV2.apps.append(distractingApp(name: "Snapchat", mode: "shortBreak", closeAfter: 30, lastDayOpened: .now, allowedOpenedCount: 3, timeoutTime: 2091))
//            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataControlerV2())
}

struct CircularProgressView: View {
    
    var progress: Double = 0.3
    
    var body: some View {
        ZStack {
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
}

struct HomeButtonView: View {
    
    @EnvironmentObject var dataManagerV2: DataControlerV2
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    dataManagerV2.showView = nil
                }
            } label: {
                Image(systemName: "house")
                    .font(.title2)
                    .foregroundStyle(Color.accentColor)
            }
            Spacer()
        }
    }
}

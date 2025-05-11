//
//  DataControl.swift
//  Be Strong, Stop Distraction
//
//  Created by Lukas Marius Hoeschen on 23.01.25.
//

import Foundation
import SwiftUI
import SwiftDate


class DataControler: ObservableObject {
    
    @AppStorage("timerTime") var timerTime: Double = 30
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var counter: Int = 30
    
    @Published var runTimer = true
    @AppStorage("userName") var name = ""
    @Published var showSettings: Bool = false
    @Published var counterFinished = false
    
    @Published var randomForMessage: Int = 0
    
    @AppStorage("strongModeEnabled") var strongMode = false
    @AppStorage("closeAppImmediately") var closeAppImmediately: Bool = false
    
    
    @AppStorage("extendedModeStart") var extendedModeStart: Date = Date()
    @AppStorage("extendedModeEnd") var extendedModeEnd: Date = Date()
    @AppStorage("changeAppAfterSeconds") var changeAppAfterSeconds: Double = 120
    
    @AppStorage("showAppSetup") var showAppSetup = true
    
    @AppStorage("LastTimeDistractedAppWasOpened") var LastTimeDistractedAppWasOpened = .now - 1 .days
    
    @AppStorage("inLockDownMode") var inLockDownMode = false
    
    @AppStorage("appOpenedCounter") var appOpenedCounter: Int?
    
    func timerStep() {
        if runTimer {
            if counter > 0 {
                counter -= 1
            } else if counter == 0 {
                closeAppImmediately = false
                counterFinished = true
            }
        }
    }
    
    func newScenePhase(newPhase: ScenePhase) {
        if newPhase == .background {
            counter = Int(timerTime)
            counterFinished = false
            runTimer = false
        } else if newPhase == .active {
            randomForMessage = Int.random(in: 0..<11)
            if strongMode {
                closeAppImmediately = true
            }
            runTimer = true
            
            if appOpenedCounter == nil {
                appOpenedCounter = 1
            } else {
                appOpenedCounter! += 1
            }
        } else {
            runTimer = false
        }
    }
    
    func distractingAppWasOpened(app: String) -> Int {
        
        if LastTimeDistractedAppWasOpened.distance(to: .now) > 1800 {
            closeAppImmediately = false
            counterFinished = true
        }
        
        LastTimeDistractedAppWasOpened = .now
        
        if closeAppImmediately {
            return 0
        }
        
        strongMode = true
        inLockDownMode = true
        
        
        // check if actual time i in between extended mode
        if extendedModeStart.time > extendedModeEnd.time {
            // Start 7:00, End 19:00
            if extendedModeStart.time < Date().time {
                return Int(changeAppAfterSeconds)
            } else if extendedModeEnd.time > Date().time {
                return Int(changeAppAfterSeconds)
            }
        } else {
            // Start 19:00, End 7:00
            if extendedModeStart.time < Date().time && extendedModeEnd.time > Date().time {
                return Int(changeAppAfterSeconds)
            }
        }
        
        
        inLockDownMode = false
        strongMode = false
        return 300
    }
}




struct distractingApp: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var mode: String
    var closeAfter: Int
    var lastDayOpened: Date
    var sessionsToday: Int = 0
    var allowedOpenedCount: Int
    var beginSession: Bool = false
    var timeoutTime: Int
//    var alreadyActive: Bool = false
    var counter: Int = 60
}

struct distractingAppStorageStruct: Codable {
    var list: [distractingApp]
}

class DataControlerV2: ObservableObject {
    @Published var apps: [distractingApp] = []
    @AppStorage("appsData") var appsData: Data = Data()
    @AppStorage("lastOpenedApp") var lastOpenedApp: String = "nil"
    @Published var showView: Int? = nil
    
    @Published var showCanNotOpenApp: Bool = false
    
    
    @AppStorage("timerTime") var timerTime: Double = 30
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var counter: Int = 30
    @Published var runTimer = true
    
    func timerStep() {
        if runTimer {
            if counter > 0 {
                counter -= 1
            } else if counter == 0 {
//                Timer completed
//                self.apps[apps.firstIndex(where: {$0.name == lastOpenedApp})!].alreadyActive = false
                self.apps[apps.firstIndex(where: {$0.name == lastOpenedApp})!].sessionsToday = 0
                storeData()
//                returnToCurrentApp() // Bad idea, makes continues loop, can still make addicted in my opinion
            }
        }
    }
    
    func newScenePhase(newPhase: ScenePhase, app: distractingApp) {
        if newPhase == .background {
            runTimer = false
        } else if newPhase == .active {
            runTimer = true
        } else {
            runTimer = false
        }
    }
    
    
    init() {
        self.loadData()
    }
    
    func storeData() {
        // store data
        let d = distractingAppStorageStruct(list: self.apps)
        guard let u = try? JSONEncoder().encode(d) else {
            print("failed to store data")
            return
        }
        DispatchQueue.main.async {
            self.appsData = u
        }
    }
    
    func loadData() {
        // load Data
        guard let d = try? JSONDecoder().decode(distractingAppStorageStruct.self, from: self.appsData) else {
            print("failed to load data")
            self.apps = []
            return
        }
        DispatchQueue.main.async {
            self.apps = d.list
            print("loaded data")
        }
    }
    
    func distractingAppWasOpened(appName: String) -> Int {
        print("Opened App: \(appName)")
        self.lastOpenedApp = appName
        
        if let app = apps.first(where: {$0.name == appName}) {
            // App Known
//            if app.alreadyActive {
//                // There is already a timer running, stop Shortcut
//                print("Already active -3\n")
//                return -3
//            }
            
            if app.mode == "session" {
                // Sessions apply for this App
                if app.beginSession {
                    self.apps[apps.firstIndex(where: {$0.name == appName})!].beginSession = false
//                    print(apps)
                    storeData()
                    return app.closeAfter
                }
                
                if app.lastDayOpened.date.isInside(date: .now, granularity: .day) {
                    print("no new day")
                } else {
                    self.apps[apps.firstIndex(where: {$0.name == appName})!].lastDayOpened = .now
                    self.apps[apps.firstIndex(where: {$0.name == appName})!].sessionsToday = 0
                    print("new day")
                }
                storeData()
                print("sessions -2\n")
                return -2
            } else if app.mode == "timeout" {
                // timeout applies
                print("timeout -4\n")
                if .now > app.lastDayOpened {
                    // can use app
                    self.apps[apps.firstIndex(where: {$0.name == appName})!].lastDayOpened = .now + app.closeAfter .seconds + app.timeoutTime .seconds // here: when can open next
                    storeData()
                    return app.closeAfter
                } else {
                    // can't use app, wait for timeout please
                    return -4
                }
            } else {
                // This App has only a timer
                print("timer 0+  -> \(app.closeAfter)\n")
                if app.sessionsToday == -1 && app.lastDayOpened + 1.hours > .now {
                    // When app shall be closed now
                    print("1")
//                    self.apps[apps.firstIndex(where: {$0.name == appName})!].alreadyActive = false
                    storeData()
                    return 0
                } else {
                    // When app is allowed to run specific time
                    print("2")
//                    self.apps[apps.firstIndex(where: {$0.name == appName})!].alreadyActive = true
                    self.apps[apps.firstIndex(where: {$0.name == appName})!].lastDayOpened = .now
                    storeData()
                    return app.closeAfter
                }
            }
        } else {
            // App Unknown
            print("unknown -1\n")
            return -1
        }
    }
    
    func urlOpened(url: String) {
        print(url)
        print(lastOpenedApp)
        
        loadData()
        
        let app = apps.first(where: {$0.name == lastOpenedApp}) ?? distractingApp(name: "", mode: "", closeAfter: 0, lastDayOpened: .now, allowedOpenedCount: 0, timeoutTime: 0)
        
        if url == "beStrongStopDistraction://registerNewApp" {
            // show register new app view
            showView = -1
        } else if url == "beStrongStopDistraction://startSessionNowQuestionMark" {
            // show start session view
            showView = -2
        } else if url == "beStrongStopDistraction://StartTimer" && app.mode == "shortBreak" {
            // show Timer
//            self.apps[apps.firstIndex(where: {$0.name == lastOpenedApp})!].alreadyActive = false
            self.apps[apps.firstIndex(where: {$0.name == lastOpenedApp})!].sessionsToday = -1
            counter = app.counter
            runTimer = true
            storeData()
            showView = 0
        } else if url == "beStrongStopDistraction://StartTimer" && app.mode == "session" {
            showView = -2
        } else if url == "beStrongStopDistraction://waitForTimeout" {
            // show start session view
            showView = -4
        }
    }
    
    func registerApp(mode: String) -> Bool {
        apps.append(distractingApp(name: lastOpenedApp, mode: mode, closeAfter: 60, lastDayOpened: .now, allowedOpenedCount: 3, timeoutTime: 60 * 60))
        storeData()
        returnToCurrentApp()
        withAnimation {
            showView = nil
        }
        return true
    }
    
    func returnToCurrentApp() {
        
//        Error Handling
//
        let urlString = lastOpenedApp + "://"
        let url = URL(string: urlString)
        if url == nil {
            print("Could not create URL from string \(urlString)")
            showCanNotOpenApp = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.showCanNotOpenApp = false
            }
            return
        }
        
//        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!)
//        } else {
//            print("Could not OPEN URL from string \(urlString)")
//            showCanNotOpenApp = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                self.showCanNotOpenApp = false
//            }
//        }
    }
    
    func dateToNiceString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        let dateString = formatter.string(from: date)
        return(dateString)
    }
    
    func timeBetweenDates(date1: Date, date2: Date) -> String {
        let a = date1 > date2 ? date1 : date2
        let b = date1 > date2 ? date2 : date1
        
        let t = Int(a.timeIntervalSince(b))
        
        return secondsToNiceString(t: t)
    }
    
    func secondsToNiceString(t: Int) -> String {
        let hours = t / 3600
        let minutes = (t % 3600) / 60
        let seconds = t % 60
        
        var components: [String] = []
        if hours > 0 {
            components.append("\(hours) Hour\(hours == 1 ? "" : "s")")
        }
        if minutes > 0 {
            components.append("\(minutes) Minute\(minutes == 1 ? "" : "s")")
        }
        if hours == 0 && minutes == 0 {
            components.append("\(seconds) Second\(seconds == 1 ? "" : "s")")
        }
        
        return components.joined(separator: ", ")
    }
}

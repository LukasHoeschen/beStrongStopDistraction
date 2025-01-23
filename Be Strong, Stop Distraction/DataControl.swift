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
        }
    }
    
    func distractingAppWasOpened() -> Int {
        
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

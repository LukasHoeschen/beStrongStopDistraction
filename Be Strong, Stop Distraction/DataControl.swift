//
//  DataControl.swift
//  Be Strong, Stop Distraction
//
//  Created by Lukas Marius Hoeschen on 23.01.25.
//

import Foundation
import SwiftUI



class DataControler: ObservableObject {
    
    @AppStorage("timerTime") var timerTime = 30
    @State var counter = 30
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
    
}

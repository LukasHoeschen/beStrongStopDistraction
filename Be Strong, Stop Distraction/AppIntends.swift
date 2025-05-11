//
//  AppIntends.swift
//  Be Strong, Stop Distraction
//
//  Created by Lukas Marius Hoeschen on 20.01.25.
//

import Foundation
import AppIntents
import SwiftUI

//struct whenToClose: AppIntent {
//    
////    @AppStorage("AppOpenedThisDate") var appOpenedThisDate: Int = 0
////    @AppStorage("closeAppImmediately") var closeAppImmediately: Bool = false
////    
////    @AppStorage("changeAppAfterSeconds") var changeAppAfterSeconds: Double = 30
////    
////    @AppStorage("extendedModeStart") var extendedModeStart: Date = Date()
////    @AppStorage("extendedModeEnd") var extendedModeEnd: Date = Date()
//    
//    
//    @ObservedObject var dataManager: DataControler = DataControler()
//    
//    
//    static var title = LocalizedStringResource("Stop Distraction in")
//    static var description = IntentDescription("Returns a Value when the distracting App should be closed.")
//    
//    func perform() async throws -> some ReturnsValue<Int> {
//        return .result(value: 0)
//    }
//}



struct appLogicConnector: AppIntent {
    
//    @AppStorage("AppOpenedThisDate") var appOpenedThisDate: Int = 0
//    @AppStorage("closeAppImmediately") var closeAppImmediately: Bool = false
//
//    @AppStorage("changeAppAfterSeconds") var changeAppAfterSeconds: Double = 30
//
//    @AppStorage("extendedModeStart") var extendedModeStart: Date = Date()
//    @AppStorage("extendedModeEnd") var extendedModeEnd: Date = Date()
    
    
    @ObservedObject var dataManager: DataControlerV2 = DataControlerV2()
    
    
    static var title = LocalizedStringResource("Distracting App Opened")
    static var description = IntentDescription("Based on which distracting App was opened, Be Strong, Stop Distraction will decide how to act based on what you choosed.")
    
    @Parameter(title: "App opened", description: "The distracting App which was opened.")
    var openedApp: String
    
    func perform() async throws -> some ReturnsValue<Int> {
        return .result(value: dataManager.distractingAppWasOpened(appName: openedApp))
    }
}

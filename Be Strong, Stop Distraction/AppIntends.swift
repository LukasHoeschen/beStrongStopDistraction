//
//  AppIntends.swift
//  Be Strong, Stop Distraction
//
//  Created by Lukas Marius Hoeschen on 20.01.25.
//

import Foundation
import AppIntents
import SwiftUI

struct getStrongMode: AppIntent {
    
    @AppStorage("AppOpenedThisDate") var appOpenedThisDate: Int = 0
    @AppStorage("closeAppImmediately") var closeAppImmediately: Bool = false
    
    
    static var title = LocalizedStringResource("Is strong Mode enabled?")
    static var description = IntentDescription("Returns a value whether the strong Mode is enabled or not.")
    
//    func perform() async throws -> some IntentResult {
//        let isStrongModeEnabled = UserDefaults.standard.bool(forKey: "strongModeEnabled")
//        return .result(value: isStrongModeEnabled)
//    }
    
    func perform() async throws -> some ReturnsValue<Bool> {
        appOpenedThisDate += 1
        print("App Intent says: App opened \(closeAppImmediately) times.")
        return .result(value: closeAppImmediately)
    }
}


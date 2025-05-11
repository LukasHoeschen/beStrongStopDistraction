//
//  Be_Strong__Stop_DistractionApp.swift
//  Be Strong, Stop Distraction
//
//  Created by Lukas Marius Hoeschen on 20.01.25.
//

import SwiftUI
import SwiftData

@main
struct Be_Strong__Stop_DistractionApp: App {
    
    
    @StateObject var dataManagerV2: DataControlerV2 = DataControlerV2()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManagerV2)
                .onOpenURL { url in
                    print("url opened in App main: \(url)")
                    dataManagerV2.urlOpened(url: url.absoluteString)
                }
                .sheet(isPresented: $dataManagerV2.showCanNotOpenApp) {
                    VStack {
                        Text("Can't open \(dataManagerV2.lastOpenedApp)")
                            .font(.title2)
                            .foregroundStyle(Color.accentColor)
                        Text("Please open \(dataManagerV2.lastOpenedApp) manually to continue to it.")
                    }.presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
        }
    }
}




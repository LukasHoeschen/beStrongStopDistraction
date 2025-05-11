//
//  AppDetailView.swift
//  Be Strong, Stop Distraction
//
//  Created by Lukas Marius Hoeschen on 01.05.25.
//

import SwiftUI

struct AppDetailView: View {
    
    @EnvironmentObject var dataManagerV2: DataControlerV2
    
    @Binding var app: distractingApp
    
    @State var editApp: distractingApp = distractingApp(name: "", mode: "timeout", closeAfter: 0, lastDayOpened: .now, allowedOpenedCount: 0, timeoutTime: 0)
    @State var closeAfter: Double = 0
    @State var sessionsPerDay: Double = 0
    
    @State var allowedTimeInApp: Double = 0
    @State var timeoutTime: Double = 0
    
    @State var timeInApp: Double = 0
    @State var timerTime: Double = 0
    
    var body: some View {
        NavigationLink {
//            VStack {
//                HStack {
//                    Text(app.name)
//                        .font(.largeTitle)
//                        .foregroundStyle(Color.accentColor)
//                    Spacer()
//                }
//                
//                GroupBox("Mode") {
//                    HStack {
//                        Text(app.mode == "session" ? "Session" : app.mode == "timeout" ? "Timeout" : "Short Break")
//                        Spacer()
//                    }
//                }
//                
//                switch app.mode {
//                case "session":
//                    GroupBox("Duration") {
//                        HStack {
//                            VStack (alignment: .leading) {
//                                Text("\(dataManagerV2.secondsToNiceString(t: app.closeAfter))")
//                                Text("This time represents how long you can stay in \(app.name) after starting a session.").font(.footnote)
//                            }
//                            Spacer()
//                        }
//                    }
//                    GroupBox("Sessions per Day") {
//                        HStack {
//                            VStack (alignment: .leading) {
//                                Text("\(app.allowedOpenedCount)")
//                                Text("This time represents how long you can stay in \(app.name) after starting a session.").font(.footnote)
//                            }
//                            Spacer()
//                        }
//                    }
//                case "timeout":
//                    GroupBox("Timeout") {
//                        Text("\(app.timeoutTime) minutes")
//                    }
//                    case "shortBreak":
//                    GroupBox("Short Break") {
//                        Text("\(app.closeAfter) minutes")
//                    }
//                default:
//                    Text("Sorry, an error occurred")
//                }
//                
//                Spacer()
//            }.navigationTitle("Settings for")
//                .padding(.horizontal)
            VStack {
                HStack {
                    Text(app.name)
                        .font(.largeTitle)
                        .foregroundStyle(Color.accentColor)
                    Spacer()
                }.padding(.horizontal)
//                Section("Mode") {
//                    Picker("Mode", selection: $app.mode) {
//                        ForEach(["session", "timeout", "shortBreak"], id: \.self) { mode in
//                            Text(mode == "session" ? "Session" : mode == "timeout" ? "Timeout" : "Short Break")
//                        }
//                    }.pickerStyle(SegmentedPickerStyle())
//                }
                Form {
                    switch app.mode {
                    case "session":
                        Section {
                            HStack {
                                Text("Mode:")
                                Spacer()
                                Text("Session")
                            }
                            HStack {
                                Text("Duration:")
                                Spacer()
                                Text(dataManagerV2.secondsToNiceString(t: app.counter))
                            }
                            HStack {
                                Text("Sessions per Day:")
                                Spacer()
                                Text("\(app.allowedOpenedCount)")
                            }
                            HStack {
                                Text("Opened Today:")
                                Spacer()
                                Text("\(app.sessionsToday)")
                            }
                        } footer: {
                            Text("You have \(app.allowedOpenedCount) Sessions per Day. Meaning before using \(app.name) you need to start a Session. Then you can use \(app.name) for \(dataManagerV2.secondsToNiceString(t: app.counter)) until you need to start a new Session.")
                        }
                    case "timeout":
                        Section {
                            HStack {
                                Text("Mode:")
                                Spacer()
                                Text("Timeout")
                            }
                            HStack {
                                Text("\(app.name) Usage:")
                                Spacer()
                                Text(dataManagerV2.secondsToNiceString(t: app.closeAfter))
                            }
                            HStack {
                                Text("Timeout Duration:")
                                Spacer()
                                Text(dataManagerV2.secondsToNiceString(t: app.timeoutTime))
                            }
                            HStack {
                                Text("Current Timeout:")
                                Spacer()
                                Text(app.lastDayOpened > .now ? dataManagerV2.timeBetweenDates(date1: .now, date2: app.lastDayOpened) : "No active Timeout")
                            }
                            HStack {
                                Text("Continue to \(app.name):")
                                Spacer()
                                Text(app.lastDayOpened > .now ? "\(dataManagerV2.dateToNiceString(date: app.lastDayOpened))" : "Now")
                            }
                        } footer: {
                            Text("You can use \(app.name) for \(dataManagerV2.secondsToNiceString(t: app.closeAfter)). Then you need to wait for \(dataManagerV2.secondsToNiceString(t: app.timeoutTime)) until you can use it again. No need to stay at **Stop Distraction** for this waiting time.")
                        }
                    case "shortBreak":
                        Section {
                            HStack {
                                Text("Mode:")
                                Spacer()
                                Text("Short Break")
                            }
                            HStack {
                                Text("Allowed App Time:")
                                Spacer()
                                Text(dataManagerV2.secondsToNiceString(t: app.closeAfter))
                            }
                            HStack {
                                Text("Waiting Time:")
                                Spacer()
                                Text(dataManagerV2.secondsToNiceString(t: app.counter))
                            }
                        } footer: {
                            Text("You can stay in \(app.name) for a maximum of \(dataManagerV2.secondsToNiceString(t: app.closeAfter)), then you need to wait for \(dataManagerV2.secondsToNiceString(t: app.counter)) before you can use it again. You need to stay at **Stop Distraction** until the Timer is done.")
                        }
                    default:
                        Text("Sorry, an error occurred")
                    }
                }
            }.navigationTitle("Settings for")
                .toolbar {
                    NavigationLink {
                        Form {
                            Section("Mode") {
                                Picker("Mode", selection: $editApp.mode) {
                                    ForEach(["session", "timeout", "shortBreak"], id: \.self) { mode in
                                        Text(mode == "session" ? "Session" : mode == "timeout" ? "Timeout" : "Short Break")
                                    }
                                }
                            }
                            switch editApp.mode {
                            case "session":
                                Section("Settings") {
                                    VStack {
                                        HStack {
                                            Text("Session Duration:")
                                            Spacer()
                                            Text(dataManagerV2.secondsToNiceString(t: Int(closeAfter)))
                                        }
                                        Slider(value: $closeAfter, in: 60...(600), step: 60)
                                    }
                                    VStack {
                                        HStack {
                                            Text("Sessions per Day:")
                                            Spacer()
                                            Text("\(Int(sessionsPerDay))")
                                        }
                                        Slider(value: $sessionsPerDay, in: 1...10, step: 1)
                                    }
                                }
                                
                                Section {
                                    HStack {
                                        Spacer()
                                        Button("Save") {
                                            if let i = dataManagerV2.apps.firstIndex(where: {$0.name == app.name}) {
                                                var new = distractingApp(name: app.name, mode: editApp.mode, closeAfter: Int(closeAfter), lastDayOpened: app.lastDayOpened, allowedOpenedCount: Int(sessionsPerDay), timeoutTime: app.timeoutTime)
                                                new.sessionsToday = app.sessionsToday >= 0 ? app.sessionsToday : 0
//                                                new.alreadyActive = app.alreadyActive
                                                new.counter = app.counter
                                                new.beginSession = app.beginSession
                                                dataManagerV2.apps[i] = new
                                                dataManagerV2.storeData()
                                            }
                                        }.foregroundStyle(Color.white)
                                        Spacer()
                                    }
                                }.listRowBackground(Color.accentColor)
                            case "timeout":
                                Section("Settings") {
                                    VStack {
                                        HStack {
                                            Text("Allowed Time in App:")
                                            Spacer()
                                            Text(dataManagerV2.secondsToNiceString(t: Int(allowedTimeInApp)))
                                        }
                                        Slider(value: $allowedTimeInApp, in: 60...(600), step: 60)
                                    }
                                    VStack {
                                        HStack {
                                            Text("Timeout Time:")
                                            Spacer()
                                            Text(dataManagerV2.secondsToNiceString(t: Int(timeoutTime)))
                                        }
                                        Slider(value: $timeoutTime, in: (60*60)...(60*60*24), step: 60*60)
                                    }
                                }
                                Section {
                                    HStack {
                                        Spacer()
                                        Button("Save") {
                                            if let i = dataManagerV2.apps.firstIndex(where: {$0.name == app.name}) {
                                                var a = distractingApp(name: app.name, mode: editApp.mode, closeAfter: Int(allowedTimeInApp), lastDayOpened: app.lastDayOpened, allowedOpenedCount: 0, timeoutTime: Int(timeoutTime))
                                                a.sessionsToday = app.sessionsToday
//                                                a.alreadyActive = app.alreadyActive
                                                a.counter = app.counter
                                                a.beginSession = app.beginSession
                                                dataManagerV2.apps[i] = a
                                                dataManagerV2.storeData()
                                            }
                                        }.foregroundStyle(Color.white)
                                        Spacer()
                                    }
                                }.listRowBackground(Color.accentColor)
                            case "shortBreak":
                                Section("Settings") {
                                    VStack {
                                        HStack {
                                            Text("Allowed Time in App:")
                                            Spacer()
                                            Text((Int(timeInApp/60) == 0 ? "" : "\(Int(timeInApp/60)) Min") + (Int(timeInApp)%60 == 0 ? "" : " \(Int(timeInApp)%60) Sec"))
                                        }
                                        Slider(value: $timeInApp, in: 30...(240), step: 15)
                                    }
                                    VStack {
                                        HStack {
                                            Text("Timer Time:")
                                            Spacer()
                                            Text((Int(timerTime/60) == 0 ? "" : "\(Int(timerTime/60)) Min") + (Int(timerTime)%60 == 0 ? "" : " \(Int(timerTime)%60) Sec"))
                                        }
                                        Slider(value: $timerTime, in: 15...120, step: 5)
                                    }
                                }
                                Section {
                                    HStack {
                                        Spacer()
                                        Button("Save") {
                                            if let i = dataManagerV2.apps.firstIndex(where: {$0.name == app.name}) {
                                                var a = distractingApp(name: app.name, mode: editApp.mode, closeAfter: Int(timeInApp), lastDayOpened: app.lastDayOpened, allowedOpenedCount: 0, timeoutTime: app.timeoutTime)
                                                a.sessionsToday = app.sessionsToday
//                                                a.alreadyActive = app.alreadyActive
                                                a.counter = Int(timerTime)
                                                a.beginSession = app.beginSession
                                                dataManagerV2.apps[i] = a
                                                dataManagerV2.storeData()
                                            }
                                        }.foregroundStyle(Color.white)
                                        Spacer()
                                    }
                                }.listRowBackground(Color.accentColor)
                            default:
                                Text("Sorry, an Error occurred")
                            }
                        }.navigationTitle("Edit \(app.name)")
            .animation(.default, value: editApp.mode)
                    } label: {
                        Text("Edit")
                    }
                }
                .onAppear {
                    editApp = app
                    
                    closeAfter = Double(app.closeAfter)
                    sessionsPerDay = Double(app.allowedOpenedCount)

                    allowedTimeInApp = Double(app.closeAfter)
                    timeoutTime = Double(app.timeoutTime)
                    
                    timeInApp = Double(app.closeAfter)
                    timerTime = Double(app.counter)
                }
        } label: {
            ZStack {
                GroupBox(app.name) {
                    HStack {
                        Text("Mode: \(app.mode == "session" ? "Session" : app.mode == "timeout" ? "Timeout" : "Short Break")")
                        Spacer()
                    }
                }.foregroundStyle(Color.primary)
                HStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "arrow.right")
                    //                        .symbolEffect(.breathe.plain.wholeSymbol, options: .repeat(.continuous))
                        .fontWeight(.black)
                        .foregroundStyle(Color.accentColor)
                        .padding(.trailing, 25)
                }
            }
        }
    }
}

#Preview {
    AppDetailView(app: .constant(distractingApp(name: "", mode: "session", closeAfter: 1, lastDayOpened: .now, allowedOpenedCount: 1, timeoutTime: 1)))
        .environmentObject(DataControlerV2())
}

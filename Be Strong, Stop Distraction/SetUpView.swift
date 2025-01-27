//
//  SetUpView.swift
//  Be Strong, Stop Distraction
//
//  Created by Lukas Marius Hoeschen on 22.01.25.
//

import SwiftUI

struct SetUpView: View {
    
    @AppStorage("userName") var name = ""
    
    @AppStorage("extendedModeStart") var extendedModeStart: Date = Date()
    @AppStorage("extendedModeEnd") var extendedModeEnd: Date = Date()
    
    @AppStorage("showAppSetup") var showAppSetup = true
    
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Section {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("""
                            Thank you for choosing my app! It’s designed to help you stay focused by detecting when you spend too much time in distracting apps. If that happens, it gently intervenes by closing the app and asking you to take a short break before returning.
                            """)
                                .font(.callout)
                                .foregroundColor(.secondary)
                            
                            Text("""
                            To make this work seamlessly, the app relies on Apple’s Shortcuts Automation. You’ll need to download and install a Shortcut for this feature to function. Don’t worry, it’s easy to set up, completely secure, and I don’t collect any of your personal data. Your privacy is my priority!
                            """)
                                .font(.callout)
                                .foregroundColor(.secondary)
                            
                            Text("Thank you for your trust and support — Lukas")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding(.top, 8)
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        VStack {
                            VStack(spacing: 40) {
                                
                                Spacer()
                                
                                // App Icon or Shield for Security
                                VStack(spacing: 16) {
                                    Image(systemName: "shield.checkerboard")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.accentColor)
                                    
                                    Text("Secure & Private")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)
                                }
                                
                                // Features with Icons
                                VStack(alignment: .leading, spacing: 20) {
                                    HStack(spacing: 16) {
                                        Image(systemName: "timer")
                                            .font(.largeTitle)
                                            .foregroundColor(.accentColor)
                                        Text("Timed Breaks")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                    }
                                    
                                    HStack(spacing: 16) {
                                        Image(systemName: "square.and.arrow.down")
                                            .font(.largeTitle)
                                            .foregroundColor(.accentColor)
                                        Text("Shortcut Integration")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                    }
                                    
                                    HStack(spacing: 16) {
                                        Image(systemName: "lock.open")
                                            .font(.largeTitle)
                                            .foregroundColor(.accentColor)
                                        
                                        Text("Open Source")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                    }
                                    
                                    HStack(spacing: 16) {
                                        Image(systemName: "lock.shield")
                                            .font(.largeTitle)
                                            .foregroundColor(.accentColor)
                                        
                                        Text("No Data Collected")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                    }
                                }
                                
                                
                                Spacer()
                                
                                // Action Button
                                NavigationLink(destination: {
                                    VStack {
                                        VStack(spacing: 40) {
                                            // Header with Security Icon
                                            VStack(spacing: 16) {
                                                Image(systemName: "person.text.rectangle")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 100, height: 100)
                                                    .foregroundColor(.accentColor)
                                                
                                                Text("Personalized Experience")
                                                    .font(.title2)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.primary)
                                            }
                                            
                                            // Name Input Field
                                            VStack(alignment: .leading, spacing: 8) {
                                                Text("Enter your name")
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                                
                                                TextField("Your name", text: $name)
                                                //                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .padding(.vertical, 5)
                                                    .padding(.horizontal)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color.accentColor, lineWidth: 1)
                                                            .shadow(radius: 2)
                                                    )
                                                    .padding(.horizontal)
                                            }
                                            
                                            // Explanation Text
                                            HStack(alignment: .top) {
                                                Image(systemName: "info.circle")
                                                
                                                VStack(alignment: .leading, spacing: 12) {
                                                    Text("""
                                                Your name helps us create supportive and personalized messages while you wait and stay strong. You can always update this information later in the settings.
                                                """)
                                                    .font(.callout)
                                                }
                                                .foregroundColor(.secondary)
                                                .multilineTextAlignment(.leading)
                                                .padding(.horizontal)
                                            }
                                        }
                                            
                                        Spacer()

                                        NavigationLink(destination: {
                                            VStack {
                                                VStack(spacing: 30) {
                                                    // Header with SF Symbol
                                                    VStack(spacing: 16) {
                                                        Image(systemName: "lock.shield")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 100, height: 100)
                                                            .foregroundColor(.accentColor)

                                                        Text("Lockdown Mode Settings")
                                                            .font(.title2)
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(.primary)
                                                    }

                                                    // Explanation Section
                                                    VStack(alignment: .leading, spacing: 12) {
                                                        Text("What is Lockdown Mode?")
                                                            .font(.headline)
                                                            .foregroundColor(.primary)

                                                        Text("""
                                                        When Lockdown Mode is enabled, the app will strictly restrict access to distracting apps during the specified hours. You can change the allowed time later in Settings.
                                                        Outside of Lockdown Mode, distracting apps will be closed after 5 minutes of use.
                                                        """)
                                                            .font(.callout)
                                                            .foregroundColor(.secondary)
                                                    }
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.horizontal)

                                                    VStack(alignment: .leading, spacing: 20) {
                                                        HStack {
                                                            Image(systemName: "clock.arrow.circlepath")
                                                                .foregroundColor(.accentColor)
                                                            DatePicker("Lockdown Mode Start", selection: $extendedModeStart, displayedComponents: .hourAndMinute)
                                                        }
                                                        .padding(.horizontal)
                                                        .frame(maxWidth: .infinity, alignment: .leading)

                                                        HStack {
                                                            Image(systemName: "clock.arrow.2.circlepath")
                                                                .foregroundColor(.accentColor)
                                                            DatePicker("Lockdown Mode End", selection: $extendedModeEnd, displayedComponents: .hourAndMinute)
                                                        }
                                                        .padding(.horizontal)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                    }
                                                    
                                                    Spacer()

                                                    // Button to Save Settings
                                                    NavigationLink(destination: {
                                                        
                                                        VStack {
                                                            VStack(spacing: 40) {
                                                                // Download Shortcut Option
                                                                VStack(spacing: 16) {
                                                                    Image(systemName: "square.and.arrow.down")
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: 80, height: 80)
                                                                        .foregroundColor(.accentColor)

                                                                    VStack(spacing: 8) {
                                                                        Text("Download Shortcut")
                                                                            .font(.title2)
                                                                            .fontWeight(.semibold)
                                                                            .foregroundColor(.primary)

                                                                        Link("Tap here to download", destination: URL(string: "https://www.icloud.com/shortcuts/cca6a6d83d794efabe470ff27ef79e4b")!)
                                                                            .font(.headline)
                                                                            .foregroundColor(.accentColor)
                                                                    }
                                                                }

                                                                Divider()

                                                                // Manual Build Option
                                                                VStack(spacing: 16) {
                                                                    Image(systemName: "wrench.and.screwdriver")
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: 80, height: 80)
                                                                        .foregroundColor(.orange)

                                                                    NavigationLink(destination: {
                                                                        Image("Shortcut")
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                    }) {
                                                                        VStack(spacing: 8) {
                                                                            Text("Build Shortcut Manually")
                                                                                .font(.title2)
                                                                                .fontWeight(.semibold)
                                                                                .foregroundColor(.primary)

                                                                            Text("Follow step-by-step instructions.")
                                                                                .font(.body)
                                                                                .foregroundColor(.accentColor)
                                                                        }
                                                                    }
                                                                }
                                                                
                                                                Spacer()
                                                                
                                                                NavigationLink(destination: {
                                                                    
                                                                    VStack {
                                                                        VStack(spacing: 40) {
                                                                            // Instructions Header with SF Symbol
                                                                            VStack(spacing: 16) {
                                                                                Image(systemName: "checkmark.circle.fill")
                                                                                    .resizable()
                                                                                    .scaledToFit()
                                                                                    .frame(width: 80, height: 80)
                                                                                    .foregroundColor(.green)

                                                                                Text("Complete the Setup in Shortcuts")
                                                                                    .font(.title2)
                                                                                    .fontWeight(.semibold)
                                                                                    .foregroundColor(.primary)
                                                                            }

                                                                            // Step-by-step Instructions
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
                                                                                
                                                                                NavigationLink("Step-By-Step-Example") {
                                                                                    SetUpDetailView()
                                                                                }
                                                                            }
                                                                            .padding(.horizontal)
                                                                            
                                                                            Spacer()

                                                                            // Button to Finish Setup
                                                                            Button(action: {
                                                                                showAppSetup = false
                                                                            }) {
                                                                                Text("Finish Setup")
                                                                                    .font(.headline)
                                                                                    .frame(maxWidth: .infinity)
                                                                                    .padding()
                                                                                    .foregroundColor(.white)
                                                                                    .background(Color.accentColor)
                                                                                    .cornerRadius(10)
                                                                                    .shadow(radius: 4)
                                                                            }
                                                                            .padding(.horizontal)
                                                                        }
                                                                        .padding()
                                                                        .frame(maxWidth: .infinity, alignment: .center)
                                                                    }
                                                                    .navigationTitle("Finish Setup")
                                                                    .navigationBarTitleDisplayMode(.inline)
                                                                    
                                                                }) {
                                                                    Text("Next")
                                                                        .font(.headline)
                                                                        .frame(maxWidth: .infinity)
                                                                        .padding()
                                                                        .foregroundColor(.white)
                                                                        .background(Color.accentColor)
                                                                        .cornerRadius(10)
                                                                        .shadow(radius: 4)
                                                                }
                                                                .padding(.horizontal)
                                                            }
                                                            .padding()
                                                            .frame(maxWidth: .infinity, alignment: .center)
                                                            
                                                            Spacer()
                                                            
                                                            Text("Step 4/5")
                                                                .font(.footnote)
                                                                .foregroundStyle(Color.secondary)
                                                        }
                                                        .navigationTitle("Shortcut Setup")
                                                        .navigationBarTitleDisplayMode(.inline)
                                                        
                                                    }) {
                                                        Text("Next")
                                                            .font(.headline)
                                                            .frame(maxWidth: .infinity)
                                                            .padding()
                                                            .foregroundColor(.white)
                                                            .background(Color.accentColor)
                                                            .cornerRadius(10)
                                                            .shadow(radius: 4)
                                                    }
                                                    .padding(.horizontal)
                                                }
                                                .padding()
                                                .navigationTitle("Lockdown Mode")
                                                
                                                Text("Step 3/5")
                                                    .font(.footnote)
                                                    .foregroundStyle(Color.secondary)
                                            }
                                        }) {
                                            Text("Next")
                                                .font(.headline)
                                                .frame(maxWidth: .infinity)
                                                .padding()
                                                .foregroundColor(.white)
                                                .background(Color.accentColor)
                                                .cornerRadius(10)
                                                .shadow(radius: 4)
                                        }
                                        .padding(.top, 16)
                                        
                                        Text("Step 2/5")
                                            .font(.footnote)
                                            .foregroundStyle(Color.secondary)
                                    }
                                    .padding()
                                    .navigationTitle("Enter Your Name")
                                }) {
                                    Text("Next")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.accentColor)
                                        .cornerRadius(10)
                                        .shadow(radius: 4)
                                }
                                .padding(.top, 16)
                            }
                            .padding()
                            .navigationTitle("Summary")
                            
                            Spacer()
                            
                            Text("Step 1/5")
                                .font(.footnote)
                                .foregroundStyle(Color.secondary)
                        }
                    }) {
                        Text("Start Setup")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                    }
                    .padding(.top, 16)
                }
                .padding()
                .navigationTitle("Hi there!")
            }
        }
    }
}



struct SetUpDetailView: View {
    var body: some View {
        VStack {
            TabView {
                Image("Setup 1")
                    .resizable()
                    .scaledToFit()
                    .border(Color.gray, width: 3)
                
                Image("Setup 3")
                    .resizable()
                    .scaledToFit()
                    .border(Color.gray, width: 3)
                
                Image("Setup 4")
                    .resizable()
                    .scaledToFit()
                    .border(Color.gray, width: 3)
            
                Image("Setup 5")
                    .resizable()
                    .scaledToFit()
                    .border(Color.gray, width: 3)
                
                Image("Setup 6")
                    .resizable()
                    .scaledToFit()
                    .border(Color.gray, width: 3)
            
                Image("Setup 7")
                    .resizable()
                    .scaledToFit()
                    .border(Color.gray, width: 3)
                
                Image("Setup 8")
                    .resizable()
                    .scaledToFit()
                    .border(Color.gray, width: 3)
                
                VStack {
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color.green)
                        .font(.system(size: 50))
                    
                    Text("All done!")
                    Spacer()
                }
                    
                
            }.tabViewStyle(.page)
                .padding()
            
            Text("Swipe left for next Step")
        }.navigationTitle("Step by Step Instruction")
            .navigationBarTitleDisplayMode(.inline)
    }
}




#Preview {
//    SetUpDetailView()
    SetUpView()
}

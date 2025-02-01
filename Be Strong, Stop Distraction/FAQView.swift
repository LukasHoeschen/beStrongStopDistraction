//
//  FAQView.swift
//  Be Strong, Stop Distraction
//
//  Created by Lukas Marius Hoeschen on 27.01.25.
//

import SwiftUI


struct FAQView: View {
    @State private var expandedQuestion: String? = nil

    var body: some View {
        List {
            FAQItem(question: "How can I turn off the automation without deleting the app?",
                    answer: "Open the Shortcuts app, go to the 'Automations' tab, select the automation for your distracting app, and either delete it or toggle off 'Run Immediately'.",
                    link: nil,
                    expandedQuestion: $expandedQuestion)
            
            FAQItem(question: "What happens if I close the app while the timer is running?",
                    answer: "If you close or leave the app while the timer is running, the timer will restart from the beginning the next time you open the app. This behavior is intentional to discourage bypassing the timer and to ensure a consistent focus on avoiding distractions.",
                    link: nil,
                    expandedQuestion: $expandedQuestion)
            
            FAQItem(question: "Why does the app open sometimes after I close the distracting app?",
                    answer: "If you open and then close a distracting app, 'Be Strong, Stop Distraction' will still open. This is because iOS doesn’t allow apps to check whether another app is still running, so this behavior ensures that distractions are minimized effectively.",
                    link: nil,
                    expandedQuestion: $expandedQuestion)
            
            FAQItem(question: "What is Strong Mode?",
                    answer: "Automatically closes distracting apps after a customizable time limit. Starts a timer in the 'Be Strong, Stop Distraction' app, preventing you from reopening the distracting app until the timer finishes.",
                    link: nil,
                    expandedQuestion: $expandedQuestion)

            FAQItem(question: "What is Lockdown Mode?",
                    answer: "Enables Strong Mode automatically and keeps it active for a set period.",
                    link: nil,
                    expandedQuestion: $expandedQuestion)

            FAQItem(question: "How does Flexible Usage work?",
                    answer: "When Strong Mode is off, distracting apps close after 5 minutes but can be reopened immediately without restrictions.",
                    link: nil,
                    expandedQuestion: $expandedQuestion)

            FAQItem(question: "How does the app work?",
                    answer: "Since iOS doesn’t allow apps to detect when specific apps are opened, I implemented a workaround using Apple Shortcuts. Users set up an automation to run a shortcut whenever a specific app is opened. The app communicates with the shortcut to determine how long the distracting app should remain open before switching back to 'Be Strong, Stop Distraction.' This ensures high security and full control for the user.",
                    link: nil,
                    expandedQuestion: $expandedQuestion)

            FAQItem(question: "Is this project affiliated with TikTok or Instagram?",
                    answer: "No, this app is completely independent and not affiliated with any specific platform.",
                    link: nil,
                    expandedQuestion: $expandedQuestion)

            FAQItem(question: "I like your app! How can I support you?",
                    answer: "You can buy me a coffee here:",
                    link: "https://buymeacoffee.com/HoeschenDevelopment",
                    expandedQuestion: $expandedQuestion)
            
            FAQItem(question: "Where can I find the source code?",
                    answer: "The app is open-source, and you can find the complete source code here:",
                    link: "https://github.com/LukasHoeschen/beStrongStopDistraction",
                    expandedQuestion: $expandedQuestion)
            
        }
        .navigationTitle("FAQ")
    }
}

struct FAQItem: View {
    let question: String
    let answer: String
    let link: String?
    @Binding var expandedQuestion: String?

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                    expandedQuestion = (expandedQuestion == question) ? nil : question
            }) {
                HStack {
                    Text(LocalizedStringKey(question))
                        .font(.headline)
                    Spacer()
                    Image(systemName: expandedQuestion == question ? "chevron.down" : "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
            
            if expandedQuestion == question {
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey(answer))
                        .foregroundColor(.secondary)
                    if link != nil {
                        Link(link!, destination: URL(string: link!)!)
                            .foregroundColor(.accent)
                    }
                }
                .font(.subheadline)
                .padding(.top, 2)
            }
        }
        .padding(.vertical, 4)
    }
}



#Preview {
    FAQView()
}

# Be Strong, Stop Distraction

An iOS app designed to help limit distractions from apps like Instagram or TikTok.

## Why Choose This App?

- **Open Source:** Fully transparent code, available for everyone to inspect and contribute.
- **Privacy First:** No data collection—your usage stays entirely private.

The app is working smoothly now, but if you notice anything that isn't functioning correctly, feel free to reach out. I’d love to hear your feedback!





## About the App

I created this app primarily for fun, but also as a way to manage my own screen time—especially since I’ve been spending more time on Instagram than I’d like.


## Features

- **Strong Mode:**

  - Automatically closes distracting apps after a customizable time limit.
  - Starts a timer in the "Be Strong, Stop Distraction" app, preventing you from reopening the distracting app until the timer finishes.

- **Lockdown Mode:**

  - Enables Strong Mode automatically and keeps it active for a set period.

- **Flexible Usage:**

  - When Strong Mode is off, distracting apps close after 5 minutes but can be reopened immediately without restrictions.


## How It Works

Since iOS doesn’t allow apps to detect when specific apps are opened, I implemented a workaround using Apple Shortcuts:

1. Users download my pre-made shortcut or create their own.
2. An automation is set up to run this shortcut whenever a specific app (e.g., Instagram) is opened.
3. My app uses an intent to communicate with the shortcut, specifying how many seconds the distracting app should remain open before automatically switching to "Be Strong, Stop Distraction."

This approach ensures:

- High security: I’m not able to track which apps are being used.
- Full control: The automation behavior is entirely customizable by the user.

### Scenarios:

- **Lockdown Mode On:** The app sends a zero-second delay to the shortcut, meaning distracting apps close immediately if re-opened while the timer is still active.
- **Lockdown Mode Off:** Users can return to distracting apps without waiting for the timer to finish.


## FAQ

**Q: How can I turn off the automation without deleting the app?**\
A: Open the Shortcuts app, go to the "Automations" tab, select the automation for your distracting app, and either delete it or toggle off "Run Immediately."

**Q: Is this project affiliated with TikTok or Instagram?**\
A: No, this app is completely independent and not affiliated with any specific platform.

**Q: I like your app! How can I support you?**\
A: You can buy me a coffee here: [https://buymeacoffee.com/HoeschenDevelopment](https://buymeacoffee.com/HoeschenDevelopment)

---

If you have questions or suggestions, feel free to contact me at: [development@hoeschen.org](mailto\:development@hoeschen.org).


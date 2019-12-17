# PushBots Example

Demonstrates how to use the pushbots plugin.

## Getting Started

Once added `pushbots` into your `pubspec.yaml`.
You can start by initializing the `PushBots` by calling `Pushbots.init();`

And register for notification by `Pushbots.registerForNotification();`

Add to defaultConfig section, then replace PUSHBOTS_APP_ID and GOOGLE_SENDER_ID

```groovy
defaultConfig {
        // Add PushBots integration data
        manifestPlaceholders = [
                pushbots_app_id               : "YOUR_APP_ID",
                pushbots_loglevel             : "DEBUG",
                google_sender_id              : "YOUR_SENDER_ID"
        ]

    }
```

Listen for notifiers (receive, open) notifications:-

```dart
 Pushbots.listenForNotificationReceive().stream.listen((onData) {
      print("MAIN, received: " + onData.toString());
    });
```

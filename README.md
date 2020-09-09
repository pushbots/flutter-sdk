# PushBots Flutter SDK

A library for Dart developers. Help you manage notifications easily and effectively.

## Example project

You can try our sample project inlcuded with the library:
```shell
git clone git@github.com:pushbots/flutter-sdk.git
cd flutter-sdk/example
flutter run
```


## Usage

Use this package as a library

**1- Add to dependencies:**

Add this to your package's `pubspec.yaml` file below dependencies:


````yaml
dependencies:
  pushbots_flutter: ^1.0.2
````

**2- Install the SDK:**

Run this command on your project:

````
$ flutter pub get
````

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.


**3- Add to your project:**

Now in your Dart code `lib/main.dart`, you can start using PushBots SDK:

````dart
import 'package:pushbots_flutter/pushbots_flutter.dart';
````

### iOS Setup

#### Add PushBots service extension

Follow this article to add PushBots service extension in order to be able to use rich media in your iOS app, you'll find `Flutter SDK additional config` at the end of the article, please make sure to follow it:

https://www.pushbots.help/en/articles/1571650-creating-notification-service-extension

#### Enable push notifications in your app

1. Under targets, click on project name, then click on "+ Capability"
2. Search for "Push notifications" and click on it, then search for "Background modes", click on it then enable "remote notifications" from the list

![Enable push notifications](https://downloads.intercomcdn.com/i/o/243149291/bdb77b474f7d1c38ab65eca9/xcode8-2.gif)

### Android Setup

Add to `defaultConfig` section, then replace `PUSHBOTS_APPLICATION_ID` and `SENDER_ID`

````gradle
defaultConfig {
        // Add PushBots integration data
        manifestPlaceholders = [
                pushbots_app_id               : "PUSHBOTS_APPLICATION_ID",
                pushbots_loglevel             : "DEBUG",
                google_sender_id              : "SENDER_ID"
        ]

    }

````

### Flutter Usage

#### Initializing PushBots:-


You can start by initializing the `PushBotsFlutter` by calling 

````dart
PushbotsFlutter.initialize("PUSHBOTS_APPLICATIN_ID", "YOUR_WEBAPI_KEY", "YOUR_FCM_APP_ID", "YOUR_PROJECT_ID");
````

to be able to get all firebase cerdentials, check out this article for all details:
https://www.pushbots.help/en/articles/498201-the-google-part-firebase-credentials

![Initialize Image](assets/fcm-info.png)


Listen for notifiers (receive, open) notifications:-


````dart
 PushbotsFlutter.listenForNotificationReceive().stream.listen((onData) {
      print("MAIN, received: " + onData.toString());
    });

 PushbotsFlutter.listenForNotificationOpen().stream.listen((onData){
      print("MAIN, opened: " + onData.toString());
    });
````


Update User info:-



````dart
PushbotsFlutter.setName("Pushbotter");
PushbotsFlutter.setFirstName("FirstName");
PushbotsFlutter.setLastName("LastName");
PushbotsFlutter.setEmail("email@email.com");
PushbotsFlutter.setAlias("Alias");
PushbotsFlutter.setPhone("phoneNumber");
````

Other Methods: 

````dart
PushbotsFlutter.debug(true);
//Track event
PushbotsFlutter.trackEvent("added_to_cart");

//ShareLocation with prompting
PushbotsFlutter.shareLocation(true);

//unsubscribe user from receiving notifications
PushbotsFlutter.toggleNotifications(false);

PushbotsFlutter.setTags(["tag1", "tag2"]);

PushbotsFlutter.removeTags(["tag1"]);

//  ====== iOS only method ======
//Set log level with alert
//Log Levels :  noLog, error, warn, info, verbose
PushbotsFlutter.setLogLevelWithUI(LogLevels.verbose.index,true);
//Reset Badge
PushbotsFlutter.resetBadge();
//Set badge
PushbotsFlutter.setBadge(10);
//Increment badge count
PushbotsFlutter.incrementBadgeCountBy(1);
//Decrement badge count
PushbotsFlutter.decrementBadgeCountBy(10);
````

## Feature and bugs

Please fill issue on https://github.com/pushbots or https://stackoverflow.com/questions/tagged/pushbots

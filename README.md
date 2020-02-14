# PushBots Flutter SDK

A library for Dart developers. Help you manage notifications easily and effectively.

## Usage


Use this package as a library

**1- Depend on it**

Add this to your package's `pubspec.yaml` file:


````
dependencies:
  pushbots: ^0.0.4
````



**2- Install it**

You can install packages from the command line:

with Flutter:


````
$ flutter pub get
````

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.




**3- Import it**

Now in your Dart code, you can use:

````
import 'package:pushbots/pushbots.dart';
````


### Android Setup

Add to `defaultConfig` section, then replace `PUSHBOTS_APP_ID` and `GOOGLE_SENDER_ID`


````
defaultConfig {
        // Add PushBots integration data
        manifestPlaceholders = [
                pushbots_app_id               : "YOUR_APP_ID",
                pushbots_loglevel             : "DEBUG",
                google_sender_id              : "YOUR_SENDER_ID"
        ]

    }

````




### Flutter Usage






Once added `pushbots` into your `pubspec.yaml`.

#### Initializing PushBots:-

You can start by initializing the `PushBots` by calling `Pushbots.init();`

#### Register For RemoteNotification:-

Register for notification by `Pushbots.registerForNotification();`




Listen for notifiers (receive, open) notifications:-


````
 Pushbots.listenForNotificationReceive().stream.listen((onData) {
      print("MAIN, received: " + onData.toString());
    });

 Pushbots.listenForNotificationOpen().stream.listen((onData){
      print("MAIN, opened: " + onData.toString());
    });
````


Update User info:-



````
Pushbots.setName("Pushbotter");
Pushbots.setFirstName("FirstName");
Pushbots.setLastName("LastName");
Pushbots.setEmail("email@email.com");
Pushbots.setAlias("Alias");

````



## Feature and bugs

Please fill issue on https://github.com/pushbots or https://stackoverflow.com/questions/tagged/pushbots
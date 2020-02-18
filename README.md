# PushBots Flutter SDK

A library for Dart developers. Help you manage notifications easily and effectively.

## Usage


Use this package as a library

**1- Depend on it**

Add this to your package's `pubspec.yaml` file:


````
dependencies:
  pushbots_flutter: ^0.0.4
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
import 'package:pushbots_flutter/pushbots_flutter.dart';
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






Once added `pushbots_flutter` into your `pubspec.yaml`.

#### Initializing PushBots:-


You can start by initializing the `PushBotsFlutter` 
by calling `PushBotsFlutter.initialize("PUSHBOTS_APPLICATIONID");`


#### Listen For RemoteNotification:-

Listen for notifiers (receive, open) notifications:-


````
 PushBotsFlutter.listenForNotificationReceive().stream.listen((onData) {
      print("MAIN, received: " + onData.toString());
    });

 PushBotsFlutter.listenForNotificationOpen().stream.listen((onData){
      print("MAIN, opened: " + onData.toString());
    });
````


Update User info:-



````
PushBotsFlutter.setName("Pushbotter");
PushBotsFlutter.setFirstName("FirstName");
PushBotsFlutter.setLastName("LastName");
PushBotsFlutter.setEmail("email@email.com");
PushBotsFlutter.setAlias("Alias");
<<<<<<< HEAD
=======
PushBotsFlutter.setPhone("phoneNumber");
>>>>>>> ios-fix

````
##### Other Methods: 
````
PushBotsFlutter.debug(true);
//Track event
PushBotsFlutter.trackEvent("added_to_cart");

//ShareLocation with prompting
PushBotsFlutter.shareLocation(true);

//unsubscribe user from receiving notifications
PushBotsFlutter.toggleNotifications(false);

PushBotsFlutter.setTags(["tag1", "tag2"]);

PushBotsFlutter.removeTags(["tag1"]);
````
##### iOS Methods
````
//Set log level with alert
//Log Levels :  noLog, error, warn, info, verbose
PushBotsFlutter.setLogLevelWithUI(LogLevels.verbose.index,true);
//Reset Badge
PushBotsFlutter.resetBadge();
//Set badge
PushBotsFlutter.setBadge(10);
//Increment badge count
PushBotsFlutter.incrementBadgeCountBy(1);
//Decrement badge count
PushBotsFlutter.decrementBadgeCountBy(10);
````

##### Android Methods
````
PushBotsFlutter.setLogLevel("DEBUG", "NONE")
````







## Feature and bugs

Please fill issue on https://github.com/pushbots or https://stackoverflow.com/questions/tagged/pushbots

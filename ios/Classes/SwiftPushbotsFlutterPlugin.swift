import Flutter
import UIKit
import Pushbots
import CoreTelephony
import CoreLocation
import WebKit
public class SwiftPushbotsFlutterPlugin: NSObject, FlutterPlugin {
    static var channel:FlutterMethodChannel!
  public static func register(with registrar: FlutterPluginRegistrar) {
     channel = FlutterMethodChannel(name: "pushbots_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftPushbotsFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
           case "initialize":
               let arguments: Dictionary<String, Any> = call.arguments as! Dictionary
               let applicationId: String = arguments["id"] as! String
               Pushbots.initWithAppId(applicationId, withLaunchOptions: nil, prompt: true, receivedNotification:
                   { (notificationRecievied) in
                   SwiftPushbotsFlutterPlugin.channel.invokeMethod("received", arguments: notificationRecievied)
               }) { (openedNotification) in
                   SwiftPushbotsFlutterPlugin.channel.invokeMethod("opened", arguments: openedNotification)
               }
           case "setAlias":
               Pushbots.setAlias(call.arguments as? String)
        
           case "removeAlias":
               Pushbots.removeAlias()
           case "setTags":
               Pushbots.tag(call.arguments as? [Any])
           case "removeTags":
               Pushbots.untag(call.arguments as? [Any])
           case "trackEvent":
               Pushbots.trackEvent(call.arguments as? String)
           case "shareLocation":
               Pushbots.shareLocationPrompt(call.arguments as? Bool ?? false)
           case "setLogLevelWithUI":
               let arguments = call.arguments as? [Any]
               let level = arguments?[0] as? UInt ?? 0
               let isUILog = arguments?[1] as? Bool ?? false
               Pushbots.setLogLevel(PBLogLevel(rawValue: level) ?? .info, isUILog: isUILog)
           case "resetBadge":
               Pushbots.clearBadgeCount()
           case "setBadge":
               Pushbots.setBadge(call.arguments as? Int32 ?? 0)
           case "incrementBadgeCountBy":
               Pushbots.incrementBadgeCount(by: call.arguments as? Int32 ?? 0)
           case "decrementBadgeCountBy":
               Pushbots.decrementBadgeCount(by: call.arguments as? Int32 ?? 0)
           case "setName":
               Pushbots.setName(call.arguments as? String)
           case "setEmail":
               Pushbots.setEmail(call.arguments as? String)
           case "setPhone":
               Pushbots.setPhone(call.arguments as? String)
           case "setGender":
               let gender = call.arguments as? String
               Pushbots.setGender(gender)
           case "setFirstname":
               let firstName = call.arguments as? String
               Pushbots.setFirstName(firstName)
           case "setLastName":
               let lastName = call.arguments as? String
               Pushbots.setLastName(lastName)
           case "debug":
               let debug = call.arguments as? Bool
               Pushbots.debug(debug ?? false)
           case "toggleNotifications":
               let toggle = call.arguments as? Bool
               Pushbots.toggleNotifications(toggle ?? false)
           default:
               break
           }  }
}

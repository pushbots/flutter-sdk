package com.pushbots

import android.app.Activity
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import com.pushbots.push.Pushbots
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.json.JSONException
import org.json.JSONObject


class PushbotsPlugin(val activity: Activity, val channel: MethodChannel) : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "pushbots")
            channel.setMethodCallHandler(PushbotsPlugin(registrar.activity(), channel))
        }
    }


    var receiveResult: Result? = null;
    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "init" -> {
                // Initialize PushBots
                Pushbots.sharedInstance().init(activity)
                result.success("PushBots Initialized Successfully")
            }
            "registerForNotification" -> {
                Pushbots.sharedInstance().registerForRemoteNotifications()
                result.success("PushBots Registered For Remote Notification Successfully")
            }
            "setAlias" -> {
                val alias = call.arguments as String
                Pushbots.setAlias(alias)
            }
            "removeAlias" -> {
                Pushbots.removeAlias()
            }
            "tag" -> {
                val tag = call.arguments as String
                Pushbots.tag(tag)
            }
            "untag" -> {
                val tag = call.arguments as String
                Pushbots.untag(tag)
            }
            "setName" -> {
                val name = call.arguments as String
                Pushbots.setName(name)
            }
            "setEmail" -> {
                val email = call.arguments as String
                Pushbots.setEmail(email)
            }
            "setPhone" -> {
                val phone = call.arguments as String
                Pushbots.setPhone(phone)
            }
            "setGender" -> {
                val gender = call.arguments as String
                Pushbots.setGender(gender)
            }
            "setFirstname" -> {
                val firstName = call.arguments as String
                Pushbots.setFirstName(firstName)
            }
            "setLastName" -> {
                val lastName = call.arguments as String
                Pushbots.setLastName(lastName)
            }
            "debug" -> {
                val debug = call.arguments as Boolean
                Pushbots.debug(debug)
            }
            "toggleNotifications" -> {
                val toggle = call.arguments as Boolean
                Pushbots.sharedInstance().toggleNotifications(toggle)
            }
            "receiveCallback" -> {
                Pushbots.sharedInstance().receivedCallback { bundle ->
                    Log.d("PushbotsPlugin", "received: $bundle")
                    channel.invokeMethod("received", bundleToJson(bundle))
                }
            }
            "openCallback" -> {
                Pushbots.sharedInstance().openedCallback { bundle ->
                    result.success(bundleToJson(bundle))
                }
            }
            "idsCallback" -> {
                Pushbots.sharedInstance().idsCallback { s, s2 ->
                    result.success(listOf(s, s2))
                }
            }
            "setLogLevel" -> {
                Pushbots.setLogLevel(call.argument("logcatLevel"), call.argument("uiLevel"))
            }
            "shareLocation" -> {
                val isTracking = call.arguments as Boolean
                Pushbots.shareLocation(isTracking)
            }
            "isInitialized" -> {
                channel.invokeMethod("initialize", Pushbots.isInitialized())
            }

            "isRegistered" -> {
                channel.invokeMethod("register",Pushbots.isRegistered())
            }

            "isSharingLocation" -> {
                channel.invokeMethod("sharingLocation",Pushbots.isSharingLocation())
            }
            else -> {
                result.notImplemented()
            }
        }

    }



    private fun bundleToJson(bundle: Bundle): String {
        val json = JSONObject()
        val keys = bundle.keySet()
        for (key in keys) {
            try {
                json.put(key, bundle[key])
                //json.put(key, JSONObject.wrap(bundle.get(key)));
            } catch (e: JSONException) {
            }
        }
        return json.toString()
    }


}

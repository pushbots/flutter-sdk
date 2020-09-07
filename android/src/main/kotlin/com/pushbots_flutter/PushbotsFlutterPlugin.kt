package com.pushbots_flutter

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
import java.util.logging.Level.WARNING

import android.util.Log.VERBOSE
import org.json.JSONArray


class PushbotsFlutterPlugin(val activity: Activity, val channel: MethodChannel) : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "pushbots_flutter")
            channel.setMethodCallHandler(PushbotsFlutterPlugin(registrar.activity(), channel))
        }
    }


    var receiveResult: Result? = null;
    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "initialize" -> {
                // Initialize PushBots
                val applicationId : String = call.argument<String>("id") as String
                val webApiKey : String = call.argument<String>("webApiKey") as String
                val fcmAppId : String = call.argument<String>("fcmAppId") as String
                val projectId : String = call.argument<String>("projectId") as String

                Pushbots.Builder(activity)
                    .setFcmAppId(fcmAppId)
                    .setLogLevel(Pushbots.LOG_LEVEL.DEBUG)
                    .setWebApiKey(webApiKey)
                    .setPushbotsAppId(applicationId)
                    .setProjectId(projectId)
                    .build()
                    
                result.success("PushBots Initialized Successfully")
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
            "setTags" -> {
                val list = call.arguments as List<*>
                Pushbots.tag(JSONArray(list))
            }
            "removeTags" -> {
                val list = call.arguments as List<*>
                Pushbots.untag(JSONArray(list))
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
                    channel.invokeMethod("received", bundleToJson(bundle))
                }
            }
            "openCallback" -> {
                Pushbots.sharedInstance().openedCallback { bundle ->
                    channel.invokeMethod("opened", bundleToJson(bundle))
                }
            }
            "idsCallback" -> {
                Pushbots.sharedInstance().idsCallback { s, s2 ->
                    channel.invokeMethod("userIDs", listOf(s, s2))
                }
            }
            "setLogLevel" -> {
                val logcatLevel : String = call.argument<String>("logcatLevel") as String
                val uiLevel : String = call.argument<String>("uiLevel") as String

                Pushbots.setLogLevel(getLogLevel(logcatLevel),
                        getLogLevel(uiLevel))
            }
            "shareLocation" -> {
                val isTracking = call.arguments as Boolean
                Pushbots.shareLocation(isTracking)
            }
            "isInitialized" -> {
                channel.invokeMethod("initialized", Pushbots.isInitialized())
            }

            "isRegistered" -> {
                channel.invokeMethod("registered",Pushbots.isRegistered())
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

    fun getLogLevel(logLevel: String): Pushbots.LOG_LEVEL {
        return if (logLevel == "DEBUG") {
            Pushbots.LOG_LEVEL.DEBUG
        } else if (logLevel == "VERBOSE") {
            Pushbots.LOG_LEVEL.VERBOSE
        } else if (logLevel == "INFO") {
            Pushbots.LOG_LEVEL.INFO
        } else if (logLevel == "WARNING") {
            Pushbots.LOG_LEVEL.WARNING
        } else if (logLevel == "ERROR") {
            Pushbots.LOG_LEVEL.ERROR
        } else if (logLevel == "WTF") {
            Pushbots.LOG_LEVEL.WTF
        } else {
            Pushbots.LOG_LEVEL.NONE
        }
    }

}

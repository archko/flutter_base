package cn.archko.flutter.base.flutter_base

import android.os.Handler
import android.os.Looper
import android.text.TextUtils
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** FlutterPlugin */
class FlutterBasePlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private var mHandler: Handler = Handler(Looper.getMainLooper());

    init {
        mINativeHandlers["http_request"] = NetworkHandler()
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "com.archko.flutter/flutter_plugin")
        channel.setMethodCallHandler(this);
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "com.archko.flutter/flutter_plugin")
            channel.setMethodCallHandler(FlutterBasePlugin())
        }

        @JvmStatic
        fun addNativeHandler(key: String, handler: INativeHandler) {
            synchronized(mINativeHandlers) {
                mINativeHandlers.put(key, handler);
            }
        }

        @JvmStatic
        fun removeNativeHandler(key: String) {
            synchronized(mINativeHandlers) {
                mINativeHandlers.remove(key);
            }
        }

        private val mINativeHandlers: MutableMap<String, INativeHandler> = java.util.HashMap()
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        var method = call.method;
        if (!TextUtils.isEmpty(method)) {
            var nativeHandler: INativeHandler? = mINativeHandlers[call.method]
            if (null != nativeHandler) {
                nativeHandler.onCallMethod(call, result, mHandler)
            } else {
                result.notImplemented()
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

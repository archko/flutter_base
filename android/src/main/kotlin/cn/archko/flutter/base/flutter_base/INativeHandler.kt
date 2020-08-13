package cn.archko.flutter.base.flutter_base

import android.os.Handler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * @author: archko 2020/7/28 :10:59 AM
 */
interface INativeHandler {
    fun onCallMethod(call: MethodCall?, result: MethodChannel.Result?, handler: Handler?)
}
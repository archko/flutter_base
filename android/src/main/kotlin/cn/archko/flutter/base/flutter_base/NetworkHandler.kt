package cn.archko.flutter.base.flutter_base

import android.os.Handler
import android.text.TextUtils
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONException
import org.json.JSONObject
import java.util.*

/**
 * @author: archko 2020/7/28 :11:00 AM
 */
class NetworkHandler : INativeHandler {
    override fun onCallMethod(call: MethodCall?, result: MethodChannel.Result?, handler: Handler?) {
        getDataByArgs(call, result, handler)
    }

    /**
     * 获取数据的默认方法,把flutter传来的map参数直接传到task中.返回Wrapper对象.
     * 参数是放在call.argument("params")中的.
     *
     * @param call
     * @param result
     * @param handler
     */
    fun getDataByArgs(call: MethodCall?, result: MethodChannel.Result?, handler: Handler?) {
        //val params = call?.argument("params") as Map<String, Any>
        //Log.d(TAG, "params:$params")
        //val jo = JSONObject()
        //try {
        //    jo.put("key1", "value1")
        //    jo.put("test_key", "test_val")
        //} catch (e: JSONException) {
        //    e.printStackTrace()
        //}
        //resultSuccess(result, handler, 0, jo.toString(), "ok")
    }

    companion object {
        const val TAG = "NetworkHandler"
        fun resultError(result: MethodChannel.Result, handler: Handler,
                        code: Int, data: Any, resultmsg: String) {
            val resultMap: MutableMap<String, Any> = HashMap()
            resultMap["code"] = code
            resultMap["data"] = data
            if (TextUtils.isEmpty(resultmsg)) {
                resultMap["msg"] = resultmsg
            }
            handler.post { result.error("error", "", resultMap) }
        }

        fun resultSuccess(result: MethodChannel.Result?, handler: Handler?,
                          code: Int, data: Any, resultmsg: String) {
            val resultMap: MutableMap<String, Any> = HashMap()
            resultMap["code"] = code
            resultMap["data"] = data
            if (TextUtils.isEmpty(resultmsg)) {
                resultMap["msg"] = resultmsg
            }
            handler!!.post { result?.success(resultMap) }
        }
    }
}
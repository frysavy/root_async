package com.example.root_async

import androidx.annotation.NonNull
import java.lang.StringBuilder

import com.stericson.RootTools.RootTools;
import com.topjohnwu.superuser.Shell;
import com.topjohnwu.superuser.ShellUtils;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** RootAsyncPlugin */
class RootAsyncPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var command : String? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "root_async")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method.equals("ExecuteCommand")) {
      command = call.argument("cmd")
      Shell.sh(command).submit { out ->
            val builder = StringBuilder()
            for (data in out.getOut()) {  
                builder.append(data)
                builder.append("\n")
            }
            result.success(builder.toString())
        }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

package com.example.metronome

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class MetronomePlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private val engine = MetronomeEngine()


  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "metronome")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
       when (call.method) {
                  "play" -> {
                      val arguments = call.arguments as? Map<String, Any>
                      val bpm = arguments?.get("bpm") as? Int ?: 120
                      engine.play(bpm)
                      result.success(true)
                  }
                  "stop" -> {
                      engine.stop()
                      result.success(true)
                  }
                  "isPlaying"->{
                     result.success(engine.isPlaying)
                  }
                  "setBPM"->{
                      val arguments = call.arguments as Map<String, Any>
                      val bpm = arguments?.get("bpm") as Int
                      engine.setBPM(bpm)
                      result.success(true)
                  }

                  "getBPM"->{
                      val bpm = engine.getBPM()
                      result.success(bpm)
                  }
                  else -> {
                      result.notImplemented()
                  }
              }
   }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

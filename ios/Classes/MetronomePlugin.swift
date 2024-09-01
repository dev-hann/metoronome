import Flutter
import UIKit

public class MetronomePlugin: NSObject, FlutterPlugin {
    let engine  = MetronomeEngine()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "metronome", binaryMessenger: registrar.messenger())
    let instance = MetronomePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     switch call.method {
     case "play":
       if let arguments = call.arguments as? [String: Any] {
         let bpm = arguments["bpm"] as? Int ?? 120
         engine.play(bpm: bpm)
         result(true)
       } else {
         result(FlutterError(code: "INVALID_ARGUMENTS", message: "Arguments should be a dictionary.", details: nil))
       }
       break
     case "stop":
       engine.stop()
       result(true)
     case "isPlaying":
         result(engine.isPlaying)
     default:
       result(FlutterMethodNotImplemented)
     }
   }
}

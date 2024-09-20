import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyBV9R0LC9NqKif23pzhqghqd6c2evhbEfY")
//     YMKMapKit.setLocale("uz") // Your preferred language. Not required, defaults to system language
    YMKMapKit.setApiKey("c1d88bea-a60d-45af-b426-0c1c9a6be90d")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

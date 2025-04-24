import UIKit
import Flutter
import GoogleMaps //import google map package
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
         FirebaseApp.configure() //add this before the code below
          UNUserNotificationCenter.current().delegate = self
                 application.registerForRemoteNotifications()
        GMSServices.provideAPIKey("AIzaSyC86lWEI5fMklifz509ZmHUyGpj1AuplUA")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
import UIKit
import Flutter
import FBSDKCoreKit  // ✅ لازم تضيفها لتقدر تستخدم ApplicationDelegate

@UIApplicationMain  // ✅ استخدم @UIApplicationMain فقط مرة واحدة
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // ✅ هذا السطر لتفعيل Facebook SDK
    ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // ✅ للتعامل مع redirect من تطبيق Facebook
  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    return ApplicationDelegate.shared.application(app, open: url, options: options)
  }
}

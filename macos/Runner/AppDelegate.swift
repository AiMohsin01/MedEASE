import Cocoa
import FlutterMacOS
import Firebase

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    FirebaseApp.configure() // Add this line to initialize Firebase
    super.applicationDidFinishLaunching(aNotification)
  }
}

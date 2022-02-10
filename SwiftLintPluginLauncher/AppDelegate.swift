//
//  AppDelegate.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2022/02/10.
//  
//

import Cocoa
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let bundle = Bundle.main
        let mainAppBundleId = DEFINE.mainAppBundleIdentifier

        guard NSRunningApplication.runningApplications(withBundleIdentifier: mainAppBundleId).isEmpty else {
                  NSApp.terminate(nil)
                  return
              }

        let mainAppPath = bundle.bundlePath.components(separatedBy: "/Contents/Library/LoginItems/")[0]
        let mainAppUrl = URL(fileURLWithPath: mainAppPath)

        let config = NSWorkspace.OpenConfiguration()
        NSWorkspace.shared.openApplication(at: mainAppUrl, configuration: config) { _, _ in
            DispatchQueue.main.async {
                NSApp.terminate(nil)
            }
        }

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        true
    }

}

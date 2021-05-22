//
//  AppDelegate.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/21.
//  
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let targetAEDescriptor: NSAppleEventDescriptor = NSAppleEventDescriptor(bundleIdentifier: "com.apple.dt.Xcode")
        let status: OSStatus = AEDeterminePermissionToAutomateTarget(targetAEDescriptor.aeDesc, typeWildCard, typeWildCard, true)
        
        switch status {
        case noErr:
           return
        case OSStatus(errAEEventNotPermitted):
            print("errAEEventNotPermitted")
        case OSStatus(procNotFound):
            print("procNotFound")
        default:
            NSApplication.shared.terminate(self)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


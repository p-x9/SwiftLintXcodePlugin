//
//  AppDelegate.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/21.
//  
//

import Cocoa
import Defaults

class AppDelegate: NSObject, NSApplicationDelegate {

    private let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let mainBarMenu = NSMenu(title: "SwiftLintXcodePlugin")
    var preferenceWindowController: NSWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        setupMenuBar()

         if Defaults[.shouldOpenWindowWhenLaunch] {
            openPreferences()
         }

        checkPermission()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

extension AppDelegate {
    func checkPermission() {
        let targetAEDescriptor = NSAppleEventDescriptor(bundleIdentifier: "com.apple.dt.Xcode")
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

    func setupPreferenceWindow() {
        guard let windowController = NSStoryboard(name: "Main", bundle: nil).instantiateInitialController() as? NSWindowController else {
            return
        }
        self.preferenceWindowController = windowController
    }

    func setupMenuBar() {
        let image = NSImage(systemSymbolName: "s.circle", accessibilityDescription: nil)
        image?.isTemplate = true
        statusBarItem.button?.image = image

        mainBarMenu.addItem(NSMenuItem(title: "Settings..", action: #selector(openPreferences), keyEquivalent: ","))
        mainBarMenu.addItem(NSMenuItem.separator())
        mainBarMenu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.shared.terminate(_:)), keyEquivalent: "q"))
        statusBarItem.menu = mainBarMenu
    }

    @objc
    func openPreferences() {
        if let windowController = self.preferenceWindowController {
            windowController.showWindow(self)
        } else {
            setupPreferenceWindow()
            self.preferenceWindowController?.showWindow(self)
        }
        NSApp.activate(ignoringOtherApps: true)
    }
}

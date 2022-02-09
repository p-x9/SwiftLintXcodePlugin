//
//  ViewController.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/21.
//  
//

import Cocoa
import ServiceManagement
import Defaults

class ViewController: NSViewController {

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    @IBOutlet private var swiftlintPathPopUpButton: NSPopUpButton! {
        didSet {
            swiftlintPathPopUpButton.selectItem(at: Defaults[.swiftlintPathMode].rawValue)
        }
    }
    @IBOutlet private var swiftlintPathTextField: NSTextField! {
        didSet {
            swiftlintPathTextField.delegate = self
            if Defaults[.swiftlintPathMode] == .default {
                swiftlintPathTextField.isEditable = false
                swiftlintPathTextField.stringValue = DEFINE.defaultSwiftLintPath
            } else {
                swiftlintPathTextField.stringValue = Defaults[.swiftlintPath]
            }
        }
    }
    @IBOutlet private weak var launchAtLoginCheckBox: NSButton! {
        didSet {
            launchAtLoginCheckBox.state = Defaults[.shouldLaunchAtLogin] ? .on : .off
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction private func handleSwiftLintPathButton(_ sender: Any) {
        let selectedIndex = swiftlintPathPopUpButton.indexOfSelectedItem
        Defaults[.swiftlintPathMode] = FilePathMode(rawValue: selectedIndex) ?? .default

        switch selectedIndex {
        case 0:// default
            swiftlintPathTextField.isEditable = false
            swiftlintPathTextField.stringValue = DEFINE.defaultSwiftLintPath
        case 1:// custom
            swiftlintPathTextField.isEditable = true
            swiftlintPathTextField.stringValue = Defaults[.swiftlintPath]
        case 2:// relative
            swiftlintPathTextField.isEditable = true
            swiftlintPathTextField.stringValue = Defaults[.swiftlintPath]
        default:
            break
        }
    }

    @IBAction private func handleLaunchAtLoginCheckBox(_ sender: Any) {
        let shouldLaunchAtLogin = launchAtLoginCheckBox.state == .on
        Defaults[.shouldLaunchAtLogin] = shouldLaunchAtLogin

        SMLoginItemSetEnabled(DEFINE.launcherAppBundleIdentifier as CFString, shouldLaunchAtLogin)
    }
}

extension ViewController: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        guard let textField = obj.object as? NSTextField else {
            return
        }

        switch textField {
        case swiftlintPathTextField:
            Defaults[.swiftlintPath] = textField.stringValue
        default:
            break
        }
    }
}

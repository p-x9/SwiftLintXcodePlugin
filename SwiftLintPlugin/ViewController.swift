//
//  ViewController.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/21.
//  
//

import Cocoa

class ViewController: NSViewController {

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    @IBOutlet private var swiftlintPathPopUpButton: NSPopUpButton!
    @IBOutlet private var swiftlintPathTextField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction private func handleSwiftLintPathButton(_ sender: Any) {
        switch swiftlintPathPopUpButton.indexOfSelectedItem {
        case 0:// default
            break
        case 1:// custom
            break
        case 2:// relative
            break
        default:
            break
        }
    }

}

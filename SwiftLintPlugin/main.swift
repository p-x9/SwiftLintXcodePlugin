//
//  mian.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2022/02/11.
//  
//

import AppKit

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

//
//  Defaults.Keys.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/26.
//  
//

import Foundation
import Defaults

extension Defaults.Keys {
    private static let groupUserDefaults = UserDefaults(suiteName: "group.com.p-x9.SwiftLintPlugin")
    private static let userDefaults = UserDefaults.standard

    static let swiftlintPathMode = Defaults.Key<FilePathMode>("swiftlintPathMode", default: .default, suite: groupUserDefaults ?? userDefaults)
    static let swiftlintPath = Defaults.Key<String>("swiftlintPath", default: DEFINE.defaultSwiftLintPath, suite: groupUserDefaults ?? userDefaults)

    static let shouldLaunchAtLogin = Defaults.Key<Bool>("shouldLaunchAtLogin", default: false)
}

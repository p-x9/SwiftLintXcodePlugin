//
//  PATH.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/27.
//  
//

import Foundation
import Defaults

enum PATH {
    static var swiftLintPath: String {
        switch Defaults[.swiftlintPathMode] {
        case .default:
            return DEFINE.defaultSwiftLintPath
        case .relative:
            return Defaults[.swiftlintPath]
        case .custom:
            return Defaults[.swiftlintPath]
        }
    }
}

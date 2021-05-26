//
//  FilePathMode.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/26.
//  
//

import Foundation

public enum FilePathMode: Int, Codable {
    case `default`
    case custom
    case relative
}

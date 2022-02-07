//
//  AutoCorrectProjectCommand.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2022/02/08.
//  
//

import Foundation
import XcodeKit
import Defaults

class AutoCorrectProjectCommand: SourceEditorCommand {
    override class var commandDefinitions: [XCSourceEditorCommandDefinitionKey: Any] {
        [
            .nameKey: "AutoCorrect All Files",
            .classNameKey: self.className(),
            .identifierKey: Self.commandIdentifier
        ]
    }

    override func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        let connection = NSXPCConnection(serviceName: "com.p-x9.SwiftLintXPC")
        connection.remoteObjectInterface = NSXPCInterface(with: SwiftLintXPCProtocol.self)
        connection.resume()

        let swiftLintXpc = connection.remoteObjectProxy as! SwiftLintXPCProtocol

        swiftLintXpc.setSwiftLintPath(PATH.swiftLintPath, relativePath: Defaults[.swiftlintPathMode] == .relative)
        swiftLintXpc.autocorrectProject {
            if $0 {
                completionHandler(nil)
            }
            completionHandler(NSError(domain: "", code: 0))
        }
        completionHandler(nil)
    }
}

//
//  SourceEditorCommand.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/22.
//  
//

import Foundation
import XcodeKit
import Defaults

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    class var commandIdentifier: String {
        let bundleID = Bundle.main.bundleIdentifier ?? "com.p-x9.SwiftLintPlugin.XcodeEx"
        return bundleID + "." + className()
    }

    class var commandDefinitions: [XCSourceEditorCommandDefinitionKey: Any] {
        [
            .nameKey: "",
            .classNameKey: className(),
            .identifierKey: Self.commandIdentifier
        ]
    }

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {}

}

class AutoCorrectSelectedRangeCommand: SourceEditorCommand {
    override class var commandDefinitions: [XCSourceEditorCommandDefinitionKey: Any] {
        [
            .nameKey: "AutoCorrect Selected Range",
            .classNameKey: self.className(),
            .identifierKey: Self.commandIdentifier
        ]
    }

    override func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        let connection = NSXPCConnection(serviceName: "com.p-x9.SwiftLintXPC")
        connection.remoteObjectInterface = NSXPCInterface(with: SwiftLintXPCProtocol.self)
        connection.resume()

        guard let lines = invocation.buffer.lines as? [String],
              let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange else {
                  return
        }

        let text: String = (selection.start.line...selection.end.line).map { row -> String in
            let line = lines[row]

            let startIndex = line.index(line.startIndex, offsetBy: 0)
            let endIndex = line.index(line.startIndex, offsetBy: line.utf8CString.count - 1)

            return String(line[startIndex ..< endIndex])
        }.joined(separator: " ")

        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }
        let tmpFile = url.appendingPathComponent("tmp.swift")
        do {
            try text.write(to: tmpFile, atomically: true, encoding: .utf8)
        } catch {
            completionHandler(error)
            return
        }

        let swiftLintXpc = connection.remoteObjectProxy as! SwiftLintXPCProtocol

        swiftLintXpc.setSwiftLintPath(PATH.swiftLintPath, relativePath: Defaults[.swiftlintPathMode] == .relative)
        swiftLintXpc.autocorrectFile(at: tmpFile.path) {
            if $0 {
                guard FileManager.default.fileExists(atPath: tmpFile.path),
                      let content = try? String(contentsOf: tmpFile) else {
                          completionHandler(NSError(domain: "Not existed swift file", code: 0))
                          return
                      }
                let lines = content.split(separator: "\n").map { String($0) }
                lines.enumerated().forEach { index, line in
                    if index < invocation.buffer.lines.count {
                        invocation.buffer.lines[index + selection.start.line] = line
                    } else {
                        invocation.buffer.lines.insert(line, at: index)
                    }
                }
                swiftLintXpc.xcodeFormatShortcut()
                completionHandler(nil)
            } else {
                completionHandler(NSError(domain: "failed to run xpc action", code: 0))
            }
        }
    }
}

class AutoCorrectFileCommand: SourceEditorCommand {
    override class var commandDefinitions: [XCSourceEditorCommandDefinitionKey: Any] {
        [
            .nameKey: "AutoCorrect Current File",
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
        swiftLintXpc.autocorrectCurrentFile {
            if $0 {
                completionHandler(nil)
            }
            completionHandler(nil)
        }

    }
}

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

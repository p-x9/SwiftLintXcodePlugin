//
//  SourceEditorCommand.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/22.
//  
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    class var commandIdentifier: String {
        let bundleID = Bundle.main.bundleIdentifier!
        return bundleID + "." + className()
    }
    class var commandDefinitions:[XCSourceEditorCommandDefinitionKey : Any] {
        [
            .nameKey:"",
            .classNameKey:className(),
            .identifierKey:Self.commandIdentifier
        ]
    }
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
    }
    
}

class AutoCorrectFileCommand: SourceEditorCommand {
    override class var commandDefinitions: [XCSourceEditorCommandDefinitionKey : Any] {
        [
            .nameKey:"AutoCorrect Current File",
            .classNameKey:self.className(),
            .identifierKey:Self.commandIdentifier
        ]
    }
    
    override func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        let connection = NSXPCConnection(serviceName: "com.p-x9.SwiftLintXPC")
        connection.remoteObjectInterface = NSXPCInterface(with: SwiftLintXPCProtocol.self)
        connection.resume()
        
        let swiftLintXpc = connection.remoteObjectProxy as! SwiftLintXPCProtocol
        
        swiftLintXpc.autocorrectCurrentFile({
            if $0{
                completionHandler(nil)
            }
            completionHandler(nil)
        })
        
    }
}

class AutoCorrectProjectCommand: SourceEditorCommand {
    override class var commandDefinitions: [XCSourceEditorCommandDefinitionKey : Any] {
        [
            .nameKey:"AutoCorrect All Files",
            .classNameKey:self.className(),
            .identifierKey:Self.commandIdentifier
        ]
    }
    
    override func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        let connection = NSXPCConnection(serviceName: "com.p-x9.SwiftLintXPC")
        connection.remoteObjectInterface = NSXPCInterface(with: SwiftLintXPCProtocol.self)
        connection.resume()
        
        let swiftLintXpc = connection.remoteObjectProxy as! SwiftLintXPCProtocol
        
        swiftLintXpc.autocorrectProject({
            if $0{
                completionHandler(nil)
            }
            completionHandler(NSError.init(domain: "", code: 0))
        })
        completionHandler(nil)
    }
}

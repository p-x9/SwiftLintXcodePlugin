//
//  SwiftLintXPCProtocol.h
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/22.
//  
//

#import <Foundation/Foundation.h>

// The protocol that this service will vend as its API. This header file will also need to be visible to the process hosting the service.
@protocol SwiftLintXPCProtocol

// Replace the API of this protocol with an API appropriate to the service you are vending.
- (void)setSwiftLintPath:(NSString *)path relativePath:(BOOL)isRelative;
- (void)activeWorkspaceDocumentPath:(void (^)(NSString *))reply;
- (void)activeProjectFolderPath:(void (^)(NSString *))reply;
- (void)currentFilePath:(void (^)(NSString *))reply;
- (void)defaultSwiftLintYmlPath:(void (^)(NSString *))reply;
- (void)autocorrectCurrentFile:(void (^)(BOOL))completion;
- (void)autocorrectProject:(void (^)(BOOL))completion;
- (void)autocorrectFileAt:(NSString *)path withCompletion:(void (^)(BOOL))completion;
- (void)xcodeFormatShortcut;
@end

/*
 To use the service from an application or other process, use NSXPCConnection to establish a connection to the service by doing something like this:

     _connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"com.p-x9.SwiftLintXPC"];
     _connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(SwiftLintXPCProtocol)];
     [_connectionToService resume];

Once you have a connection to the service, you can use it like this:

     [[_connectionToService remoteObjectProxy] upperCaseString:@"hello" withReply:^(NSString *aString) {
         // We have received a response. Update our text field, but do it on the main thread.
         NSLog(@"Result string was: %@", aString);
     }];

 And, when you are finished with the service, clean up the connection like this:

     [_connectionToService invalidate];
*/

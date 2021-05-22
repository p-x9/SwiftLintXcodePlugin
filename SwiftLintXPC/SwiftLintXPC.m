//
//  SwiftLintXPC.m
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/22.
//  
//

#import "SwiftLintXPC.h"
#import "Xcode.h"

@implementation SwiftLintXPC

- (void)activeWorkspaceDocumentPath:(void (^)(NSString *))reply {
    XcodeApplication *xcodeApp = [SBApplication applicationWithBundleIdentifier: @"com.apple.dt.Xcode"];
    
    reply(xcodeApp.activeWorkspaceDocument.path);
}

@end

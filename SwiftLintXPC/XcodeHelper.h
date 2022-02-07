//
//  XcodeHelper.h
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/23.
//  
//

#import <Foundation/Foundation.h>

@interface XcodeHelper : NSObject
- (NSString *)activeWorkspaceDocumentPath;
- (NSString *)activeProjectFolderPath;
- (NSString *)currentFilePath;
- (NSString *)defaultSwiftLintYmlPath;
- (void)save;
- (void)xcodeFormatShortcut;
@end


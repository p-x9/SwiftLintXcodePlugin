//
//  XcodeHelper.h
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/23.
//
//

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>
#import "Xcode.h"
#import "XcodeHelper.h"

@interface XcodeHelper ()
@property (nonatomic,retain) XcodeApplication *xcodeApp;
@end


@implementation XcodeHelper

- (id)init{
    self = [super init];
    
    if(self){
        self.xcodeApp = [SBApplication applicationWithBundleIdentifier:@"com.apple.dt.Xcode"];
    }
    
    return  self;
}

- (NSString *)activeWorkspaceDocumentPath {
    return [[self.xcodeApp activeWorkspaceDocument] path];
}

- (NSString *)activeProjectFolderPath {
    return [[self activeWorkspaceDocumentPath] stringByDeletingLastPathComponent];
}

//TODO: modifiedなファイルの扱い
- (NSString *)currentFilePath {
    [self save];
    XcodeWindow *window = [self.xcodeApp windows].firstObject;
    NSString *name = [window.name componentsSeparatedByString:@" "].lastObject;
    NSArray<XcodeDocument *> *documents = [self.xcodeApp documents];
    NSInteger index = [documents indexOfObjectPassingTest:^BOOL(XcodeDocument * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return  [[obj.path lastPathComponent] isEqualToString:name];
    }];
    
    XcodeDocument *currentDocument = [documents objectAtIndex:index];
    
    return [currentDocument path];
}

- (NSString *)defaultSwiftLintYmlPath {
    NSString *projectFolder = [[self activeWorkspaceDocumentPath] stringByDeletingLastPathComponent];
    return [projectFolder stringByAppendingPathComponent:@".swiftlint.yml"];
}

- (void)save {
    NSArray<XcodeDocument*> *documents = [self.xcodeApp documents];
    [documents enumerateObjectsUsingBlock:^(XcodeDocument *obj, NSUInteger idx, BOOL *stop) {
        if(![[obj.path pathExtension] isEqualToString:@"swift"]) return;
        NSData *data = [[NSData alloc] initWithContentsOfFile:obj.path];
        [data writeToFile:obj.path atomically:YES];
        
    }];
}

- (void)xcodeFormatShortcut {
    CGEventSourceRef source = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
    
    CGEventRef i = CGEventCreateKeyboardEvent(source, kVK_ANSI_I, true);
    CGEventSetFlags(i, kCGEventFlagMaskControl);
    CGEventTapLocation location = kCGHIDEventTap;
    
    CGEventPost(location, i);
    
    CFRelease(i);
    CFRelease(source);
}

@end

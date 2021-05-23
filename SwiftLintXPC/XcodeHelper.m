//
//  XcodeHelper.h
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/23.
//
//

#import <Foundation/Foundation.h>
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

//TODO: 違うフォルダの同名ファイルの判別
//TODO: modifiedなファイルの扱い
- (NSString *)currentFilePath {
    XcodeWindow *window = [self.xcodeApp windows].firstObject;
    NSArray<XcodeDocument *> *documents = [self.xcodeApp documents];
    NSInteger index = [documents indexOfObjectPassingTest:^BOOL(XcodeDocument * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return  [[obj.path lastPathComponent] isEqualToString:window.name];
    }];
    
    XcodeDocument *currentDocument = [documents objectAtIndex:index];
    
    return [currentDocument path];
}

- (NSString *)defaultSwiftLintYmlPath {
    NSString *projectFolder = [[self activeWorkspaceDocumentPath] stringByDeletingLastPathComponent];
    return [projectFolder stringByAppendingPathComponent:@".swiftlint.yml"];
}

- (void)save {
    
}

@end

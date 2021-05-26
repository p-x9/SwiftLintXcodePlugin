//
//  SwiftLintXPC.m
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/22.
//  
//

#import "SwiftLintXPC.h"
#import "XcodeHelper.h"
#import "SwiftLintHelper.h"

@interface SwiftLintXPC ()
@property (nonatomic,retain) XcodeHelper *xcodeHelper;
@property (nonatomic,retain) SwiftLintHelper *swiftlintHelper;
@end

@implementation SwiftLintXPC

- (id)init{
    self = [super init];
    self.xcodeHelper = [[XcodeHelper alloc] init];
    self.swiftlintHelper = [[SwiftLintHelper alloc] init];
    
    return self;
}

- (void)setSwiftLintPath:(NSString *)path relativePath:(BOOL)isRelative{
    if(isRelative){
        NSString *resolvedPath = [self.xcodeHelper.activeProjectFolderPath stringByAppendingPathComponent:path];
        self.swiftlintHelper.swiftLintPath = resolvedPath;
    }
    else{
        self.swiftlintHelper.swiftLintPath = path;
    }
}

- (void)activeWorkspaceDocumentPath:(void (^)(NSString *))reply {
   reply([self.xcodeHelper activeWorkspaceDocumentPath]);
}

- (void)activeProjectFolderPath:(void (^)(NSString *))reply {
    reply([self.xcodeHelper activeProjectFolderPath]);
}

- (void)currentFilePath:(void (^)(NSString *))reply {
    reply([self.xcodeHelper currentFilePath]);
}

- (void)defaultSwiftLintYmlPath:(void (^)(NSString *))reply {
    reply([self.xcodeHelper defaultSwiftLintYmlPath]);
}

//TODO: error handling
- (void)autocorrectCurrentFile:(void (^)(BOOL))completion {
    NSString *filePath = [self.xcodeHelper currentFilePath];
    [self.swiftlintHelper autoCorrect:filePath withRule:NULL];
    completion(true);
}

//TODO: error handling
- (void)autocorrectProject:(void (^)(BOOL))completion {
    NSString *projectPath = [self.xcodeHelper activeProjectFolderPath];
    [self.swiftlintHelper autoCorrect:projectPath withRule:NULL];
    completion(true);
}

@end

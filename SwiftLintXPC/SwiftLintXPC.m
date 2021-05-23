//
//  SwiftLintXPC.m
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/22.
//  
//

#import "SwiftLintXPC.h"
#import "Xcode.h"
#import "XcodeHelper.h"

@interface SwiftLintXPC ()
@property (nonatomic,retain) XcodeHelper *xcodeHelper;
@end

@implementation SwiftLintXPC

- (id)init{
    self = [super init];
    self.xcodeHelper = [[XcodeHelper alloc] init];
    
    return self;
}

- (void)activeWorkspaceDocumentPath:(void (^)(NSString *))reply {
   reply([self.xcodeHelper activeWorkspaceDocumentPath]);
}

- (void)currentFilePath:(void (^)(NSString *))reply {
    reply([self.xcodeHelper currentFilePath]);
}

- (void)defaultSwiftLintYmlPath:(void (^)(NSString *))reply {
    reply([self.xcodeHelper defaultSwiftLintYmlPath]);
}

@end

//
//  SwiftLintHelper.m
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/23.
//  
//

#import <Foundation/Foundation.h>
#import "SwiftLintHelper.h"

@interface SwiftLintHelper ()
@property (class,nonnull,readonly) NSString *defaultSwiftLintPath;
@end


@implementation SwiftLintHelper

+ (NSString *)defaultSwiftLintPath {
    return @"/usr/local/bin/swiftlint";
}

- (void)autoCorrect:(NSString *)path withRule:(NSString* _Nullable)rulePath {
    NSMutableArray<NSString *> *arguments = [[NSMutableArray alloc] initWithArray:@[@"lint",@"--fix",@"--path",path]];
    if(rulePath){
        [arguments addObjectsFromArray:@[@"--config",rulePath]];
    }
    [self runSwiftLint:arguments];
}

- (void)runSwiftLint:(NSArray<NSString *>*)arguments {
    [self runCommand:SwiftLintHelper.defaultSwiftLintPath withArguments:arguments];
}

- (void)runCommand:(NSString *)commandPath withArguments:(NSArray<NSString *>*)arguments {
    NSTask *task = [[NSTask alloc] init];
    NSPipe *standardOutput = [NSPipe pipe];
    NSPipe *standardError = [NSPipe pipe];
    
    task.launchPath = commandPath;
    task.arguments = arguments;
    task.standardOutput = standardOutput;
    task.standardError = standardError;
    
    [task launch];
    [task waitUntilExit];
    
    if (task.terminationStatus == 0){
        NSData *errorData = [standardError.fileHandleForReading readDataToEndOfFile];
        NSString *errorString = [[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", errorString);
    }
}

@end

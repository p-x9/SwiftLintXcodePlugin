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

- (int)autoCorrect:(NSString *)path withRule:(NSString* _Nullable)rulePath {
    NSMutableArray<NSString *> *arguments = [[NSMutableArray alloc] initWithArray:@[@"lint",@"--fix",@"--path",path]];
    if(rulePath){
        [arguments addObjectsFromArray:@[@"--config",rulePath]];
    }
    return [self runSwiftLint:arguments];
}

- (int)runSwiftLint:(NSArray<NSString *>*)arguments {
    NSString *swiftLintPath = self.swiftLintPath;
    if(!swiftLintPath){
        swiftLintPath = SwiftLintHelper.defaultSwiftLintPath;
    }
    return [self runCommand:swiftLintPath withArguments:arguments];
}

- (int)runCommand:(NSString *)commandPath withArguments:(NSArray<NSString *>*)arguments {
    NSTask *task = [[NSTask alloc] init];
    NSPipe *standardOutput = [NSPipe pipe];
    NSPipe *standardError = [NSPipe pipe];
    
    task.launchPath = commandPath;
    task.arguments = arguments;
    task.standardOutput = standardOutput;
    task.standardError = standardError;
    
    [task launch];
    [task waitUntilExit];
   
    if (![task isRunning]){
        int status = task.terminationStatus;
        NSData *data = [standardOutput.fileHandleForReading readDataToEndOfFile];
        NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        switch (status) {
            case 0: //Succeed
                NSLog(@"Succeed: %@", output);
                break;
            default: //Failed
                NSLog(@"Faild: %@", output);
                break;
        }
        return status;
    } else {
        return 1;
    }
}

@end

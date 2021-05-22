//
//  SwiftLintXPC.m
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/22.
//  
//

#import "SwiftLintXPC.h"

@implementation SwiftLintXPC

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {
    NSString *response = [aString uppercaseString];
    reply(response);
}

@end

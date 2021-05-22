//
//  SwiftLintXPC.h
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/22.
//  
//

#import <Foundation/Foundation.h>
#import "SwiftLintXPCProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface SwiftLintXPC : NSObject <SwiftLintXPCProtocol>
@end

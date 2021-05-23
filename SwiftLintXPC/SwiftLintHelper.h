//
//  SwiftLintHelper.h
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/23.
//  
//

#import <Foundation/Foundation.h>

@interface SwiftLintHelper : NSObject
- (void)runSwiftLint:(NSArray<NSString *>*_Nonnull)arguments;
- (void)autoCorrect:(NSString *_Nonnull)path withRule:(NSString* _Nullable)rulePath;
@end

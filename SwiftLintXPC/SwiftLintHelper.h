//
//  SwiftLintHelper.h
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/23.
//  
//

#import <Foundation/Foundation.h>

@interface SwiftLintHelper : NSObject
@property (nonatomic,retain) NSString * _Nullable swiftLintPath;
- (int)runSwiftLint:(NSArray<NSString *>*_Nonnull)arguments;
- (int)autoCorrect:(NSString *_Nonnull)path withRule:(NSString* _Nullable)rulePath;
@end

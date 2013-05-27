//
//  NgUser.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/27.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NgUser : NSObject
@property (strong, nonatomic) NSNumber* originUser;
@property (strong, nonatomic) NSNumber* targetUser;
@property (strong, nonatomic) NSNumber* relationId;


+ (NgUser *)ngUserWithOrigin:(NSNumber *)originUser;
+ (NgUser *)ngUserWithOrigin:(NSNumber *)originUser targetUser:(NSNumber *)targetUser;

+ (NSArray *)all;
- (void)save;
- (void)destroy;

+ (NSData *)getRequestToURL:(NSString *)url;
- (void)requestNgUserToURL:(NSString *)url method:(NSString *)method;
@end

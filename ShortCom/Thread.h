//
//  Thread.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/16.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Thread : NSObject
@property (strong, nonatomic) NSNumber* threadId;
@property (strong, nonatomic) NSString* name;
@property (nonatomic) NSNumber* commentCount;

+ (Thread *)threadWithName:(NSString *)name threadId:(NSNumber *)threadId;
+ (Thread *)threadWithName:(NSString *)name threadId:(NSNumber *)threadId commentCount:(NSNumber *)commentCount;

+ (NSArray *)all;
+ (NSData *)getRequestToURL:(NSString *)url;
- (void)save;
- (void)destroy;
@end

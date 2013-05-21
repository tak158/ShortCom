//
//  Comment.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/17.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (strong, nonatomic) NSNumber* commentId;
@property (strong, nonatomic) NSNumber* userId;
@property (strong, nonatomic) NSNumber* threadId;
@property (strong, nonatomic) NSString* note;
@property (strong, nonatomic) NSString* createdAt;

+ (Comment *)commentWithNote:(NSString *)note;
+ (Comment *)commentWithNote:(NSString *)note threadId:(NSNumber *)threadId userId:(NSNumber *)userId;
+ (Comment *)commentWithNote:(NSString *)note threadId:(NSNumber *)threadId userId:(NSNumber *)userId createdAt:(NSString *)createdAt;

+ (NSArray *)all;
+ (NSMutableArray *)getComments:(NSNumber *)threadId;
+ (NSData *)getRequestToURL:(NSString *)url;
- (void)requestCommentToURL:(NSString *)url method:(NSString *)method;
- (void)save;
- (void)destroy;
@end

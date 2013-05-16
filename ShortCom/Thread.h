//
//  Thread.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/16.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Thread : NSObject
@property (nonatomic) int id;
@property (strong, nonatomic) NSString* name;
@property (nonatomic) int commentCount;
@property (strong, nonatomic) NSDate* createdTime;
@property (strong, nonatomic) NSDate* lastCommentTime;

+ (Thread *) treadWithName:(NSString*)name;
@end

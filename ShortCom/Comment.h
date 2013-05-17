//
//  Comment.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/17.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (nonatomic) NSNumber* commentId;
@property (strong, nonatomic) NSString* note;

+ (Comment *)commentWithNote:(NSString *)note;
@end

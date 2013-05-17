//
//  Comment.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/17.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "Comment.h"

@implementation Comment
+ (Comment *)commentWithNote:(NSString *)note
{
  Comment* comment = [[Comment alloc] init];
  comment.note = note;
  
  return comment;
}
@end

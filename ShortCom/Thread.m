//
//  Thread.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/16.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "Thread.h"

@implementation Thread
+ (Thread *)treadWithName:(NSString *)name
{
  Thread* thread = [[Thread alloc] init];
  thread.name = name;
  return thread;
}
@end

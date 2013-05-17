//
//  Thread.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/16.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "Thread.h"

#define SERVER_URL @"http://localhost:3000"

@implementation Thread
+ (Thread *)threadWithName:(NSString *)name
{
  Thread* thread = [[Thread alloc] init];
  thread.name = name;
  
  return thread;
}

+ (Thread *)threadWithName:(NSString *)name commentCount:(NSNumber *)commentCount
{
  Thread* thread = [[Thread alloc] init];
  thread.name = name;
  thread.commentCount = commentCount;
  
  return thread;
}

+ (NSArray *)all{
  NSData* data = [self getRequestToURL:[NSString stringWithFormat:@"%@/boards.json", SERVER_URL]];
  
  if (!data) {
    return @[];
  }
  
  NSError* error = nil;
  NSArray* threadDictionaryArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  if (!threadDictionaryArray) {
    NSLog(@"NSJSONSerialization error:%@", error);
    return @[];
  }
  NSMutableArray* threads = [NSMutableArray array];
  for(NSDictionary* dictionary in threadDictionaryArray)
  {
    Thread* thread = [Thread threadWithName:dictionary[@"name"] commentCount:dictionary[@"comment_count"]];
    [threads addObject:thread];
  }
  NSLog(@"--- all %@", threads);
  return threads;
}

- (void)save
{
  
}

- (void)destroy
{
  
}

+ (NSData *)getRequestToURL:(NSString *)url {
  NSLog(@"--- getRequestToURL: %@", url);
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                  [NSURL URLWithString:url]];
  NSHTTPURLResponse *response = nil;
  NSError *error = nil;
  
  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  if (!data || response.statusCode != 200) {
    NSLog(@"NSURLConnection error:%@ status:%d", error, response.statusCode);
  }
  return data;
}


@end

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
+ (Thread *)threadWithName:(NSString *)name threadId:(NSNumber *)threadId
{
  Thread* thread = [[Thread alloc] init];
  thread.name = name;
  thread.threadId = threadId;
  
  return thread;
}

+ (Thread *)threadWithName:(NSString *)name threadId:(NSNumber *)threadId commentCount:(NSNumber *)commentCount
{
  Thread* thread = [[Thread alloc] init];
  thread.name = name;
  thread.commentCount = commentCount;
  thread.threadId = threadId;
  
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
    Thread* thread = [Thread threadWithName:dictionary[@"name"] threadId:dictionary[@"id"] commentCount:dictionary[@"comment_count"]];
    [threads addObject:thread];
  }
  NSLog(@"--- all %@", threads);
  return threads;
}

- (void)save
{
  if (_threadId) {
    [self requestThreadToURL:[NSString stringWithFormat:@"%@/boards/%@.json", SERVER_URL, _threadId] method:@"PUT"];
  }else{
    [self requestThreadToURL:[NSString stringWithFormat:@"%@/boards.json", SERVER_URL] method:@"POST"];
  }
}

- (void)destroy
{
  NSLog(@"--- destroy %@ %@", _threadId, _name);
  [self requestThreadToURL:[NSString stringWithFormat:@"%@/boards/%@.json", SERVER_URL, _threadId] method:@"DELETE"];
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

- (void)requestThreadToURL:(NSString *)url method:(NSString *)method
{
  NSError* error = nil;
  NSData* requestData = [NSJSONSerialization dataWithJSONObject:@{@"board": @{@"name": _name, @"comment_count" : @"0"}} options:0 error:&error];
  
  if (!requestData) {
    NSLog(@"NSJSONNSerialization error:%@", error);
    return;
  }
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                  [NSURL URLWithString:url]];
  [request setHTTPMethod:method];
  [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [request setHTTPBody:requestData];
  
  NSHTTPURLResponse *response = nil;
  NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  if (!responseData || (response.statusCode != 201 && response.statusCode != 204)) {
    NSLog(@"NSURLConnection error:%@ status:%d", error, response.statusCode);
  }
}

@end

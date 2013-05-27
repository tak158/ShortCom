//
//  NgUser.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/27.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "NgUser.h"
#define SERVER_URL @"http://localhost:3000"

@implementation NgUser

+ (NgUser *)ngUserWithOrigin:(NSNumber *)originUser
{
  NgUser* ngUser = [[NgUser alloc] init];
  ngUser.originUser = originUser;
  
  return ngUser;
}

+ (NgUser *)ngUserWithOrigin:(NSNumber *)originUser targetUser:(NSNumber *)targetUser
{
  NgUser* ngUser = [NgUser ngUserWithOrigin:originUser];
  ngUser.targetUser = targetUser;
  
  return ngUser;
}

+ (NSArray *)all
{
  NSData* data = [self getRequestToURL:[NSString stringWithFormat:@"%@/ng_users.json", SERVER_URL]];
  
  if (!data) {
    return @[];
  }
  
  NSError* error = nil;
  NSArray* userDictionaryArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  if (!userDictionaryArray) {
    NSLog(@"NSJSONSerialization error:%@", error);
    return @[];
  }
  NSMutableArray* ngUsers = [NSMutableArray array];
  for(NSDictionary* dictionary in userDictionaryArray)
  {
    NgUser* ngUser = [NgUser ngUserWithOrigin:dictionary[@"user_id"] targetUser:dictionary[@"target_user"]];
    [ngUsers addObject:ngUser];
  }
  NSLog(@"--- all %@", ngUsers);
  return ngUsers;
}

- (void)save
{
  if (_relationId) {
    [self requestNgUserToURL:[NSString stringWithFormat:@"%@/ng_users/%@.json", SERVER_URL, _relationId] method:@"PUT"];
  }else{
    [self requestNgUserToURL:[NSString stringWithFormat:@"%@/ng_users.json", SERVER_URL] method:@"POST"];
  }
}

- (void)destroy
{
  NSLog(@"--- destroy %@ %@", _originUser, _targetUser);
  [self requestNgUserToURL:[NSString stringWithFormat:@"%@/ng_users/%@.json", SERVER_URL, _relationId] method:@"DELETE"];
}


+ (NSData *)getRequestToURL:(NSString *)url
{
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

- (void)requestNgUserToURL:(NSString *)url method:(NSString *)method
{
  NSError* error = nil;
  NSData* requestData = [NSJSONSerialization dataWithJSONObject:@{@"ng_user": @{@"user_id": _originUser, @"target_user":_targetUser}} options:0 error:&error];
  
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

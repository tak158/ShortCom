//
//  User.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/22.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "User.h"

#define SERVER_URL @"http://localhost:3000"

@implementation User

// イニシャライザ
+ (User *)userWithName:(NSString *)name
{
  User* user = [[User alloc] init];
  user.name = name;
  
  return user;
}

+ (User *)userWithName:(NSString *)name userId:(NSNumber *)userId
{
  User* user = [[User alloc] init];
  user.name = name;
  user.userId = userId;
  
  return user;
}

+ (NSArray *)all
{
  NSData* data = [self getRequestToURL:[NSString stringWithFormat:@"%@/users.json", SERVER_URL]];
  
  if (!data) {
    return @[];
  }
  
  NSError* error = nil;
  NSArray* userDictionaryArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  if (!userDictionaryArray) {
    NSLog(@"NSJSONSerialization error:%@", error);
    return @[];
  }
  NSMutableArray* users = [NSMutableArray array];
  for(NSDictionary* dictionary in userDictionaryArray)
  {
    User* user = [User userWithName:dictionary[@"name"] userId:dictionary[@"id"]];
    [users addObject:user];
  }
  NSLog(@"--- all %@", users);
  return users;
}


+ (NSMutableArray *)allUserName
{
  NSArray* allUser = [User all];
  NSMutableArray* allUserName = [[NSMutableArray alloc] init];
  
  for (int i=0; i<allUser.count; i++) {
    User* kariUser = allUser[i];
    [allUserName addObject:kariUser.name];
  }
  return allUserName;
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

- (void)requestUserToURL:(NSString *)url method:(NSString *)method
{
  NSError* error = nil;
//  NSData* requestData = [NSJSONSerialization dataWithJSONObject:@{@"user": @{@"name": _name, @"id" : _userId}} options:0 error:&error];
  NSData* requestData = [NSJSONSerialization dataWithJSONObject:@{@"user": @{@"name": _name}} options:0 error:&error];
  
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

- (void)save
{
  if (_userId) {
    [self requestUserToURL:[NSString stringWithFormat:@"%@/users/%@.json", SERVER_URL, _userId] method:@"PUT"];
  }else{
    [self requestUserToURL:[NSString stringWithFormat:@"%@/users.json", SERVER_URL] method:@"POST"];
  }
}

- (void)destroy
{
  NSLog(@"--- destroy %@ %@", _userId, _name);
  [self requestUserToURL:[NSString stringWithFormat:@"%@/users/%@.json", SERVER_URL, _userId] method:@"DELETE"];
}
@end

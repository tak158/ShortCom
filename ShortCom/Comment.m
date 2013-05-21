//
//  Comment.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/17.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "Comment.h"

#define SERVER_URL @"http://localhost:3000"

@implementation Comment

+ (Comment *)commentWithNote:(NSString *)note
{
  Comment* comment = [[Comment alloc] init];
  comment.note = note;
  
  return comment;
}

+ (Comment *)commentWithNote:(NSString *)note threadId:(NSNumber *)threadId userId:(NSNumber *)userId
{
  Comment* comment = [[Comment alloc] init];
  comment.note = note;
  comment.threadId = threadId;
  comment.userId = userId;
  
  return comment;
}

+ (Comment *)commentWithNote:(NSString *)note threadId:(NSNumber *)threadId userId:(NSNumber *)userId createdAt:(NSString *)createdAt
{
  Comment* comment = [[Comment alloc] init];
  comment.note = note;
  comment.threadId = threadId;
  comment.userId = userId;
  comment.createdAt = createdAt;
  
  return comment;
}


+ (NSArray *)all
{

  NSData* data = [self getRequestToURL:[NSString stringWithFormat:@"%@/comments.json", SERVER_URL]];
  
  if (!data) {
    return @[];
  }

  NSError* error = nil;
  NSArray* commentDictionaryArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  if (!commentDictionaryArray) {
    NSLog(@"NSJSONSerialization error:%@", error);
    return @[];
  }
  NSMutableArray* comments = [NSMutableArray array];
  for(NSDictionary* dictionary in commentDictionaryArray)
  {
    Comment* comment = [Comment commentWithNote:dictionary[@"note"] threadId:dictionary[@"board_id"] userId:dictionary[@"user_id"] createdAt:dictionary[@"created_at"]];
    [comments addObject:comment];
  }
  NSLog(@"--- all %@", comments);
  return comments;
}

+ (NSArray *)getComments:(NSNumber *)threadId
{
  return [NSArray arrayWithContentsOfFile:@"you"];
}

- (void)save
{
  NSLog(@"--- save %@ %@ _userId:%@ _threadId(boardid)%@", _commentId, _note, _userId, _threadId);
  if(_commentId){
  
    [self requestCommentToURL:[NSString stringWithFormat:@"%@/comments/%@.json", SERVER_URL, _commentId] method:@"PUT"];
  }else{
    [self requestCommentToURL:[NSString stringWithFormat:@"%@/comments.json", SERVER_URL] method:@"POST"];
  }
}

- (void)destroy
{
  NSLog(@"--- destroy %@ %@ %@ %@", _commentId, _userId, _threadId, _note);
  [self requestCommentToURL:[NSString stringWithFormat:@"%@/comments/%@.json", SERVER_URL, _commentId] method:@"DELETE"];
}

- (NSData *)getRequestToURL:(NSString*)url
{
  NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
  NSHTTPURLResponse* response = nil;
  NSError* error = nil;
  
  NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  if (!data || response.statusCode != 200) {
    NSLog(@"NSURLConnection error:%@ status:%d", error, response.statusCode);
  }
  return data;
}

- (void)requestCommentToURL:(NSString *)url method:(NSString *)method {
  NSError* error = nil;
  NSData* requestData = [NSJSONSerialization dataWithJSONObject:@{@"comment": @{@"note": _note}} options:0 error:&error];
  if(!requestData){
    NSLog(@"NSJSONSerialization error:%@ ", error);
    return;
  }
  
  NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
  
  [request setHTTPMethod:method];
  [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [request setHTTPBody:requestData];
  
  NSHTTPURLResponse *response = nil;
  NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  if (!responseData || (response.statusCode != 201 && response.statusCode != 204)) {
    NSLog(@"NSURLConnection error:%@ status:%d", error, response.statusCode);
  }
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

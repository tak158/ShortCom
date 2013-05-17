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

+ (Comment *)commentWithNote:(NSString *)note threadId:(NSNumber *)threadId userId:(NSNumber *)userId commentId:(NSNumber *)commentId
{
  Comment* comment = [[Comment alloc] init];
  comment.note = note;
  comment.threadId = threadId;
  comment.userId = userId;
  comment.commentId = commentId;
  
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
    Comment* comment = [Comment commentWithNote:dictionary[@"note"] threadId:dictionary[@"board_id"] userId:dictionary[@"user_id"] commentId:dictionary[@"id"]];
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
  
}

- (void)destroy
{
  ;
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

@end

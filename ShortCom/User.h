//
//  User.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/22.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSNumber* userId;
@property (strong, nonatomic) NSString* name;

+ (NSArray *)all;
- (void)save;
- (void)destroy;

+ (NSData *)getRequestToURL:(NSString *)url;
@end

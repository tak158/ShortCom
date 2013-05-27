//
//  CommentDetailViewController.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/24.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *blockButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameText;
@property (weak, nonatomic) IBOutlet UILabel *commentText;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* comment;
@property (strong, nonatomic) NSNumber* targetUserId;
@end

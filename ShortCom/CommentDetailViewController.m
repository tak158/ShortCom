//
//  CommentDetailViewController.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/24.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "CommentDetailViewController.h"
#import "BoardViewController.h"
#import "NgUser.h"

@interface CommentDetailViewController ()

@end

@implementation CommentDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  _userNameText.text = _name;
  _commentText.text = _comment;
  NSLog(@"%@", _targetUserId);
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)didPushClose:(id)sender {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

// ブロックButtonを押したらrailsにngUserを登録する
- (IBAction)blockButton:(id)sender {
  NSUserDefaults* originUser = [NSUserDefaults standardUserDefaults];
  NSInteger originId = [originUser integerForKey:@"USER_ID"];
  NSNumber* originNumberId = [NSNumber numberWithInteger:originId];
  NgUser* ngUser = [NgUser ngUserWithOrigin:originNumberId targetUser:_targetUserId];
  NSLog(@"oreno id : %d", [originUser integerForKey:@"USER_ID"]);
  [ngUser save];
  NSLog(@"NGどや");
}

@end

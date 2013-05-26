//
//  CommentDetailViewController.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/24.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "CommentDetailViewController.h"
#import "BoardViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)didPushClose:(id)sender {
  [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)blockButton:(id)sender {
}

@end

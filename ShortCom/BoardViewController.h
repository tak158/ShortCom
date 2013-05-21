//
//  BoardViewController.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/17.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import <Social/Social.h>
#import "CommentViewCell.h"
#import "Thread.h"

@interface BoardViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* table;
@property (strong, nonatomic) NSMutableArray* comments;
@property (strong, nonatomic) NSIndexPath* commentIndexPath;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *postButton;
@property (strong, nonatomic) NSNumber* boardId;
@property (strong, nonatomic) Thread* thread;


- (IBAction)pushedButton:(id)sender;
@end

//
//  BoardViewController.h
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/17.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *inputButton;
- (IBAction)pushedButton:(id)sender;
@property (strong, nonatomic) NSMutableArray* table;
@end

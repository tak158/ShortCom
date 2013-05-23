//
//  ViewController.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/16.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "ViewController.h"
#import "Thread.h"
#import "ThreadDetailViewController.h"
#import "BoardViewController.h"
#import "ConfigViewController.h"
#import "User.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  NSLog(@"data is : %@", [Thread all]);
  // ユーザ情報を取得する
  _userData = [NSUserDefaults standardUserDefaults];
  
  [self setupThread];
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)setupThread
{
  _threads = [[NSMutableArray alloc] init];
  _threads = [[Thread all] mutableCopy];
  NSLog(@"%@", _threads);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_threads count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ThreadCell" forIndexPath:indexPath];
  Thread* thread = _threads[indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", thread.name, thread.commentCount];
  return cell;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
  [super setEditing:editing animated:animated];
  [_tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [_threads[indexPath.row] destroy];
    [_threads removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  _updateIndexPath = _tableView.indexPathForSelectedRow;
  if ([[segue identifier] isEqualToString:@"new"]) {
    ThreadDetailViewController* detailViewController = [segue destinationViewController];
    detailViewController.thread = [Thread threadWithName:@"" threadId:0];
    _updateIndexPath = [NSIndexPath indexPathForRow:[_threads count] inSection:0];
  }else if([[segue identifier] isEqualToString:@"edit"]){
    ThreadDetailViewController* detailViewController = [segue destinationViewController];
    _updateIndexPath = _tableView.indexPathForSelectedRow;
    [self.tableView deselectRowAtIndexPath:_tableView.indexPathForSelectedRow animated:YES];
    detailViewController.thread = _threads[_updateIndexPath.row];
  }else if([[segue identifier] isEqualToString:@"board"]){
    BoardViewController* boardViewController = [segue destinationViewController];
    boardViewController.thread = _threads[_updateIndexPath.row];
    boardViewController.boardId = boardViewController.thread.threadId;
  }
}

- (IBAction)threadUpdated:(UIStoryboardSegue *)segue
{
  if (_updateIndexPath.row == [_threads count]) {
    ThreadDetailViewController* detailViewController = [segue sourceViewController];
    [_threads addObject:detailViewController.thread];
    [_tableView insertRowsAtIndexPaths:@[_updateIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    // 新規スレッドにidを設定する
  }else{
    [_tableView reloadRowsAtIndexPaths:@[_updateIndexPath] withRowAnimation:UITableViewRowAnimationNone];
  }
  [_threads[_updateIndexPath.row] save];
  _threads = [[Thread all] mutableCopy];
  [_tableView reloadData];
}

// モーダルでユーザ登録し、モーダルを閉じた場合
- (IBAction)userUpdated:(UIStoryboardSegue *)segue
{
  ConfigViewController* configViewController = [segue sourceViewController];
  if (configViewController.userNameText.text != [_userData stringForKey:@"USER_NAME"]){
    [_userData setObject:configViewController.userNameText.text forKey:@"USER_NAME"];
    [_userData synchronize];
  }
  
  // 登録時、サーバを見て、名前がなければDBに追加する
  NSMutableArray* userNames = [User allUserName];
  // 名前がDBに存在していた場合
  if ([userNames containsObject:[_userData stringForKey:@"USER_NAME"]]) {
    ;
  // 存在していない場合はDBに登録する
  }else{
    User* registUser = [User userWithName:[_userData stringForKey:@"USER_NAME"]];
    [registUser save];
    //NSUserDefaltsにuser_idをセット
    [_userData setInteger:[registUser.userId integerValue] forKey:@"USER_ID"];
  }
}

@end

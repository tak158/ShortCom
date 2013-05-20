//
//  CommentViewCell.m
//  ShortCom
//
//  Created by uchikawa takao on 2013/05/20.
//  Copyright (c) 2013年 uchikawa takao. All rights reserved.
//

#import "CommentViewCell.h"

@implementation CommentViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

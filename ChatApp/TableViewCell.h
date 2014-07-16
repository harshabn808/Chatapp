//
//  TableViewCell.h
//  ChatApp
//
//  Created by Harsha Badami Nagaraj on 7/15/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userNameField;
@property (weak, nonatomic) IBOutlet UILabel *chatTextField;

@end

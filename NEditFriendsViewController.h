//
//  NEditFriendsViewController.h
//  Rabbit
//
//  Created by Hazel Jiang on 5/7/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface NEditFriendsViewController : UITableViewController

@property (nonatomic, strong) NSArray *allUsers;
@property (nonatomic, strong) PFUser * currentUser;
@property (nonatomic, strong) NSMutableArray *friends;
- (BOOL) isFriend: (PFUser *) user;
@end

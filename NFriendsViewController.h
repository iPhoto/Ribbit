//
//  NFriendsViewController.h
//  Rabbit
//
//  Created by Hazel Jiang on 5/1/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<Parse/Parse.h>
@interface NFriendsViewController : UITableViewController
@property (nonatomic, strong) PFRelation *friendsRelation;
@property (nonatomic, strong) NSArray *friends;
@end

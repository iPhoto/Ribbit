//
//  NEditFriendsViewController.m
//  Rabbit
//
//  Created by Hazel Jiang on 5/7/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import "NEditFriendsViewController.h"
@interface NEditFriendsViewController ()

@end

@implementation NEditFriendsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query  findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error : %@ %@", error, [error userInfo]);
        }
        else{
            self.allUsers = objects;
            [self.tableView reloadData];
        
        }
    }];
    
    self.currentUser = [PFUser currentUser];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.allUsers.count;
}
-(UITableViewCell *) tableView: (UITableView * ) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    if ([self isFriend:user]) {
     
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
    
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    }
    
    
    
    return cell;





}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
    //Delete friends
    if ([self isFriend:user]) {
        
        //1. remove the checkmark
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        //2. remove from the array of friends
        for (PFUser *friend in self.friends) {
            if ([friend.objectId isEqualToString:user.objectId]) {
          
                [self.friends removeObject:friend];
                break;
            
            }
        }
        //3. remove from backend
          [friendsRelation removeObject:user];
    }
  
    else
        // Add new friend
{
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self.friends addObject:user];
    [friendsRelation addObject:user];
    
  
}
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
    
    }];

}

#pragma mark - Helper methods
- (BOOL) isFriend: (PFUser *) user
{
    for (PFUser *friend in self.friends) {
        if ([friend.objectId isEqualToString:user.objectId]) {
            return YES;
        }
    }
    return NO;


}

@end

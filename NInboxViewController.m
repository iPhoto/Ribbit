//
//  NInboxViewController.m
//  Rabbit
//
//  Created by Hazel Jiang on 4/27/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import "NInboxViewController.h"
#import <Parse/Parse.h>

@interface NInboxViewController ()

@end

@implementation NInboxViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    PFUser *currentUser = [PFUser currentUser];
    if(currentUser){
        NSLog(@"Current user : %@", currentUser.username);
    
    }
    else{
    [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}
- (void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    [query whereKey:@"recipientIds" equalTo:[[PFUser currentUser] objectId]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@ ", error, [error userInfo]);
        }
        else{
        
            self.messages = objects;
            [self.tableView reloadData];
            NSLog(@"Retrieved %d messages", [self.messages count]);
        
        }
    }];

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
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    cell.textLabel.text = [message objectForKey:@"senderName"];
    
    NSString * typeofFile= [message objectForKey:@"fileType"];
    if ([@"image" isEqualToString:typeofFile])
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_image"];
        
    }
    else{
        cell.imageView.image = [UIImage imageNamed:@"icon_video"];

        
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    NSString * typeofFile= [message objectForKey:@"fileType"];
    
    if ([@"image" isEqualToString:typeofFile])
    {
        NSLog(@"Entered!");

        [self performSegueWithIdentifier:@"showImage" sender:self];
    }
    else{
        
        
    }






}

- (IBAction)logout:(id)sender {
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
    
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender   {

    if ([segue.identifier isEqualToString:@"showLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }


}
@end

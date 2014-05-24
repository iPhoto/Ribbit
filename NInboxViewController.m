//
//  NInboxViewController.m
//  Rabbit
//
//  Created by Hazel Jiang on 4/27/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import "NInboxViewController.h"
#import "NImageViewController.h"
#import "MSCellAccessory.h"


@interface NInboxViewController ()

@end

@implementation NInboxViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.moviePlayer = [[MPMoviePlayerController alloc] init];
    
    //Check current user login status. If no user login, show login page.
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser){
        NSLog(@"Current user : %@", currentUser.username);
    
    }
    else
    {
    
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(retrieveMessages) forControlEvents:UIControlEventValueChanged];
}


- (void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self retrieveMessages];

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
    
    UIColor *disclosureColor = [UIColor colorWithRed:0.553 green:0.439 blue:0.718 alpha:1.0];
    cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:disclosureColor];
    
    NSString *fileType= [message objectForKey:@"fileType"];
    if ([fileType.description isEqualToString:@"image"])
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_image"];
        
    }
    else{
        cell.imageView.image = [UIImage imageNamed:@"icon_video"];

        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    self.selectedMessages = [self.messages objectAtIndex:indexPath.row];
    NSString * fileType= [self.selectedMessages objectForKey:@"fileType"];

    if ([fileType isEqualToString:@"image"])
    {        
        [self performSegueWithIdentifier:@"showImage" sender:self];
    }
    else{
        PFFile *videoFile = [self.selectedMessages objectForKey:@"file"];
        NSURL *fileUrl = [NSURL URLWithString:videoFile.url];
        self.moviePlayer.contentURL = fileUrl;
        [self.moviePlayer prepareToPlay];
      //  [self.moviePlayer thumbnailImageAtTime:0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        //Add it to the view controller so we can see it
        [self.view addSubview:self.moviePlayer.view];
        [self.moviePlayer setFullscreen:YES animated:YES];
        
      
        
    }

    
    //Delete it
    NSMutableArray *recipientIds = [NSMutableArray arrayWithArray:[self.selectedMessages objectForKey:@"recipientIds"]];
    NSLog(@"Recipients:%@", recipientIds);
    if ([recipientIds count] == 1) {
        // Last recipient - delete!
        [self.selectedMessages deleteInBackground];
    }
    else{
        // Remove the recipient and save it
        [recipientIds removeObject:[[PFUser currentUser] objectId]];
        [self.selectedMessages setObject:recipientIds forKey:@"recipientIds"];
        [self.selectedMessages saveInBackground];
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
    else if ([segue.identifier isEqualToString:@"showImage"]){
    
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        NImageViewController *imageViewController = (NImageViewController *) segue.destinationViewController;
        imageViewController.message = self.selectedMessages;
    }

}

- (void)retrieveMessages {
    
    PFQuery *query = [PFQuery queryWithClassName:@"messages"];
    [query whereKey:@"recipientIds" equalTo:[[PFUser currentUser] objectId]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@ ", error, [error userInfo]);
        }
        else{
            
            self.messages = objects;
            [self.tableView reloadData];
       //     NSLog(@"Retrieved %d messages", [self.messages count]);
            
        }
        
        if ([self.refreshControl isRefreshing]) {
            [self.refreshControl endRefreshing];
        }
    }];
}


@end

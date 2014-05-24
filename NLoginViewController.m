//
//  NLoginViewController.m
//  Rabbit
//
//  Created by Hazel Jiang on 4/27/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import "NLoginViewController.h"
#import <parse/Parse.h>

@interface NLoginViewController ()

@end

@implementation NLoginViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:(BOOL)animated];
    [self.navigationController.navigationBar setHidden:YES];

}
- (IBAction)login:(id)sender {
    
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //Add a activity indicator which indicating the login is under processing.
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    CGRect frame = activityIndicator.frame;
    frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
    activityIndicator.frame = frame;
    [self.view addSubview: activityIndicator];
    [self.view bringSubviewToFront:activityIndicator];
    activityIndicator.hidesWhenStopped = YES;
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    
    if([username length] == 0 || [password length] == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"oops!" message:@"Make sure you enter a username and password!" delegate:nil cancelButtonTitle:@"ok!" otherButtonTitles:nil];
        [alertView show];
        
    }
    else{
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else{
                //Login succeed, stop animating indicator.
                [activityIndicator stopAnimating];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
            }

            
        }];
        
        
        
        
        
    }
}
@end

//
//  NLoginViewController.h
//  Rabbit
//
//  Created by Hazel Jiang on 4/27/14.
//  Copyright (c) 2014 Hazel Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)login:(id)sender;

@end

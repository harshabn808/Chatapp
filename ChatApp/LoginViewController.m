//
//  LoginViewController.m
//  ChatApp
//
//  Created by Harsha Badami Nagaraj on 7/15/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "LoginViewController.h"
#import "ChatViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)onLoginButton:(id)sender;
- (IBAction)onSignupButton:(id)sender;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginButton:(id)sender {
    [PFUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSLog(@"Successfully logged in");
                                            [self.navigationController pushViewController:[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil] animated:YES];
                                        } else {
                                            NSLog(@"%@", [error description]);
                                        }
                                    }];
}

- (IBAction)onSignupButton:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.usernameField.text;
    user.password = self.passwordField.text;
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Successfully Signed up");
        } else {
            NSLog(@"Error signingup : %@", [error description]);
        }
    }];
}
@end

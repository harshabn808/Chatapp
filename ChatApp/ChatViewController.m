//
//  ChatViewController.m
//  ChatApp
//
//  Created by Harsha Badami Nagaraj on 7/15/14.
//  Copyright (c) 2014 Harsha Badami Nagaraj. All rights reserved.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>
#import "TableViewCell.h"

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UITextView *chatView;
- (IBAction)onSend:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *chatObjects;
- (void) callAfterOneSecond;

@end

@implementation ChatViewController

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                                      selector: @selector(callAfterOneSecond) userInfo: nil repeats: YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell * chatCell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message = self.chatObjects[indexPath.row];
    PFUser *user = message[@"user"];
    chatCell.userNameField.text = user[@"username"];
    chatCell.chatTextField.text = message[@"text"];
    
    return chatCell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatObjects.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}


- (void) callAfterOneSecond {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Message"];
    [query setLimit:100];
    [query includeKey:@"user"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.chatObjects = objects;
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (IBAction)onSend:(id)sender {
    
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"text"] = self.chatView.text;
    message[@"user"] = [PFUser currentUser];
    [message saveInBackground];    
}


@end

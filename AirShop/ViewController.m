//
//  ViewController.m
//  AirShop
//
//  Created by CMU on 10/18/14.
//  Copyright (c) 2014 CMU. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController ()

-(void)toggleHiddenState:(BOOL)shouldHide;

@end


@implementation ViewController
@synthesize CheckBox1;
@synthesize CheckBox2;
@synthesize CheckBox3;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.loginButton.delegate = self;
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    
    [self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    
    checked1 = NO;
    checked2 = NO;
    checked3 = NO;
    checked4 = NO;
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];// Dispose of any resources that can be recreated.
   
}

-(void)toggleHiddenState:(BOOL)shouldHide{
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
}
-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    self.lblLoginStatus.text = @"You are logged in.";
    
    [self toggleHiddenState:NO];
   
}
-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    NSLog(@"%@", user);
    self.profilePicture.profileID = user.objectID;
    self.lblUsername.text = user.name;
    self.lblEmail.text = [user objectForKey:@"email"];
}
-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
   
    self.lblLoginStatus.text = @"You are logged out";
    
    [self toggleHiddenState:YES];
    
}
-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}

-(void)doSegue{
    [self performSegueWithIdentifier:@"PreferencePage" sender:self];
}
- (IBAction)CheckBox1Action:(id)sender {
    if (!checked1) {
        [CheckBox1 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        checked1 = YES;

    }
    else if (checked1) {
            [CheckBox1 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            checked1 = NO;

        
}
}

- (IBAction)CheckBox2Action:(id)sender {
    if (!checked2) {
        [CheckBox2 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        checked2 = YES;
    }
    else if (checked2) {
        [CheckBox2 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        checked2 = NO;

    }
}

- (IBAction)CheckBox3Action:(id)sender {
    if (!checked3) {
        [CheckBox3 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        checked3 = YES;
    }
    else if (checked3) {
        [CheckBox3 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        checked3 = NO;
        
    }
}
@end

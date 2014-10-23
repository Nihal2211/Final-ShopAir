//
//  ViewController.h
//  AirShop
//
//  Created by CMU on 10/18/14.
//  Copyright (c) 2014 CMU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController<FBLoginViewDelegate>{
    bool checked1;
    
    bool checked2;
    
    bool checked3;
    
    bool checked4;
}
@property (weak, nonatomic) IBOutlet UIButton *CheckBox1;

- (IBAction)CheckBox1Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *CheckBox2;
- (IBAction)CheckBox2Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *CheckBox3;
- (IBAction)CheckBox3Action:(id)sender;


@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePicture;

@property (weak, nonatomic) IBOutlet UIButton *p1;

@end




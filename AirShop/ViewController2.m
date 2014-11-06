//
//  ViewController.m
//  AirShop
//
//  Created by CMU on 10/18/14.
//  Copyright (c) 2014 CMU. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <EstimoteSDK/ESTBeacon.h>
#import <EstimoteSDK/ESTBeaconManager.h>
#import <EstimoteSDK/ESTBeaconRegion.h>

@interface ViewController ()

-(void)toggleHiddenState:(BOOL)shouldHide;




@end




@implementation ViewController
@synthesize CheckBox1;
@synthesize CheckBox2;
@synthesize CheckBox3;
@synthesize CheckBox4;
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
    
    /////////////////////////////////////////////////////////////
    // setup Estimote beacon manager
    
    // create manager instance
    //---init and set the delegate---
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    //---create a NSUUID object---
    NSUUID *proximityUUID =
    [[NSUUID alloc] initWithUUIDString:
     @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    //---Estimote beacon---
    
    //---create a region---
    
    //---create a region---
    self.beaconRegion =
    [[CLBeaconRegion alloc]
     initWithProximityUUID:proximityUUID
     major:1
     minor:1
     identifier:@"net.learn2develop.myRegion"];
    
    self.beaconPeripheralData =
    [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    
    self.peripheralManager =
    [[CBPeripheralManager alloc] initWithDelegate:self
                                            queue:nil
                                          options:nil];
    
    //---start monitoring a region---
    [self.locationManager
     startMonitoringForRegion:self.beaconRegion];
}


//---called when the device enters a region---
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region {
    [self.locationManager
     startRangingBeaconsInRegion:self.beaconRegion];
    
    self.lbltext1.text = @"Entered region";
    
    UILocalNotification *localNotification =
    [[UILocalNotification alloc] init];
    //---the message to display for the alert---
    localNotification.alertBody =
    @"You have entered the region you are monitoring";
    
    //---uses the default sound---
    localNotification.soundName =
    UILocalNotificationDefaultSoundName;
    
    //---title for the button to display---
    localNotification.alertAction = @"Details";
    
    //---schedule the notification---
    [[UIApplication sharedApplication]
     presentLocalNotificationNow:localNotification];
}

//---called when the device exits a region---
-(void)locationManager:(CLLocationManager *)manager
         didExitRegion:(CLRegion *)region {
    [self.locationManager
     stopRangingBeaconsInRegion:self.beaconRegion];
    
    self.lbltext1.text = @"Exited region";
    self.lbltext2.text = @"No";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];// Dispose of any resources that can be recreated.
    
}
-(void)locationManager:(CLLocationManager *)manager
       didRangeBeacons:(NSArray *)beacons
              inRegion:(CLBeaconRegion *)region {
    
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons lastObject];
    
    self.lblBeaconFound.text = @"Yes";
    self.lblUUID.text = beacon.proximityUUID.UUIDString;
    self.lblMajor.text =
    [NSString stringWithFormat:@"%@", beacon.major];
    
    self.lblMinor.text =
    [NSString stringWithFormat:@"%@", beacon.minor];
    
    self.lblAccuracy.text =
    [NSString stringWithFormat:@"%f meters", beacon.accuracy];
    
    switch (beacon.proximity) {
        case CLProximityUnknown:
            self.lblDistance.text = @"Unknown Proximity";
            break;
        case CLProximityImmediate:
            self.lblDistance.text = @"Immediate";
            break;
        case CLProximityNear:
            self.lblDistance.text = @"Near";
            break;
        case CLProximityFar:
            self.lblDistance.text = @"Far";
            break;
    }
    self.lblRSSI.text =
    [NSString stringWithFormat:@"%li decibels",
     (long)beacon.rssi];
}
-(void) peripheralManagerDidUpdateState:
(CBPeripheralManager *)peripheral {
    
    NSLog(@"peripheralManagerDidUpdateState:");
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"CBPeripheralManagerStatePoweredOff");
            break;
        case CBPeripheralManagerStateResetting:
            NSLog(@"CBPeripheralManagerStateResetting");
            break;
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"CBPeripheralManagerStatePoweredOn");
            
            //---start advertising the beacon data---
            [self.peripheralManager
             startAdvertising:self.beaconPeripheralData];
            break;
        case CBPeripheralManagerStateUnauthorized:
            NSLog(@"CBPeripheralManagerStateUnauthorized");
            break;
        case CBPeripheralManagerStateUnsupported:
            NSLog(@"CBPeripheralManagerStateUnsupported");
            break;
        default:
            NSLog(@"CBPeripheralStateUnknown");
            break;
    }
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


- (IBAction)CheckBox4Action:(id)sender {
    if (!checked4) {
        [CheckBox4 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        checked4 = YES;
    }
    else if (checked4) {
        [CheckBox4 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        checked4 = NO;
        
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



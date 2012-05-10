//
//  HomeViewController.h
//  fusd
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "IASKAppSettingsViewController.h"
//@class GCDiscreetNotificationView;

@interface HomeViewController : UIViewController {
    
}
//@property (nonatomic, retain) GCDiscreetNotificationView *notificationView;


- (IBAction)pushnews;
- (IBAction)pushcal;
- (IBAction)pushcom;
- (IBAction)pushsbo;
- (IBAction)pushdis;
- (IBAction)pushscho;
- (IBAction)pushbud;
- (IBAction)pushem;
- (IBAction)pushsetting;
@property(nonatomic, retain) NSURL *urlObject;

@end

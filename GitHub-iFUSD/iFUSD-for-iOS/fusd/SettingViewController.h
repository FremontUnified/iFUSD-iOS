//
//  SettingViewController.h
//  fusdbeta
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IASKAppSettingsViewController.h"
//@class GCDiscreetNotificationView;

@interface SettingViewController : UIViewController <UIWebViewDelegate> {
    IASKAppSettingsViewController *appSettingsViewController;
    
}

@property (nonatomic, retain) IASKAppSettingsViewController *appSettingsViewController;
//@property (nonatomic, retain) GCDiscreetNotificationView *notificationView;

-(IBAction)push;
-(IBAction)share;
//share is really user guide
- (IBAction)showSettings;
-(IBAction)about;


@end

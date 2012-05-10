//
//  PushSchoolsViewController.h
//  fusd
//
//  Created by Sumukh Sridhara on 7/9/11.
//  Copyright 2011 Sumukh Sridhara. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCDiscreetNotificationView;


@interface PushSchoolsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>{
	IBOutlet UITableView *tblSimpleTable;
	NSArray *arryMicrosoft;
    NSArray *arryAppleProducts;
    NSArray *arryCisco;
	NSArray *arryAdobeSoftwares;
    NSArray *arryHewlettPackard;
    NSArray *arryGoogle;
    //named for the districts CMS, so this is for the district office level settings
    NSArray *arrySchoolwires;
    BOOL checkmark;    

//yes I name arrays after tech comapanies. Why? I don't know. :) 
    IBOutlet UIWebView *webView;
    IBOutlet UITableView *tableView2;

}
@property (nonatomic, retain) GCDiscreetNotificationView *notificationView;

-(IBAction)close;
-(IBAction)scrolltotop;

@end

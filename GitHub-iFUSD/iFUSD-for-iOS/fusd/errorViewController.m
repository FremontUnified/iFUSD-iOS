//
//  errorViewController.m
//  fusd
//
//  Created by Sumukh Sridhara on 7/13/11.
//  Copyright 2011 Sumukh Sridhara. All rights reserved.
//

#import "errorViewController.h"
#import "Reachability.h"
#import "MKInfoPanel.h"

@implementation errorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [MKInfoPanel showPanelInView:self.view 
                            type:MKInfoPanelTypeError 
                           title:@"Network Failure" 
                        subtitle:nil
                       hideAfter:3  origin:MKInfoPanelOriginBottom];

  //  [MKInfoPanel showPanelInView:self.view type:MKInfoPanelTypeError title:@"Network Failure!" subtitle:nil hideAfter:15];
    //subtitle:@"Check your internet connection and try again later!" 

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"FUSD for iOS requires an Internet Connection. Please Verify that you are connected to a WiFi or Cellular network and Try Again!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
    [alert show];
    [alert release];

    //UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"APP NAME" message:@"Whoops! Looks like you aren't connected to a network." delegate:self cancelButtonTitle:@"Okay, thats fine!" otherButtonTitles:nil];
    
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}
-(void)fail {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"FUSD for iOS requires an Internet Connection. Please Verify that you are connected to a WiFi or Cellular network and Try Again!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
    [alert show];
    [alert release];

}

-(IBAction)retry:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"FUSD for iOS requires an Internet Connection. Please Verify that you are connected to a WiFi or Cellular network and Try Again!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
    [alert show];
    [alert release];

}
- (void)alertView:(UIAlertView *)alert willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
//
    }
    else if (buttonIndex == 1)
    {
        {  Reachability *r = [Reachability reachabilityWithHostName:@"ifusd.fremontunified.org"];
        
        NetworkStatus internetStatus = [r currentReachabilityStatus];
        

        
        if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@" Attempt to Connect Failed. FUSD for iOS requires an Internet Connection. Please close this application and verify that you have a Network Connnection. You may Contact Support at ifusd1@gmail.com" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
            [MKInfoPanel showPanelInView:self.view 
                                    type:MKInfoPanelTypeError 
                                   title:@"Network Failure. " 
                                subtitle:@"Please contact support at ifusd1@gmail.com" 
                               hideAfter:10  origin:MKInfoPanelOriginBottom];

            [alert show];
            [alert release];


            
            //        [self presentModalViewController:error animated:YES];
            
        }
        else 
        {
            [self dismissModalViewControllerAnimated:YES];
            // Add registration for remote notifications
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
            
        } }
        
        

        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

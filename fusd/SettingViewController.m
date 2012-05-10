//
//  SettingViewController.m
//  fusdbeta
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//

#import "SettingViewController.h"
#import "HomeViewController.h"
#import "PushSchoolsViewController.h"
#import "Reachability.h"

#import "UserGuideViewController.h"
#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"
#import "AboutViewController.h"
#import "MKInfoPanel.h"
//#import "GCDiscreetNotificationView.h"






@implementation SettingViewController

@synthesize appSettingsViewController;
//@synthesize notificationView;

//@synthesize aView;
- (IASKAppSettingsViewController*)appSettingsViewController {
	if (!appSettingsViewController) {
		appSettingsViewController = [[IASKAppSettingsViewController alloc] initWithNibName:@"IASKAppSettingsView" bundle:nil];
		appSettingsViewController.delegate = self;
	}
	return appSettingsViewController;
}

- (IBAction)showSettings {
	//[viewController setShowCreditsFooter:NO];   // Uncomment to not display InAppSettingsKit credits for creators.
	// But we encourage you no to uncomment. Thank you!
	self.appSettingsViewController.showDoneButton = NO;
	[self.navigationController pushViewController:self.appSettingsViewController animated:YES];
}
/*
- (IBAction)showSettingsModal:(id)sender {
    UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:self.appSettingsViewController];
    //[viewController setShowCreditsFooter:NO];   // Uncomment to not display InAppSettingsKit credits for creators.
    // But we encourage you not to uncomment. Thank you!
    self.appSettingsViewController.showDoneButton = YES;
    [self presentModalViewController:aNavController animated:YES];
    [aNavController release];
}
*/
#pragma mark -
#pragma mark IASKAppSettingsViewControllerDelegate protocol
- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
    [self dismissModalViewControllerAnimated:YES];
	// your code here to reconfigure the app for changed settings
}

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
    [appSettingsViewController release];
	appSettingsViewController = nil;

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    self.appSettingsViewController = nil;

    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //we have the background image coming from the XIB so we're good and don't need this line. 
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loading.png"]];
    
    //scrollViewTexturedBackgroundColor
    //webview needs a background so we are having this as the boilerplate. 
    /* [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
     target:self
     action:@selector(share)];
     */
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        
        Reachability *r = [Reachability reachabilityWithHostName:@"http://"];
        /** Reachability checks for internet and if it fails, we send up a view controller  */
        
        NetworkStatus internetStatus = [r currentReachabilityStatus];
        // code for Portrait orientation    
        // Make sure that the only time it shows the notification is if it's in portrait. 
        
        
        if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
        {
            UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
            if (types == UIRemoteNotificationTypeNone)  {
                //user has disabled push notifcations. PUNISH THEM. Just kidding. Gently warn them that they've done so. With a button :) 
                [MKInfoPanel showPanelInView:self.view 
                                        type:MKInfoPanelTypeAlert 
                                       title:@"You aren't subscribed to push notifications!" 
                                    subtitle:@"Pretty Please? We send 1 message per week (on average)" 
                                   hideAfter:10  origin:MKInfoPanelOriginBottom];
            }
            [MKInfoPanel showPanelInView:self.view 
                                    type:MKInfoPanelTypeError 
                                   title:@"No Internet Connection" 
                                subtitle:@"Uh-oh! Looks like we've lost Internet connectivity. :(  " 
                               hideAfter:20  
                                  origin:MKInfoPanelOriginBottom];
            
            
            
            
        }
        else 
        {
            //if it's not reachable
            
            [self performSelector:@selector(mostrecentelse) withObject:nil afterDelay:0];
        }
    }
    else {
        //if it's not in portrait mode
        
    }
    
    
    //[self performSelectorInBackground:@selector(toastalert) withObject:nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)mostrecentelse {
    
    UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    if (types == UIRemoteNotificationTypeNone) {
        [MKInfoPanel showPanelInView:self.view 
                                type:MKInfoPanelTypeAlert 
                               title:@"Subscribe to Push Notifications!" 
                            subtitle:@"On average you might recieve 1 a week." 
                           hideAfter:10  origin:MKInfoPanelOriginBottom];

    [self performSelector:@selector(updatealert) withObject:nil afterDelay:10];

    }
    else{ 
    [self performSelector:@selector(updatealert) withObject:nil afterDelay:0];
    }
}

-(void)updatealert {
    if( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft ){
    }
    else if( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight ){
    } 
    else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//url string secret
        NSString *urlString = @"";
        NSString *agentString = @"iFUSD/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) iFUSD/525.27.1 (KHTML, like Gecko) Version/1.2 iOS Client";
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: 
                                        [NSURL URLWithString:urlString]];
        [request setValue:agentString forHTTPHeaderField:@"User-Agent"];
        NSData *data = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil ];
        
        
        NSString *returnData = [[NSString alloc] initWithBytes: [data bytes] length:[data length] encoding: NSUTF8StringEncoding];
        
        
        if (![returnData length] == 0)
            
        {
            NSString *pushrecentex = returnData;
            [[NSUserDefaults standardUserDefaults] setObject:pushrecentex forKey:@"pushexamdata"];            


        }});

        NSString *savedPushexamples = [[NSUserDefaults standardUserDefaults] stringForKey:@"pushexamdata"];
        NSLog(@" saved: %@", savedPushexamples);   
        if(![savedPushexamples length] == 0){
            [MKInfoPanel showPanelInView:self.view 
                                    type:MKInfoPanelTypeInfo 
                                   title:@"Latest Push Notification:" 
                                subtitle:savedPushexamples
                               hideAfter:10  
                                  origin:MKInfoPanelOriginBottom];
        }
        else {
            [MKInfoPanel showPanelInView:self.view 
                                    type:MKInfoPanelTypeInfo 
                                   title:@"Example Push Notification:" 
                                subtitle:@"Parent-Teacher conferences on 11/17/11. Starts at 4PM"
                               hideAfter:10  
                                  origin:MKInfoPanelOriginBottom];
            
        }

    }
        
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:@"StatusHide"];
    [defaults registerDefaults:appDefaults];
    [defaults synchronize];
    
    //it may say statushide but its really for Shaking. 
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        
        BOOL enabled = [defaults boolForKey:@"StatusHide"];
        
        if (enabled) {

            UINavigationController *navController = self.navigationController;
            
            [[self retain] autorelease];
            HomeViewController *home = [[HomeViewController alloc]init];
            home.title =@"Fremont Unified";

            [navController popViewControllerAnimated:YES];
            
            [home release];
            
            
        }
        else {
            NSLog(@"NoOrientation");
            
            
        }
        
        
        
        
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
  //  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    
}
/*
-(void)showsmallnotification
{
   [notificationView showAnimated];
}
 */
-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];

    [super viewWillDisappear:animated];
}

-(IBAction)push{

    PushSchoolsViewController *q1 = [[[PushSchoolsViewController alloc] initWithNibName:nil bundle:nil]autorelease];
	
	[self presentModalViewController:q1 animated:YES];
    

}
-(IBAction)share{
    UserGuideViewController *user = [[[UserGuideViewController alloc] initWithNibName:nil bundle:nil]autorelease];
    [self.navigationController pushViewController:user animated:YES];
    

}

-(IBAction)about{
    AboutViewController *about = [[[AboutViewController alloc] initWithNibName:nil bundle:nil]autorelease];
    [self.navigationController pushViewController:about animated:YES];
    
    
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
   // return NO;

}

@end

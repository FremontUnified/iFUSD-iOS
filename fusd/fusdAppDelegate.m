//
//  fusdAppDelegate.m
//  fusd
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//
//

@implementation UINavigationBar (CustomImage)
+ (UIColor*)barcolor {  
    return [UIColor colorWithRed:17.0f/255.0f green:154.0f/255.0f blue:225.0f/255.0f alpha:0.8f];  
}

- (void)drawRect:(CGRect)rect {
    UIColor *color = [UINavigationBar barcolor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {      
        UIImage *img = [UIImage imageNamed: @"FUSDBariPad.png"];
        [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.tintColor = color;
    } else {
        UIImage *img = [UIImage imageNamed: @"FUSDBar.png"];
        [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.tintColor = color;
    }

    
}

@end




#import "fusdAppDelegate.h"
#import "HomeViewController.h"
#import "iRate.h"
#import "Reachability.h"
#import "FlurryAnalytics.h"
#import "errorViewController.h"
#import "RNCachingURLProtocol.h"

@implementation fusdAppDelegate

@synthesize window=_window;

+ (void)initialize
{
    /**  For the rating system */

	[iRate sharedInstance].appStoreID = 454673943;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    navController = [[UINavigationController alloc]init];
    //needed for ios 5 tinting of header bar
    if ([[UINavigationBar class]respondsToSelector:@selector(appearance)]) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {      
            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed: @"FUSDBariPad.png"] forBarMetrics:UIBarMetricsDefault];
            [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:17.0f/255.0f green:154.0f/255.0f blue:225.0f/255.0f alpha:0.8f]]; 
        } else {
            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed: @"FUSDBar.png"] forBarMetrics:UIBarMetricsDefault];
            [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:17.0f/255.0f green:154.0f/255.0f blue:225.0f/255.0f alpha:0.8f]]; 
        }

    }



    [self.window addSubview:navController.view];
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];

    HomeViewController *home = [[HomeViewController alloc]init];

   // [[[self home] view] setFrame:[[UIScreen mainScreen] applicationFrame]];
     [[home view] setFrame:[[UIScreen mainScreen] applicationFrame]];

    [navController pushViewController:home animated:NO];
    UIBarButtonItem *backb = [[UIBarButtonItem alloc]initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    ///change this to change the Navigation Bars Text
    
    /** Change the home.title text to change the header view  */

    home.title =@"Fremont Unified";
    home.navigationItem.backBarButtonItem = backb;

    
    [home release];
    
    ///check for internet 
    //will fail
    //     Reachability *r = [Reachability reachabilityWithHostName:@"r"];

    // will work

    Reachability *r = [Reachability reachabilityWithHostName:@"ifusd.fremontunified.org"];
    /** Reachability checks for internet and if it fails, we send up a view controller  */

	NetworkStatus internetStatus = [r currentReachabilityStatus];
	
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
	{
        UIViewController *error = [[[errorViewController alloc] init] autorelease];
         [navController presentModalViewController:error animated:YES];
        ///we failed so send them to the error page

	}
    else 
    {
    }
    // Add registration for remote notifications
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    /** Pushnotifications  */

	// Clear application badge when app launches
	application.applicationIconBadgeNumber = 0;
        //flurryAPI gives us stats that Google Analytics doesnt, keeping it in for a while
       // [FlurryAnalytics startSession:@"KEY"];

    

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:@"StatusHide"];
    [defaults registerDefaults:appDefaults];
    // default value for shake to go home is YES
    [defaults synchronize];

    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

/* 
 * --------------------------------------------------------------------------------------------------------------
 *  BEGIN APNS CODE 
 * --------------------------------------------------------------------------------------------------------------
 */

/**
 * Fetch and Format Device Token and Register Important Information to Remote Server
 */


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	
    
#if !TARGET_IPHONE_SIMULATOR
    
    /*
	// Get Bundle Info for Remote Registration (handy if you have more than one app)
	NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	
	// Check what Notifications the user has turned on.  We registered for all three, but they may have manually disabled some or all of them.
	NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
	
	// Set the defaults to disabled unless we find otherwise...
	NSString *pushBadge = (rntypes & UIRemoteNotificationTypeBadge) ? @"enabled" : @"disabled";
	NSString *pushAlert = (rntypes & UIRemoteNotificationTypeAlert) ? @"enabled" : @"disabled";
	NSString *pushSound = (rntypes & UIRemoteNotificationTypeSound) ? @"enabled" : @"disabled";	
	
    
	// Get the users Device Model, Display Name, Unique ID, Token & Version Number
	UIDevice *dev = [UIDevice currentDevice];
	NSString *deviceUuid;
	if ([dev respondsToSelector:@selector(uniqueIdentifier)])
		deviceUuid = dev.uniqueIdentifier;
	else {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		id uuid = [defaults objectForKey:@"deviceUuid"];
		if (uuid)
			deviceUuid = (NSString *)uuid;
		else {
			CFStringRef cfUuid = CFUUIDCreateString(NULL, CFUUIDCreate(NULL));
			deviceUuid = (NSString *)cfUuid;
			CFRelease(cfUuid);
			[defaults setObject:deviceUuid forKey:@"deviceUuid"];
            NSLog(@"cfuid");
		}
	}

    

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    NSString *testValue = @"No Schools";
    NSDictionary *appDefaults = [[NSDictionary alloc] initWithObjectsAndKeys:testValue, @"notifz", nil ];
    [defaults registerDefaults:appDefaults]; 

   
    NSString *test =  [[NSUserDefaults standardUserDefaults] stringForKey:@"notifz"];
    NSLog(@"%@",test);
    NSString *deviceName = test;
    NSLog(@"DEVICEZONE Name: %@",deviceName);


    NSString *realdeviceName = [dev.name stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	NSString *model = [dev.model stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];

    NSString *deviceModel = [(NSMutableString*)model stringByAppendingString:realdeviceName];
    NSString *deviceSystemVersion =  dev.systemVersion;
	
	// Prepare the Device Token for Registration (remove spaces and < >)
	NSString *deviceToken = [[[[devToken description] 
                               stringByReplacingOccurrencesOfString:@"<"withString:@""] 
                              stringByReplacingOccurrencesOfString:@">" withString:@""] 
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSString *devytoken = deviceToken;
  
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    {
        [standardUserDefaults setObject:devytoken forKey:@"token"];

        [standardUserDefaults synchronize];

    }


	// Build URL String for Registration
	// !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
	// !!! SAMPLE: "secure.awesomeapp.com"
	// NSString *host = @"www.mywebsite.com";
    /** Push Server URL here  */

	// !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
	// !!! ( MUST START WITH / AND END WITH ? ). 
	// !!! SAMPLE: "/path/to/apns.php?"
    //devicename is really zone
	// NSString *urlString = [NSString stringWithFormat:@"/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, deviceToken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
	
/*
    
	// !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
	NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString ];
    //could use path:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] but it wouldn't change all that much
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"Register URL: %@", url);
    NSLog(@"Return Data: %@", returnData);
 */
    
#endif
    
}

/**
 * Failed to Register for Remote Notifications
 */
/*
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
#if !TARGET_IPHONE_SIMULATOR

	
	NSLog(@"Error in registration. Error: %@", error);
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Push Notification Registration Failed" message:@"Uh oh! Looks like we couldn't register you for push notifications. We use push notifications to deliver important updates about the schools you subscribe to within the application. If you want Push Notifications, they must be enabled for our app. If you would receive Push Notification, go into your Device Settings, go to Notifications and then click on our App. If you still get this message, you should submit a bug report (Click OK, and then on Settings)! " delegate:self cancelButtonTitle:@"\ue00e OK" otherButtonTitles:nil];
    
    [alertView show];
    
    [alertView release];
#endif
    
}
 */
/**
 * Remote Notification Received while application was open.
 */

/*
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	
#if !TARGET_IPHONE_SIMULATOR
    
	NSLog(@"remote notification: %@",[userInfo description]);
	NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
	
	NSString *alert = [apsInfo objectForKey:@"alert"];
	NSLog(@"Received Push Alert: %@", alert);
	
	NSString *sound = [apsInfo objectForKey:@"sound"];
	NSLog(@"Received Push Sound: %@", sound);
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	
	NSString *badge = [apsInfo objectForKey:@"badge"];
	NSLog(@"Received Push Badge: %@", badge);
	application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
	
#endif
}
*/

/* 
 * --------------------------------------------------------------------------------------------------------------
 *  END APNS CODE 
 * --------------------------------------------------------------------------------------------------------------
 */
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end

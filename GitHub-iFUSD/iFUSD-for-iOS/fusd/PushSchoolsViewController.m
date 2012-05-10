//
//  PushSchoolsViewController.m
//  fusd
//
//  Created by Sumukh Sridhara on 7/9/11.
//  Copyright 2011 Sumukh Sridhara. All rights reserved.
//

#import "PushSchoolsViewController.h"
#import "HomeViewController.h"
#import "SettingViewController.h"
#import "FlurryAPI.h"
//#import "MKInfoPanel.h"
//#import "WToast.h"
#import "GCDiscreetNotificationView.h"
#import "SVProgressHUD.h"

@implementation PushSchoolsViewController
@synthesize notificationView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
- (void)viewDidLoad {
    NSString *uid = [UIDevice currentDevice].uniqueIdentifier;


    [FlurryAPI logEvent:@"Did Look At Device Area"];
    //table of contents
    arryHewlettPackard = [[NSArray alloc] initWithObjects:@"Attendance Areas",@"School District",@"High Schools",@"Junior High Schools",@"Elementary Schools",@"Other Settings",nil];


    arryAppleProducts = [[NSArray alloc] initWithObjects:@"American High",@"Irvington High",@"Kennedy High",@"Mission San Jose High",@"Robertson High",@"Washington High",nil];

	arryAdobeSoftwares = [[NSArray alloc] initWithObjects:@"Centerville Junior",@"Hopkins Junior",@"Horner Junior",@"Thornton Junior",@"Walters Junior",nil];
    //note that all schools MUST be the exact Same as the all shcools in Other Settings
    arrySchoolwires = [[NSArray alloc] initWithObjects:@"District Office",@"All Schools",nil];

    
	arryMicrosoft = [[NSArray alloc] initWithObjects:
                     
                    @"Ardenwood Elementary",
                    @"Azevada Elementary",
                     
                    @"Blacow Elementary",
                    @"Brier Elementary",
                    @"Brookvale Elementary",
                     
                     @"Cabrillo Elementary",
                     @"Chadbourne Elementary",                     
                     @"Durham Elementary",
                     @"Forest Park Elementary",
                    @"Glenmoor Elementary",
                     @"Gomes Elementary",
                     
                     @"Green Elementary",
                     @"Grimmer Elementary",
                     
                     @"Hirsch Elementary",
                     
                     @"Leitch Elementary",
                     
                    @"Maloney Elementary",
                     @"Mattos Elementary",
                     @"Millard Elementary",
                    @"Mission San Jose Elementary",
                     @"Mission Valley Elementary",
                     
                    @"Niles Elementary",
                     
                     @"Oliveira Elementary",
                     
                     @"Parkmont Elementary",
                     @"Patterson Elementary",
                     
                     @"Vallejo Mill Elementary",
                     
                    @"Warm Springs Elementary",
                     @"Warwick Elementary",
                    @" Weibel Elementary",nil];
    
    
    
    
    
    
    arryCisco = [[NSArray alloc] initWithObjects:@"American Attendance Area",@"Irvington Attendance Area",@"Kennedy Attendance Area",@"Mission San Jose Area",@"Washington Attendance Area",nil];
  
    arryGoogle = [[NSArray alloc] initWithObjects:@"Subscribe to All Schools",@"No Push Notifications",nil];

    NSString *url = @"http://ifusd.fremontunified.org/fusdpush/status/status.php?uid=";
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[(NSMutableString*)url stringByAppendingString:uid]]]];
  
    webView.backgroundColor = [UIColor groupTableViewBackgroundColor];

   [webView setOpaque:NO];
    
    //self.backgroundColor=[UIColor scrollViewTexturedBackgroundColor  ];
    
    //scrollViewTexturedBackgroundColor
    //webview needs a background so we are having this as the boilerplate. 
    //webView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"loading.png"]];

    [super viewDidLoad];



}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    

}

-(IBAction)close {
    
    [self dismissModalViewControllerAnimated:YES];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:@"StatusHide"];
    [defaults registerDefaults:appDefaults];
    [defaults synchronize];
    //it may say statushide , but its really for Shaking. 
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        
        BOOL enabled = [defaults boolForKey:@"StatusHide"];
        
        if (enabled) {
            
           [[self retain] autorelease];
            [self dismissModalViewControllerAnimated:YES];
           // [navController popToViewController:home animated:YES];          
        
            
        }
        else {
            NSLog(@"NoOrientation");
            
            
        }
        
        
        
        
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];

    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
		return [arryHewlettPackard count];
    
	else if(section == 2)
		return [arrySchoolwires count];
    else if(section == 1)
		return [arryCisco count];


	else if(section == 3)
		return [arryAppleProducts count];
	else if(section== 4)
		return [arryAdobeSoftwares count];
    else if(section== 5)
        return [arryMicrosoft count];
    else if(section== 6)
        return [arryGoogle count];


    return 0;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"Table of Contents";

        }
    
    else if(section== 2){
        return @"School District";
    }
    else if(section == 1)
    {
		return @"Attendance Areas";
    }
            else if(section == 3)
         {
		return @"High Schools";
	     }	else if(section== 4){
		return @"Junior High Schools";
	     }
            else if(section== 5){
        return @"Elementary Schools";
        }
            else if(section== 6){
        return @"Other Settings";
        }
    return 0;


}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	if(section == 0){
		return @"";
    } else if (section == 1){
		return @"Choose an Attendance Area if you want notifications for more than one school in that area. Otherwise, select a school from the list below. \ue233";
    }else if (section == 3){
        return @"";
    }else if (section == 4){
        return @"";
    }else if (section == 5){
        return @"";
    }else if (section == 6){
        return @"";
    }return 0;

}

#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    if(indexPath.section == 0){
		cell.textLabel.text = [arryHewlettPackard objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = UITextAlignmentCenter;

    }

   else if(indexPath.section == 1){
		cell.textLabel.text = [arryCisco objectAtIndex:indexPath.row];
       cell.textLabel.textAlignment = UITextAlignmentLeft;
    }
   else if(indexPath.section == 2){
       cell.textLabel.text = [arrySchoolwires objectAtIndex:indexPath.row];
       cell.textLabel.textAlignment = UITextAlignmentLeft;
       
   }

	else if(indexPath.section == 3){
	cell.textLabel.text = [arryAppleProducts objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        

	}else if (indexPath.section ==4){
		cell.textLabel.text = [arryAdobeSoftwares objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = UITextAlignmentLeft;

    }
    else if (indexPath.section == 5){
        cell.textLabel.text = [arryMicrosoft objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = UITextAlignmentLeft;


    }
    else if(indexPath.section == 6){
		cell.textLabel.text = [arryGoogle objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
    }

    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *dtoken = [[NSUserDefaults standardUserDefaults]stringForKey:@"token"];
	//NSLog(@"%@",dtoken);


    
    // Get Bundle Info for Remote Registration (handy if you have more than one app)
	
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	
	// Check what Notifications the user has turned on.  We registered for all three, but they may have manually disabled some or all of them.
	NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
	
	// Set the defaults to disabled unless we find otherwise...
	NSString *pushBadge = (rntypes & UIRemoteNotificationTypeBadge) ? @"enabled" : @"disabled";
	NSString *pushAlert = (rntypes & UIRemoteNotificationTypeAlert) ? @"enabled" : @"disabled";
	NSString *pushSound = (rntypes & UIRemoteNotificationTypeSound) ? @"enabled" : @"disabled";	
	//NSLog(@"%@",pushAlert);
	// Get the users Device Model, Display Name, Unique ID, Token & Version Number
	UIDevice *dev = [UIDevice currentDevice];
	NSString *deviceUuid = dev.uniqueIdentifier;
    
    NSString *realdeviceName = [dev.name stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	NSString *model = [dev.model stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSString *deviceModel = [(NSMutableString*)model stringByAppendingString:realdeviceName];
    NSString *deviceSystemVersion =  dev.systemVersion;

    if (indexPath.section == 0) {
        NSString *tapped = [arryHewlettPackard objectAtIndex:indexPath.row];
        //    arryHewlettPackard = [[NSArray alloc] initWithObjects:@"Attendance Areas",@"School District",@"High Schools",@"Junior High Schools",@"Elementary Schools",@"Other Settings",nil];

        if (tapped == @"Attendance Areas") {
            NSIndexPath *someRow = [NSIndexPath indexPathForRow:0 inSection: 1];
            [tableView reloadData];
            [tableView scrollToRowAtIndexPath: someRow atScrollPosition: UITableViewScrollPositionTop animated: YES];
        }
        else if (tapped == @"School District") {
            NSIndexPath *someRow = [NSIndexPath indexPathForRow:0 inSection: 2];
            [tableView reloadData];
            [tableView scrollToRowAtIndexPath: someRow atScrollPosition: UITableViewScrollPositionTop animated: YES];
        }
        else if (tapped == @"High Schools") {
            NSIndexPath *someRow = [NSIndexPath indexPathForRow:0 inSection: 3];
            [tableView reloadData];
            [tableView scrollToRowAtIndexPath: someRow atScrollPosition: UITableViewScrollPositionTop animated: YES];
        }
        else if (tapped == @"Junior High Schools") {
            NSIndexPath *someRow = [NSIndexPath indexPathForRow:0 inSection: 4];
            [tableView reloadData];
            [tableView scrollToRowAtIndexPath: someRow atScrollPosition: UITableViewScrollPositionTop animated: YES];
        }
        else if (tapped == @"Elementary Schools") {
            NSIndexPath *someRow = [NSIndexPath indexPathForRow:0 inSection: 5];
            [tableView reloadData];
            [tableView scrollToRowAtIndexPath: someRow atScrollPosition: UITableViewScrollPositionTop animated: YES];
        }
        else if (tapped == @"Other Settings") {
            NSIndexPath *someRow = [NSIndexPath indexPathForRow:27 inSection: 5];
            [tableView reloadData];
            [tableView scrollToRowAtIndexPath: someRow atScrollPosition: UITableViewScrollPositionTop animated: YES];
        }





    }

    else if(indexPath.section == 1)
    {
        [SVProgressHUD show];
        NSString *deviceName = [arryCisco objectAtIndex:indexPath.row];
        //   NSLog(@"REGISTERINGTOSCHOOL:%@", deviceName);
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
        //store the old value for the push so we can undo
        NSString *oldvalue = [defaults stringForKey:@"notifz"];
        [defaults setObject:oldvalue forKey:@"pushrestorepoint"];
        NSLog(@"Old Value Recording as:%@",oldvalue);
        //set the new point to push   
        NSString *testValue = deviceName;
        
        [[[NSDictionary alloc] initWithObjectsAndKeys:testValue,@"notifz", nil ]autorelease];
        [defaults setObject:testValue forKey:@"notifz"];
        //NSLog(@"%@",appDefaults);
        
        // Build URL String for Registration
        // !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
        // !!! SAMPLE: "secure.awesomeapp.com"
        NSString *host = @"ifusd.fremontunified.org/fusdpush";
        
        // !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
        // !!! ( MUST START WITH / AND END WITH ? ). 
        // !!! SAMPLE: "/path/to/apns.php?"
        NSString *urlString = [NSString stringWithFormat:@"/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, dtoken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];

        
        // Register the Device Data
        // !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
        NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
        //Checkmarks don't work yet.
    //    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];

        

        //NSLog(@"Register URL: %@", url);
        //  NSLog(@"Return Data:%@", returnData);
        NSString *title = [arryCisco objectAtIndex:indexPath.row];
        NSString *alertviewmessage = [NSString stringWithFormat:@"Your are now subscribed to receieve notifications for all schools within the %@.", title];

        //for high schools
        [SVProgressHUD dismiss];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:alertviewmessage delegate:self cancelButtonTitle:@"\ue101 OK" otherButtonTitles:@"Undo",nil];    
        
        [webView reload];
        [alertView show];
        
        [alertView release];
        [url release];
        [request release];        
        
    }
    else if(indexPath.section == 2)
    {
        [SVProgressHUD show];

        NSString *deviceName = [arrySchoolwires objectAtIndex:indexPath.row];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
        //store the old value for the push so we can undo
        NSString *oldvalue = [defaults stringForKey:@"notifz"];
        [defaults setObject:oldvalue forKey:@"pushrestorepoint"];
        NSLog(@"Old Value Recording as:%@",oldvalue);
        //set the new point to push   
        NSString *testValue = deviceName;
        
        [[[NSDictionary alloc] initWithObjectsAndKeys:testValue,@"notifz", nil ]autorelease];
        [defaults setObject:testValue forKey:@"notifz"];
        //NSLog(@"%@",appDefaults);
        
        // Build URL String for Registration
        // !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
        // !!! SAMPLE: "secure.awesomeapp.com"
        NSString *host = @"ifusd.fremontunified.org/fusdpush";
        
        // !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
        // !!! ( MUST START WITH / AND END WITH ? ). 
        // !!! SAMPLE: "/path/to/apns.php?"
        NSString *urlString = [NSString stringWithFormat:@"/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, dtoken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
        
        // Register the Device Data
        // !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
        NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];

        //NSLog(@"Register URL: %@", url);
        //  NSLog(@"Return Data:%@", returnData);
        NSString *title = [arrySchoolwires objectAtIndex:indexPath.row];
        //for high schools
        NSString *alertviewmessage = [NSString stringWithFormat:@"Your device is now configured to recieve notifications for this subscription: %@.", title];
        [SVProgressHUD dismiss];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:alertviewmessage delegate:self cancelButtonTitle:@"\ue101 OK" otherButtonTitles:@"Undo",nil];        
        [webView reload];
        [alertView show];
        
        [alertView release];
        [url release];
        [request release];
    }


	else if(indexPath.section == 3){
        [SVProgressHUD show];

        NSString *deviceName = [arryAppleProducts objectAtIndex:indexPath.row];
        NSLog(@"REGISTERINGTOSCHOOL:%@", deviceName);
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
        //store the old value for the push so we can undo
        NSString *oldvalue = [defaults stringForKey:@"notifz"];
        [defaults setObject:oldvalue forKey:@"pushrestorepoint"];
        NSLog(@"Old Value Recording as:%@",oldvalue);
        //set the new point to push   
        NSString *testValue = deviceName;
        
        [[[NSDictionary alloc] initWithObjectsAndKeys:testValue,@"notifz", nil ]autorelease];
        [defaults setObject:testValue forKey:@"notifz"];
        //NSLog(@"%@",appDefaults);

        // Build URL String for Registration
        // !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
        // !!! SAMPLE: "secure.awesomeapp.com"
        NSString *host = @"ifusd.fremontunified.org/fusdpush";
        
        // !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
        // !!! ( MUST START WITH / AND END WITH ? ). 
        // !!! SAMPLE: "/path/to/apns.php?"
        NSString *urlString = [NSString stringWithFormat:@"/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, dtoken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
        
        // Register the Device Data
        // !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
        NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
      [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];

      NSLog(@"Register URL: %@", url);

        NSString *title = [arryAppleProducts objectAtIndex:indexPath.row];
        //for high schools
        NSString *alertviewmessage = [NSString stringWithFormat:@"You are now subscribed to receive push notifications from %@ School.", title];
        [SVProgressHUD dismiss];

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:alertviewmessage delegate:self cancelButtonTitle:@"\ue101 OK" otherButtonTitles:@"Undo",nil];        
        [webView reload];
        [alertView show];
        
        [alertView release];
        [url release];
        [request release];
        }

        
	else if(indexPath.section == 4)
    {
        [SVProgressHUD show];

        NSString *deviceName = [arryAdobeSoftwares objectAtIndex:indexPath.row];
     //   NSLog(@"REGISTERINGTOSCHOOL:%@", deviceName);
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
        //store the old value for the push so we can undo
        NSString *oldvalue = [defaults stringForKey:@"notifz"];
        [defaults setObject:oldvalue forKey:@"pushrestorepoint"];
        NSLog(@"Old Value Recording as:%@",oldvalue);
        //set the new point to push   
        NSString *testValue = deviceName;
        
        [[[NSDictionary alloc] initWithObjectsAndKeys:testValue,@"notifz", nil ]autorelease];
        [defaults setObject:testValue forKey:@"notifz"];
        //NSLog(@"%@",appDefaults);
        // Build URL String for Registration
        // !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
        // !!! SAMPLE: "secure.awesomeapp.com"
        NSString *host = @"ifusd.fremontunified.org/fusdpush";
        
        // !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
        // !!! ( MUST START WITH / AND END WITH ? ). 
        // !!! SAMPLE: "/path/to/apns.php?"
        NSString *urlString = [NSString stringWithFormat:@"/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, dtoken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
        
        // Register the Device Data
        // !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
        NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
         [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];

        //NSLog(@"Register URL: %@", url);
        //  NSLog(@"Return Data:%@", returnData);
        
      
        
        NSString *title = [arryAdobeSoftwares objectAtIndex:indexPath.row];
        //for junior high schools
        NSString *alertviewmessage = [NSString stringWithFormat:@"You are now subscribed to receive push notifications from %@ High School.", title];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:alertviewmessage delegate:self cancelButtonTitle:@"\ue101 OK" otherButtonTitles:@"Undo",nil];
        [SVProgressHUD dismiss];

        //   [tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        [webView reload];
        [alertView show];
        
        [alertView release];
        [url release];
        [request release];

        


    }
    else if(indexPath.section == 5)
    {
        [SVProgressHUD show];

        NSString *deviceName = [arryMicrosoft objectAtIndex:indexPath.row];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
        //store the old value for the push so we can undo
        NSString *oldvalue = [defaults stringForKey:@"notifz"];
        [defaults setObject:oldvalue forKey:@"pushrestorepoint"];
        NSLog(@"Old Value Recording as:%@",oldvalue);
        //set the new point to push   
        NSString *testValue = deviceName;
        
        [[[NSDictionary alloc] initWithObjectsAndKeys:testValue,@"notifz", nil ]autorelease];
        [defaults setObject:testValue forKey:@"notifz"];
        //NSLog(@"%@",appDefaults);
        
        // Build URL String for Registration
        // !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
        // !!! SAMPLE: "secure.awesomeapp.com"
        NSString *host = @"ifusd.fremontunified.org/fusdpush";
        
        // !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
        // !!! ( MUST START WITH / AND END WITH ? ). 
        // !!! SAMPLE: "/path/to/apns.php?"
        NSString *urlString = [NSString stringWithFormat:@"/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, dtoken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
        
        // Register the Device Data
        // !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
        NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];

        //NSLog(@"Register URL: %@", url);
        //  NSLog(@"Return Data:%@", returnData);
        
        
        NSString *title = [arryMicrosoft objectAtIndex:indexPath.row];
        NSString *alertviewmessage = [NSString stringWithFormat:@"You are now subscribed to receive push notifications from %@.", title];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:alertviewmessage delegate:self cancelButtonTitle:@"\ue101 OK" otherButtonTitles:@"Undo",nil];
        [SVProgressHUD dismiss];

        //   [tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        [webView reload];
        [alertView show];
        
        [alertView release];
        [url release];
        [request release];

    }
    else if(indexPath.section == 6)
    {
        [SVProgressHUD show];

        NSString *deviceName = [arryGoogle objectAtIndex:indexPath.row];

        NSLog(@"NEWREGISTERINGTOSCHOOL:%@", deviceName);
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    //store the old value for the push so we can undo
        NSString *oldvalue = [defaults stringForKey:@"notifz"];
        [defaults setObject:oldvalue forKey:@"pushrestorepoint"];
        NSLog(@"Old Value Recording as:%@",oldvalue);
     //set the new point to push   
        NSString *testValue = deviceName;

        [[[NSDictionary alloc] initWithObjectsAndKeys:testValue,@"notifz", nil ]autorelease];
        [defaults setObject:testValue forKey:@"notifz"];
        //NSLog(@"%@",appDefaults);
        
        // Build URL String for Registration
        // !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
        // !!! SAMPLE: "secure.awesomeapp.com"
        NSString *host = @"ifusd.fremontunified.org/fusdpush";
        
        // !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
        // !!! ( MUST START WITH / AND END WITH ? ). 
        // !!! SAMPLE: "/path/to/apns.php?"
        NSString *urlString = [NSString stringWithFormat:@"/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, dtoken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
        
        // Register the Device Data
        // !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
        NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
        //NSLog(@"Register URL: %@", url);
        //  NSLog(@"Return Data:%@", returnData);
        
        NSString *title = [arryGoogle objectAtIndex:indexPath.row];
        if (deviceName == @"No Push Notifications") {
            NSString *alertviewmessage = [NSString stringWithFormat:@"Your subscription has been updated to reflect this change. To completely stop from recieving any notifications, go to your Device Settings and Tap on Notifications."];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:alertviewmessage delegate:self cancelButtonTitle:@"\ue101 OK" otherButtonTitles:@"Undo",nil];
            [SVProgressHUD dismiss];

            //   [tableView setContentOffset:CGPointMake(0, 0) animated:YES];
            
            [webView reload];
            [alertView show];
            
            [alertView release];
            
            
        }
        else{ 
            
        NSString *alertviewmessage = [NSString stringWithFormat:@"Your device is now configured for this subscription: %@.", title];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:alertviewmessage delegate:self cancelButtonTitle:@"\ue101 OK" otherButtonTitles:@"Undo",nil];
            [SVProgressHUD dismiss];

        //   [tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        [webView reload];
        [alertView show];
        
        [alertView release];
        }
        [url release];
        [request release];

        
    }
    



}
-(IBAction)scrolltotop {

    [tblSimpleTable setContentOffset:CGPointMake(0, 0) animated:YES];


}
-(void)dismiss 
{
    [self dismissModalViewControllerAnimated:YES];
}



- (void)alertView:(UIAlertView *)alertView  clickedButtonAtIndex:(NSInteger)buttonIndex {
	//Relying on an UIAlertView from the undo alertview. Going for a graceful notificaion instead
    if ([alertView tag] == 2) {
        if (buttonIndex == 1) {
        [self dismissModalViewControllerAnimated:YES];
            [SVProgressHUD show];

            [SVProgressHUD dismissWithSuccess:@"Updated!"];

        }
    }
    else 
    { if (buttonIndex == 0)
    {
       // NSLog(@"The User Likes it");
     //don't need to scroll to the top   [tblSimpleTable setContentOffset:CGPointMake(0, 0) animated:YES];
       //don't need to delay the dimissal. [NSTimer scheduledTimerWithTimeInterval:0.0  target:self    selector:@selector(dismiss)  userInfo:nil repeats:NO];
        [SVProgressHUD show];
        [self dismissModalViewControllerAnimated:YES];
        [SVProgressHUD dismissWithSuccess:@"Updated!"];


    }
    else
    {
        [SVProgressHUD show];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
        //start the process to restore them back to their original point
        
        NSString *dtoken = [[NSUserDefaults standardUserDefaults]stringForKey:@"token"];
        //NSLog(@"%@",dtoken);
        
        
        
        // Get Bundle Info for Remote Registration (handy if you have more than one app)
        
        NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        // Check what Notifications the user has turned on.  We registered for all three, but they may have manually disabled some or all of them.
        NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        
        // Set the defaults to disabled unless we find otherwise...
        NSString *pushBadge = (rntypes & UIRemoteNotificationTypeBadge) ? @"enabled" : @"disabled";
        NSString *pushAlert = (rntypes & UIRemoteNotificationTypeAlert) ? @"enabled" : @"disabled";
        NSString *pushSound = (rntypes & UIRemoteNotificationTypeSound) ? @"enabled" : @"disabled";	
        //NSLog(@"%@",pushAlert);
        // Get the users Device Model, Display Name, Unique ID, Token & Version Number
        UIDevice *dev = [UIDevice currentDevice];
        NSString *deviceUuid = dev.uniqueIdentifier;
        
        NSString *realdeviceName = [dev.name stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *model = [dev.model stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        NSString *deviceModel = [(NSMutableString*)model stringByAppendingString:realdeviceName];
        NSString *deviceSystemVersion =  dev.systemVersion;
//start the process to get them back to their old point
        NSString *deviceName = [defaults stringForKey:@"pushrestorepoint"];
        NSString *zonename = deviceName;
        NSLog(@"Old Zone:%@.",zonename);
        // Build URL String for Registration
        // !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
        // !!! SAMPLE: "secure.awesomeapp.com"
        NSString *host = @"ifusd.fremontunified.org/fusdpush";
        
        // !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
        // !!! ( MUST START WITH / AND END WITH ? ). 
        // !!! SAMPLE: "/path/to/apns.php?"
        NSString *urlString = [NSString stringWithFormat:@"/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, dtoken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
        
        // Register the Device Data
        // !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
        NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSLog(@"%@",zonename);
        [[[NSDictionary alloc] initWithObjectsAndKeys:zonename,@"notifz", nil ]autorelease];
        [defaults setObject:zonename forKey:@"notifz"];
        NSLog(@"NOTIFZ to %@",[defaults stringForKey:@"notifz"]);

        //THE FOLLOWING CODE HAS A BUNCH OF STUFF TO TRIGGER ANOTHER UIALERT. INSTEAD I WILL JUST DO A HUD POPUP
        
        [SVProgressHUD dismissWithSuccess:@"Reverted!"];

        
//       NSString *alertviewmessage = [NSString stringWithFormat:@"Succesfully reverted to: %@. To subscribe to a new zone, simply select it from the list.",zonename];
        //NSString *string = [NSString stringWithFormat:@"Reverted to:"];
        [webView reload];

        // [WToast showWithText:string];

  //       UIAlertView* redoview = [[UIAlertView alloc] initWithTitle:zonename message:alertviewmessage delegate:self cancelButtonTitle:@"\ue101 OK" otherButtonTitles:@"Done",nil];


    //   [redoview show];
     //   redoview.tag = 2;

       // [redoview release];
        /*
        [MKInfoPanel showPanelInView:self.view
                                type:MKInfoPanelTypeInfo
                               title:zonename
                            subtitle:@"Reverted back to previous subscription."
                           hideAfter:4];

        notificationView = 
        [[GCDiscreetNotificationView alloc] initWithText:string showActivity:NO  inPresentationMode:GCDiscreetNotificationViewPresentationModeBottom inView:self.view];
        [notificationView hideAnimatedAfter:5];
        [notificationView showAnimated];*/

        [url release];
        [request release];
    }

    }

    
}



@end

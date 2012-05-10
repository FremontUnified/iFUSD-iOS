//
//  AboutViewController.m
//  fusd
//
//  Created by Sumukh Sridhara on 7/12/11.
//  Copyright 2011 Sumukh Sridhara. All rights reserved.
//

#import "AboutViewController.h"
#import "HomeViewController.h"
#import "SettingViewController.h"
#import "FlurryAnalytics.h"

@implementation AboutViewController

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
            
            UINavigationController *navController = self.navigationController;
            
            [[self retain] autorelease];
            HomeViewController *home = [[HomeViewController alloc]init];
            [navController popToRootViewControllerAnimated:YES];          
            
            
            [home release];
            
            
        }
        else {
            NSLog(@"NoOrientation");
            
            
        }
        
        
        
        
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}
-(BOOL)canBecomeFirstResponder {
    return YES;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self setTitle: @"About"];
    // loading from district:

  //Loading from Sumukh's site 
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http:// /about/"]]];  
   // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http:// / /about/"]]];
    [super viewDidLoad];
    [webView setOpaque:NO];
    webView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:222.0f/255.0f blue:225.0f/255.0f alpha:0.8f];
    ///groupTableViewBackgroundColor
    //webview needs a background so we are having this as the boilerplate.  NOPE
   // webView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"loading.png"]];
    self.navigationItem.rightBarButtonItem =  [ [UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                               action:@selector(done)];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [FlurryAnalytics logEvent:@"Did Look At About Page"];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
    [(UISwipeGestureRecognizer *)swipeRight setNumberOfTouchesRequired:2];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    swipeRight.delegate = self;
    [webView addGestureRecognizer:swipeRight];
    [swipeRight release];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    [(UISwipeGestureRecognizer *)swipeLeft setNumberOfTouchesRequired:2];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeLeft.delegate = self;
    [webView addGestureRecognizer:swipeLeft];
    [swipeLeft release];

}
-(IBAction)done {
    UINavigationController *navController = self.navigationController;
    
    [navController popToRootViewControllerAnimated:YES];          
}
- (void)swipeRightAction:(id)ignored
{
    NSLog(@"Swipe Right");
    [webView goForward];
    
    //add Function
}
- (void)swipeLeftAction:(id)ignored
{
    NSLog(@"Swipe Left");
    [webView goBack];
    //add Function
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@" Error %@",error);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"About" message:@"We couldn't connect to the server. Please check your network connection.  Here is some basic info about the application: iFUSD for iOS was created for the Fremont Unified School District. The application was helped along through a team consisting of District employees, involved parents, and students from a local high school. The application was developed by a local high school student and was created to connect the community with the FUSD. Please check that your internet connection is functioning to regain access" 
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];

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
    return YES;
}

@end

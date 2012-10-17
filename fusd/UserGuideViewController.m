//
//  UserGuideViewController.m
//  fusd
//
//  Created by Sumukh Sridhara on 7/11/11.
//  Copyright 2011 Sumukh Sridhara. All rights reserved.
//

#import "UserGuideViewController.h"
#import "HomeViewController.h"
#import "SettingViewController.h"

@implementation UserGuideViewController

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
    [self setTitle: @"User Guide"];

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ifusd.fremontunified.org/fusdweb/userguide/"]]];
    [super viewDidLoad];
    [webView setOpaque:NO];
    // webView.backgroundColor=[UIColor scrollViewTexturedBackgroundColor  ];
    ///groupTableViewBackgroundColor
    //webview needs a background so we are having this as the boilerplate. 
    webView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"loading.png"]];
    self.navigationItem.rightBarButtonItem =  [ [UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                action:@selector(done)];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

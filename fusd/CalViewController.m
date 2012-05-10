//
//  CalViewController.m
//  fusdbeta
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//

#import "CalViewController.h"
#import "HomeViewController.h"

@implementation CalViewController

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
    [webView release];
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

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"  /cal/"]]];
    webView.delegate = self;
    [webView setOpaque:NO];
  //  webView.backgroundColor=[UIColor scrollViewTexturedBackgroundColor  ];
    ///groupTableViewBackgroundColor
  webView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"loading.png"]];

    [super viewDidLoad];
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
    
    // Do any additional setup after loading the view from its nib.
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:@"StatusHide"];
    [defaults registerDefaults:appDefaults];
    [defaults synchronize];

    if ( event.subtype == UIEventSubtypeMotionShake )
    {
      
        BOOL enabled = [defaults boolForKey:@"StatusHide"];
        
        if (enabled) {

            UINavigationController *navController = self.navigationController;
            
            [[self retain] autorelease];
            HomeViewController *home = [[HomeViewController alloc]init];
            [navController popViewControllerAnimated:YES];
            
            home.title =@"Fremont Unified";
            [home release];
        //    [HomeViewController release];

            
            
        }
        else {
            NSLog(@"NoOrientation");
            
            
        }

        
    

    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    
}


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
    webView.delegate = nil;

}

-(IBAction)home{
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"  /cal/"]]];
    
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

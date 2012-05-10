//
//  EmergencyViewController.m
//  fusdbeta
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//

#import "EmergencyViewController.h"
#import "HomeViewController.h"

@implementation EmergencyViewController
@synthesize navigationBarItem;

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
    
    
    // Do any additional setup after loading the view from its nib.
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    webView.delegate = self;
    [webView setOpaque:NO];

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"  /em/"]]];
   //  webView.backgroundColor=[UIColor scrollViewTexturedBackgroundColor  ];
    ///groupTableViewBackgroundColor
    //webview needs a background so we are having this as the boilerplate. 
   webView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"loading.png"]];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    navigationBarItem = [[DAReloadActivityButton alloc] init];
    navigationBarItem.showsTouchWhenHighlighted = NO;
    [navigationBarItem addTarget:self action:@selector(animate:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navigationBarItem];
    self.navigationItem.rightBarButtonItem = barButtonItem;


}

//tookawayswipe gestures for EM
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



- (void)animate:(DAReloadActivityButton *)button
{
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"  /em/"]]];

[button spin];
    
}

- (void)stop:(DAReloadActivityButton *)button {
    
    [button stopAnimating];

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
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"  /em/"]]];
    
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

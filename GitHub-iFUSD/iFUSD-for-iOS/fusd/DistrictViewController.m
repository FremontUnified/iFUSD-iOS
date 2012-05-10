//
//  DistrictViewController.m
//  fusdbeta
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//

#import "DistrictViewController.h"
#import "HomeViewController.h"

@implementation DistrictViewController
@synthesize urlObject;

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
    [docController release];
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
    
    //URLOBJECT IS BEING CALLED FROM THE HOMENAVIGATION
    [webView loadRequest:[NSURLRequest requestWithURL:urlObject]];
    webView.delegate = self;
    [webView setOpaque:NO];
    //  webView.backgroundColor=[UIColor scrollViewTexturedBackgroundColor  ];
    ///groupTableViewBackgroundColor
    //webview needs a background so we are having this as the boilerplate. 
    [webView setBackgroundColor:[UIColor clearColor]];
    
    //get rid of the shadows behind a webview. 
    
    /*
    for (UIView* subView in [webView subviews])
    {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView* shadowView in [subView subviews])
            {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    [shadowView setHidden:YES];
                }
            }
        }
    }
     */

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
    //it may say statushide , but its really for Shaking. 
    if ( event.subtype == UIEventSubtypeMotionShake && !isRotating )
    {
       //check our NSUserDefaults to make sure they've enabled Shake to Home 
        BOOL enabled = [defaults boolForKey:@"StatusHide"];
        
        if (enabled) {
            
            UINavigationController *navController = self.navigationController;
            
            [[self retain] autorelease];

            HomeViewController *home = [[HomeViewController alloc]init];
//send them back here
             [[home view] setFrame:[[UIScreen mainScreen] applicationFrame]];
            [navController popViewControllerAnimated:YES];
            // can delete the following like of code
            home.title =@"Fremont Unified";
            [home release];
            
            
        }
        else {
            NSLog(@"NoOrientation");
            
            
        }
        
        
        
        
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

/**
 Just a small helper function
 that returns the path to our 
 Documents directory
 **/

- (NSString *)documentsDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return documentsDirectoryPath;
}

-(void)documenthandler {
    // Get the URL of the loaded ressource
    NSURL *theRessourcesURL = [[webView request] URL];
    NSString *fileExtension = [theRessourcesURL pathExtension];
    
    if ([fileExtension isEqualToString:@"pdf"] || [fileExtension isEqualToString:@"doc"]) {
        // Get the filename of the loaded ressource form the UIWebView's request URL
        NSString *filename = [theRessourcesURL lastPathComponent];
        NSLog(@"Filename: %@", filename);
        // Get the path to the App's Documents directory
        NSString *docPath = [self documentsDirectoryPath];
        // Combine the filename and the path to the documents dir into the full path
        NSString *pathToDownloadTo = [NSString stringWithFormat:@"%@/%@", docPath, filename];
        NSURL *fileURl = [NSURL fileURLWithPath:pathToDownloadTo];
        NSLog(@"Path: %@", pathToDownloadTo);
        
        // Load the file from the remote server
        NSData *tmp = [NSData dataWithContentsOfURL:theRessourcesURL];
        // Save the loaded data if loaded successfully
        if (tmp != nil) {
            NSError *error = nil;
            // Write the contents of our tmp object into a file
            [tmp writeToFile:pathToDownloadTo options:NSDataWritingAtomic error:&error];
            if (error != nil) {
                NSLog(@"Failed to save the file: %@", [error description]);
            } else {

                docController = [UIDocumentInteractionController interactionControllerWithURL:fileURl];
                docController.delegate = self;
                [docController retain];
                UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
                self.navigationItem.rightBarButtonItem = homeButton;
                
                [docController presentOptionsMenuFromBarButtonItem:homeButton animated:YES];
                [homeButton release];
                
                //pdf dialog will not show on simulator since there aren't pdf recongizing apps installed. Will work on device. 
                /* 
                 //  Display an UIAlertView that shows the users we saved the file :)
                 UIAlertView *filenameAlert = [[UIAlertView alloc] initWithTitle:@"File saved" message:[NSString stringWithFormat:@"The file %@ has been saved.", filename] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [filenameAlert show];
                 [filenameAlert release];
                 */
            }
        } else {
            NSLog(@"Failed to save the file: File COULD Not be handled");
        }
    } else {
        NSLog(@"Failed to save the file: not a Supported doc");
    }
    
    

    
    
}
- (void)saveFile:(id)sender {
    
    // Get the URL of the loaded ressource
    NSURL *theRessourcesURL = [[webView request] URL];
    NSString *fileExtension = [theRessourcesURL pathExtension];
    
    if ([fileExtension isEqualToString:@"pdf"] || [fileExtension isEqualToString:@"doc"]) {
        UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(documenthandler)];
        self.navigationItem.rightBarButtonItem = homeButton;
        
    }
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none';"];
    self.navigationItem.rightBarButtonItem = nil;

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
    self.navigationItem.rightBarButtonItem = nil;

    [self performSelector:@selector(saveFile:)];

    
    
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
-(void)goback{
    
    [webView loadRequest:[NSURLRequest requestWithURL:urlObject]];
    self.navigationItem.rightBarButtonItem = nil;

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    isRotating = YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    isRotating = NO;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end

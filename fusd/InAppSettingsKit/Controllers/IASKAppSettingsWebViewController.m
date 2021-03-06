//
//  IASKAppSettingsWebViewController.h
//  http://www.inappsettingskit.com
//
//  Copyright (c) 2010:
//  Luc Vandal, Edovia Inc., http://www.edovia.com
//  Ortwin Gentz, FutureTap GmbH, http://www.futuretap.com
//  All rights reserved.
// 
//  It is appreciated but not required that you give credit to Luc Vandal and Ortwin Gentz, 
//  as the original authors of this code. You can give credit in a blog post, a tweet or on 
//  a info page of your app. Also, the original authors appreciate letting them know if you use this code.
//
//  This code is licensed under the BSD license that is available at: http://www.opensource.org/licenses/bsd-license.php
//

#import "IASKAppSettingsWebViewController.h"
#import <Twitter/Twitter.h>


@implementation IASKAppSettingsWebViewController

@synthesize url;
@synthesize webView;

- (id)initWithFile:(NSString*)urlString key:(NSString*)key {
	if (!(self = [super initWithNibName:nil bundle:nil])) {
		return nil;
	}
	
	self.url = [NSURL URLWithString:urlString];
	if (!self.url || ![self.url scheme]) {
		NSString *path = [[NSBundle mainBundle] pathForResource:[urlString stringByDeletingPathExtension] ofType:[urlString pathExtension]];
		if(path)
			self.url = [NSURL fileURLWithPath:path];
		else
			self.url = nil;
	}
	return self;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)dealloc {
	[webView release], webView = nil;
	[url release], url = nil;
	
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {  
    [webView setOpaque:NO];
    webView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"loading@2x.png"]];


	[webView loadRequest:[NSURLRequest requestWithURL:self.url]];

}

- (void)viewDidUnload {
	[super viewDidUnload];
	self.webView = nil;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	self.navigationItem.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
	NSURL *newURL = [request URL];
    NSURL *twiiter = [NSURL URLWithString:@"http://ifusd.fremontunified.org/twitter.php"];
    
    if([twiiter isEqual:newURL]) {
        NSLog(@"Same"); // Not run
        BOOL isIOS5 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0; 
        if (isIOS5 == YES) {
            
            TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
            
            //Customize the tweet sheet here
            //Add a tweet message
            [tweetSheet addImage:[UIImage imageNamed:@"Icon@2x.png"]];
            
            [tweetSheet addURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id454673943?mt=8"]];
            
            [tweetSheet setInitialText:@"Check out @iFUSD, an iPhone/iPad app from Fremont Unified School District."];
            
            //Add an image
            
            //Add a link
            //Don't worry, Twitter will handle turning this into a t.co link
            
            //Set a blocking handler for the tweet sheet
            tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result){
                [self dismissModalViewControllerAnimated:YES];
            };
            
            //Show the tweet sheet!
            [self presentModalViewController:tweetSheet animated:YES];
            
            
        }
        else {
            
            
        }
        
    }
	// intercept mailto URL and send it to an in-app Mail compose view instead
	if ([[newURL scheme] isEqualToString:@"mailto"]) {
        
		NSArray *rawURLparts = [[newURL resourceSpecifier] componentsSeparatedByString:@"?"];
		if (rawURLparts.count > 2) {
			return NO; // invalid URL
		}
		
		MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
		mailViewController.mailComposeDelegate = self;
        
		NSMutableArray *toRecipients = [NSMutableArray array];
		NSString *defaultRecipient = [rawURLparts objectAtIndex:0];
		if (defaultRecipient.length) {
			[toRecipients addObject:defaultRecipient];
		}
		
		if (rawURLparts.count == 2) {
			NSString *queryString = [rawURLparts objectAtIndex:1];
			
			NSArray *params = [queryString componentsSeparatedByString:@"&"];
			for (NSString *param in params) {
				NSArray *keyValue = [param componentsSeparatedByString:@"="];
				if (keyValue.count != 2) {
					continue;
				}
				NSString *key = [[keyValue objectAtIndex:0] lowercaseString];
				NSString *value = [keyValue objectAtIndex:1];
				
				value =  (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																							 (CFStringRef)value,
																							 CFSTR(""),
																							 kCFStringEncodingUTF8);
				[value autorelease];
				
				if ([key isEqualToString:@"subject"]) {
					[mailViewController setSubject:value];
				}
				
				if ([key isEqualToString:@"body"]) {
					[mailViewController setMessageBody:value isHTML:NO];
				}
				
				if ([key isEqualToString:@"to"]) {
					[toRecipients addObjectsFromArray:[value componentsSeparatedByString:@","]];
				}
				
				if ([key isEqualToString:@"cc"]) {
					NSArray *recipients = [value componentsSeparatedByString:@","];
					[mailViewController setCcRecipients:recipients];
				}
				
				if ([key isEqualToString:@"bcc"]) {
					NSArray *recipients = [value componentsSeparatedByString:@","];
					[mailViewController setBccRecipients:recipients];
				}
			}
		}
		
		[mailViewController setToRecipients:toRecipients];
        
		[self presentModalViewController:mailViewController animated:YES];
		[mailViewController release];
		return NO;
	}
	
	// open inline if host is the same, otherwise, pass to the system
	if (![newURL host] || [[newURL host] isEqualToString:[self.url host]]) {
		return YES;
	}
    
	//[[UIApplication sharedApplication] openURL:newURL];
	return YES;
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}



@end

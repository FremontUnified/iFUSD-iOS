//
//  SchoolsViewController.h
//  fusdbeta
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SchoolsViewController : UIViewController <UIWebViewDelegate , UIGestureRecognizerDelegate> {
    IBOutlet UIWebView *webView;
}

-(IBAction)home;

@end

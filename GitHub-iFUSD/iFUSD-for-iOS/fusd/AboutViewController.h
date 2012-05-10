//
//  AboutViewController.h
//  fusd
//
//  Created by Sumukh Sridhara on 7/12/11.
//  Copyright 2011 Sumukh Sridhara. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController <UIGestureRecognizerDelegate, UIWebViewDelegate>{
    IBOutlet UIWebView *webView;
}


@end

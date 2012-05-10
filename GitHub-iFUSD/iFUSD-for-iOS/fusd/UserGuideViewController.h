//
//  UserGuideViewController.h
//  fusd
//
//  Created by Sumukh Sridhara on 7/11/11.
//  Copyright 2011 Sumukh Sridhara. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserGuideViewController : UIViewController <UIGestureRecognizerDelegate, UIWebViewDelegate>{
    IBOutlet UIWebView *webView;
}

@end

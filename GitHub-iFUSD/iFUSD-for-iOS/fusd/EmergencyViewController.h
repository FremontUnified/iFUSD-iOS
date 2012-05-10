//
//  EmergencyViewController.h
//  fusdbeta
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAReloadActivityButton.h"


@interface EmergencyViewController : UIViewController <UIWebViewDelegate , UIGestureRecognizerDelegate> {
    IBOutlet UIWebView *webView;
}

@property (nonatomic, strong) DAReloadActivityButton *navigationBarItem;


@end

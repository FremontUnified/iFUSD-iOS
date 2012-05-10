//
//  DistrictViewController.h
//  fusdbeta
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DistrictViewController : UIViewController <UIWebViewDelegate , UIGestureRecognizerDelegate, UIDocumentInteractionControllerDelegate> {
    IBOutlet UIWebView *webView;  
    BOOL isRotating;
    UIDocumentInteractionController *docController;
    IBOutlet UIToolbar *toolbar;
    IBOutlet UIBarButtonItem *item;


}
-(IBAction)home;

@property(nonatomic,retain)NSURL *urlObject;

@end

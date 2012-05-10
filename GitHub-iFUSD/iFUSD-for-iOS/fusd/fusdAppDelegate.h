//
//  fusdAppDelegate.h
//  fusd
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fusdAppDelegate : NSObject <UIApplicationDelegate> {
    UINavigationController *navController;

}
+(UIColor*)barcolor;

@property (nonatomic, retain) IBOutlet UIWindow *window;


@end

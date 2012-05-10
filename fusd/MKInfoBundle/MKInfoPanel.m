//
//  MKInfoPanel.m
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above
//  Read my blog post at http://mk.sg/8e on how to use this code

//  As a side note on using this code, you might consider giving some credit to me by
//	1) linking my website from your app's website 
//	2) or crediting me inside the app's credits page 
//	3) or a tweet mentioning @mugunthkumar
//	4) A paypal donation to mugunth.kumar@gmail.com
//
//  A note on redistribution
//	While I'm ok with modifications to this source code, 
//	if you are re-publishing after editing, please retain the above copyright notices

#import "MKInfoPanel.h"
#import <QuartzCore/QuartzCore.h>

// Private Methods
// this should be added before implementation block 

@interface MKInfoPanel (PrivateMethods)
@property (nonatomic, assign) MKInfoPanelType type;
+ (MKInfoPanel*) infoPanel;
@end


@implementation MKInfoPanel
@synthesize titleLabel = _titleLabel;
@synthesize detailLabel = _detailLabel;
@synthesize thumbImage = _thumbImage;
@synthesize backgroundGradient = _backgroundGradient;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        origin = MKInfoPanelOriginTop;
        // Initialization code
    }
    return self;
}

-(void) setOrigin:(MKInfoPanelOrigin)ori
{
    origin = ori;
}
-(void) setType:(MKInfoPanelType)type
{
    if(type == MKInfoPanelTypeError)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

        self.backgroundGradient.image = [[UIImage imageNamed:@"Red"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        self.detailLabel.font = [UIFont fontWithName:@"Helvetica Neue" 
                                                size:22];
        self.thumbImage.image = [UIImage imageNamed:@"Warning"];
        self.detailLabel.textColor = RGBA(255, 140, 140, 0.6);
        }
        else {
            
            self.backgroundGradient.image = [[UIImage imageNamed:@"Red"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
            self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
            self.detailLabel.font = [UIFont fontWithName:@"Helvetica Neue" 
                                                    size:13];
            self.thumbImage.image = [UIImage imageNamed:@"Warning"];
            self.detailLabel.textColor = RGBA(255, 140, 140, 0.6);

            
            
        }
    }
    else if(type == MKInfoPanelTypeInfo)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.backgroundGradient.image = [[UIImage imageNamed:@"Blue"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
            self.titleLabel.font = [UIFont boldSystemFontOfSize:24];
            self.detailLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
            
            self.thumbImage.image = [UIImage imageNamed:@"Inbox"];   
            self.detailLabel.textColor = RGBA(210, 210, 235, 1.0);
            
            
        } else {

        self.backgroundGradient.image = [[UIImage imageNamed:@"Blue"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        self.detailLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];

        self.thumbImage.image = [UIImage imageNamed:@"Tick"];   
        self.detailLabel.textColor = RGBA(210, 210, 235, 1.0);
        } 
    }
    
    else if(type == MKInfoPanelTypeAlert)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.backgroundGradient.image = [[UIImage imageNamed:@"Blue"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
            self.titleLabel.font = [UIFont boldSystemFontOfSize:24];
            self.detailLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
                                                                                 
            self.thumbImage.image = [UIImage imageNamed:@"Inbox"];   
        self.detailLabel.textColor = RGBA(210, 210, 235, 1.0);
                                                                                

        } else {

            self.backgroundGradient.image = [[UIImage imageNamed:@"Blue"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
            self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
            self.detailLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
            
            self.thumbImage.image = [UIImage imageNamed:@"Inbox"];   
            self.detailLabel.textColor = RGBA(210, 210, 235, 1.0);

    }

    }    
}
    
+(MKInfoPanel*) infoPanelWithOrigin:(MKInfoPanelOrigin) origin
{
    MKInfoPanel *panel =  (MKInfoPanel*) [[[UINib nibWithNibName:@"MKInfoPanel" bundle:nil] 
                                           instantiateWithOwner:self options:nil] objectAtIndex:0];

    [panel setOrigin:origin];    
    CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;	
	transition.subtype = origin == MKInfoPanelOriginTop ? kCATransitionFromBottom : kCATransitionFromTop;
	[panel.layer addAnimation:transition forKey:nil];
    
    return panel;
}

+(void) showPanelInView:(UIView*) view type:(MKInfoPanelType) type title:(NSString*) title subtitle:(NSString*) subtitle hideAfter:(NSTimeInterval) interval origin:(MKInfoPanelOrigin) origin
{
    MKInfoPanel *panel = [MKInfoPanel infoPanelWithOrigin:origin];
    [panel setType:type];
    panel.titleLabel.text = title;
    if(subtitle)
    {
        panel.detailLabel.text = subtitle;
    }
    else
    {
        panel.detailLabel.hidden = YES;
        CGRect cgRect =[[UIScreen mainScreen] bounds];
        CGSize cgSize = cgRect.size;
        
        panel.frame = CGRectMake(0, 20*((cgSize.height)/480), cgSize.width , 57);
        panel.thumbImage.frame = CGRectMake(15 * ((cgSize.width)/320), 5*((cgSize.height)/480), 35 * ((cgSize.width)/320), 35*((cgSize.height)/480));
        panel.titleLabel.frame = CGRectMake(57 * ((cgSize.width)/320), 12*((cgSize.height)/480), 240* ((cgSize.width)/320), 21*((cgSize.height)/480));
        
    }
    if(origin == MKInfoPanelOriginBottom){
        CGRect cgRect =[[UIScreen mainScreen] bounds];
        CGSize cgSize = cgRect.size;
        panel.frame = CGRectMake(0, 20*((cgSize.height)/480), cgSize.width , cgSize.height/8);
        panel.thumbImage.frame = CGRectMake(15 * ((cgSize.width)/320), 5*((cgSize.height)/480), 35 * ((cgSize.width)/320), 35*((cgSize.height)/480));
        panel.titleLabel.frame = CGRectMake(57 * ((cgSize.width)/320), 3*((cgSize.height)/480), 240* ((cgSize.width)/320), 21*((cgSize.height)/480));
        panel.detailLabel.frame = CGRectMake(57 * ((cgSize.width)/320), 19*((cgSize.height)/480), 250* ((cgSize.width)/320), 23*((cgSize.height)/480));

        CGRect fr = CGRectMake(0, ((cgSize.width)/(320)),cgSize.width , cgSize.height/8);;
        fr.origin.y = view.frame.size.height - fr.size.height;
        panel.frame = fr;
    }
    [view addSubview:panel];
    [panel performSelector:@selector(hidePanel) withObject:view afterDelay:interval];
}

+(void) showPanelInWindow:(UIWindow*) window type:(MKInfoPanelType) type title:(NSString*) title subtitle:(NSString*) subtitle hideAfter:(NSTimeInterval) interval origin:(MKInfoPanelOrigin) origin
{
    MKInfoPanel *panel = [MKInfoPanel infoPanelWithOrigin:origin];
    [panel setType:type];
    panel.titleLabel.text = title;
    if(subtitle)
    {
        panel.detailLabel.text = subtitle;
    }
    else
    {
        panel.detailLabel.hidden = YES;
        CGRect cgRect =[[UIScreen mainScreen] bounds];
        CGSize cgSize = cgRect.size;

        panel.frame = CGRectMake(0, 20*((cgSize.height)/480), cgSize.width , cgSize.height/10);
        panel.thumbImage.frame = CGRectMake(15 * ((cgSize.width)/320), 5*((cgSize.height)/480), 35 * ((cgSize.width)/320), 35*((cgSize.height)/480));
        panel.titleLabel.frame = CGRectMake(57 * ((cgSize.width)/320), 12*((cgSize.height)/480), 240* ((cgSize.width)/320), 21*((cgSize.height)/480));
        panel.detailLabel.frame = CGRectMake(57 * ((cgSize.width)/320), 17*((cgSize.height)/480), 250* ((cgSize.width)/320), 40*((cgSize.height)/480));

        
    }
    
    if(origin == MKInfoPanelOriginBottom){
        CGRect cgRect =[[UIScreen mainScreen] bounds];
        CGSize cgSize = cgRect.size;
        panel.frame = CGRectMake(0, 20*((cgSize.height)/480), cgSize.width , cgSize.height/10);
        panel.thumbImage.frame = CGRectMake(15 * ((cgSize.width)/320), 5*((cgSize.height)/480), 35 * ((cgSize.width)/320), 35*((cgSize.height)/480));
        panel.titleLabel.frame = CGRectMake(57 * ((cgSize.width)/320), 12*((cgSize.height)/480), 240* ((cgSize.width)/320), 21*((cgSize.height)/480));

        CGRect fr = panel.frame;
        fr.origin.y = window.frame.size.height - fr.size.height;
        panel.frame = fr;
    }
    
    [window addSubview:panel];
    [panel performSelector:@selector(hidePanel) withObject:window afterDelay:interval];
}

-(void) hidePanel
{
    CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;	
	transition.subtype = origin == MKInfoPanelOriginTop ?  kCATransitionFromTop : kCATransitionFromBottom;
	[self.layer addAnimation:transition forKey:nil];
    if(origin == MKInfoPanelOriginTop){
        self.frame = CGRectMake(0, -self.frame.size.height, 320, self.frame.size.height); 
    }else    
        self.frame = CGRectMake(0, [self superview ].frame.size.height, 320, self.frame.size.height); 
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.25];
}

- (void)dealloc
{
    [super dealloc];
}

@end

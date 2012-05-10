//
//  HomeViewController.m
//  fusd
//
//  Created by Sumukh Sridhara on 6/25/11.
//  Copyright 2011 Suma Realty. All rights reserved.
//

#import "HomeViewController.h"
#import "SettingViewController.h"
#import "EmergencyViewController.h"
#import "SchoolsViewController.h"
#import "DistrictViewController.h"
#import "CalViewController.h"
#import "NewsViewController.h"

//#import "GCDiscreetNotificationView.h"

@implementation HomeViewController

@synthesize urlObject;

//@synthesize notificationView;
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
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(IBAction)pushnews; {
    DistrictViewController *dis = [[DistrictViewController alloc]init];
    dis.title =@"News";
    
    dis.urlObject = [NSURL URLWithString:@"  /news/site.php"];
    [self.navigationController pushViewController:dis animated:YES];
    [dis release];

    /**  Sends Over The News 
     //FOR NOW we are using the standard district view since we aren't doing anything special here. If we eventually add a RSS feed then we can be 
     come back to using this. 
     
    NewsViewController *news2 = [[NewsViewController alloc]init];
    news2.title =@"News";
    [self.navigationController pushViewController:news2 animated:YES];
    [news2 release]; */


}
- (IBAction)pushcal;{
    DistrictViewController *dis = [[DistrictViewController alloc]init];
    dis.title =@"Calendar";
    
    dis.urlObject = [NSURL URLWithString:@"  /cal/"];
    [self.navigationController pushViewController:dis animated:YES];
    [dis release];

    
    /**  Sends Over The Calendar 
     //FOR NOW we are using the standard district view since we aren't doing anything special here. If we eventually add a RSS feed/Custom Calendar then we can be 
     come back to using this. 

    CalViewController *calview = [[CalViewController alloc]init];
    calview.title =@"Calendar";

    [self.navigationController pushViewController:calview animated:YES];
    
   // [CalViewController release];
    [calview release]; */
    
}
- (IBAction)pushcom;{
    //districtviewcontroller is the backbone for the viewing of urls
    DistrictViewController *dis = [[DistrictViewController alloc]init];
    dis.title =@"Community";
    
    dis.urlObject = [NSURL URLWithString:@"  /community/"];
    [self.navigationController pushViewController:dis animated:YES];
    [dis release];
}

- (IBAction)pushsbo;{
    DistrictViewController *dis = [[DistrictViewController alloc]init];
    dis.title =@"Board of Education";
    
    dis.urlObject = [NSURL URLWithString:@"  /boardofed/"];
    [self.navigationController pushViewController:dis animated:YES];
    [dis release];

    
    
}

- (IBAction)pushdis;{
    
    DistrictViewController *dis = [[DistrictViewController alloc]init];
    dis.title =@"District";

    dis.urlObject = [NSURL URLWithString:@"  /district/"];
    [self.navigationController pushViewController:dis animated:YES];
    [dis release];
}

- (IBAction)pushscho;{
    
    DistrictViewController *dis = [[DistrictViewController alloc]init];
    dis.title =@"Schools";
    
    dis.urlObject = [NSURL URLWithString:@"  /schools/"];
    [self.navigationController pushViewController:dis animated:YES];
    [dis release];

    /*
     //Again, we aren't doing anything special here so why not just use the default instead of alloc init another view.
    SchoolsViewController *sch = [[SchoolsViewController alloc]init];
    sch.title =@"Schools";

    [self.navigationController pushViewController:sch animated:YES];
    
    [sch release];
    */
}

- (IBAction)pushbud;{
    
    DistrictViewController *dis = [[DistrictViewController alloc]init];
    dis.title =@"Budget";
    
    dis.urlObject = [NSURL URLWithString:@"  /budget/"];
    [self.navigationController pushViewController:dis animated:YES];
    [dis release];
}

- (IBAction)pushem;{
    EmergencyViewController *em = [[EmergencyViewController alloc]init];
    em.title =@"Emergency Updates";

    [self.navigationController pushViewController:em animated:YES];
    
    [em release];
    
}
- (IBAction)pushsetting;{
    /**  Sends Over The Settings Controller */

    SettingViewController *sets = [[SettingViewController alloc]init];
    sets.title =@"Settings";

    [self.navigationController pushViewController:sets animated:YES];
    [sets release];
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
        
//    [self.navigationController setNavigationBarHidden:NO animated:NO];

   // self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"loading.png"]];
   /* NSString *string = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www. / /alerts.php?view=home"]];

    //NSLog(@"%@",string);
    if ([string length] == 0){
    }
    else{
        notificationView = 
        [[GCDiscreetNotificationView alloc] initWithText:string showActivity:NO  inPresentationMode:GCDiscreetNotificationViewPresentationModeBottom inView:self.view];
        [notificationView hideAnimatedAfter:10];

 } 
    
    
    [self performSelector:@selector(showsmallnotification) withObject:self afterDelay:0.4];
*/
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    

}

-(void)showsmallnotification
{
   // [notificationView showAnimated];
    
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
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return UIInterfaceOrientationIsPortrait(interfaceOrientation);
        
    }
    

}

@end

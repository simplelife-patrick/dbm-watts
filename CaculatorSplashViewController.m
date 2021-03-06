//
//  CaculatorSplashViewController.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-24.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorSplashViewController.h"

@interface CaculatorSplashViewController ()

@end

@implementation CaculatorSplashViewController

@synthesize timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(loadAnyNecessaryStuff) userInfo:nil repeats:NO];    
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startFadingSplashScreen
{
	[UIView beginAnimations:nil context:nil];  // begins animation block
	[UIView setAnimationDuration:0.75];        // sets animation duration
	[UIView setAnimationDelegate:self];        // sets delegate for this block
	[UIView setAnimationDidStopSelector:@selector(finishFadingSplashScreen)];   // calls the finishFadingSplashScreen method when the animation is done (or done fading out)
	self.view.alpha = 0.0;       // Fades the alpha channel of this view to "0.0" over the animationDuration of "0.75" seconds
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
}

- (void) finishFadingSplashScreen
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    BOOL isAppLaunchedBefore = [defaults boolForKey:APP_CONFIG_ISLAUNCHED_BEFORE];
    if (!isAppLaunchedBefore)
    {
        [self performSegueWithIdentifier:SEGUE_ID_SPLASH_TO_HELP sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:SEGUE_ID_SPLASH_TO_CACULATOR sender:self];
    }
}

- (void) loadAnyNecessaryStuff
{
    // TODO: Long-time tasks here
    
    // Switch back to Splash UI
    [self performSelectorOnMainThread:@selector(startFadingSplashScreen) withObject:self waitUntilDone:YES];
}

@end

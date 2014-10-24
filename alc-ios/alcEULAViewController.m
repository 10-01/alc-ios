//
//  alcEULAViewController.m
//  alc-ios
//
//  Created by Haydn Strauss on 12/11/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import "alcEULAViewController.h"

@interface alcEULAViewController ()

@end

@implementation alcEULAViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIButton *closeIntro = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [closeIntro addTarget:self
                   action:@selector(closeEula)
         forControlEvents:UIControlEventTouchDown];
    [closeIntro setTitle:@"Close" forState:UIControlStateNormal];
    [closeIntro sizeToFit];
    closeIntro.center = self.view.center;
    closeIntro.frame = CGRectMake(0, 20, self.view.frame.size.width, 20);
    [self.view addSubview:closeIntro];
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width,self.view.frame.size.height-40)];
    NSString *url=@"https://pivotal-essence-333.appspot.com/eula";
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webview loadRequest:nsrequest];
    [self.view addSubview:webview];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeEula {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

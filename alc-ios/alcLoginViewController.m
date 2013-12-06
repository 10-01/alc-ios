//
//  alcLoginViewController.m
//  alc-ios
//
//  Created by Haydn Strauss on 11/28/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import "alcLoginViewController.h"
#import "alcAppDelegate.h"
#import "Preferences.h"
#import "MBProgressHUD.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTLAlittlecloser.h"
#import "alcPersonInfo.h"

@interface alcLoginViewController ()
- (IBAction)signupButton:(id)sender;
@property(nonatomic) NSInteger yPositionStore;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
- (IBAction)loginButton:(id)sender;
- (IBAction)closeSignup:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *closeSignupButton;


@property(nonatomic)UIWebView * webview;

@property(nonatomic)NSString *enteredUsername;
@property(nonatomic)NSString *enteredPassword;
@property (nonatomic,strong)NSArray* prefsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation alcLoginViewController

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signupButton:(id)sender {
    _webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height - 50)];
    NSString *url=@"https://pivotal-essence-333.appspot.com/register/";
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    _webview.delegate = self;
    [_webview loadRequest:nsrequest];
    [self.view addSubview:_webview];
    _closeSignupButton.alpha = 1;
    
}

- (IBAction)loginButton:(id)sender {
    _enteredUsername = _usernameField.text;
    _enteredPassword = _passwordField.text;
    [self loginUser];
}

- (IBAction)closeSignup:(id)sender {
    _closeSignupButton.alpha = 0;
    [_webview removeFromSuperview];
}


-(void)loginUser{
    
    // Do any additional setup after loading the view.
    alcAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    alcPersonInfo *personInfoObj=[alcPersonInfo getInstance];
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.prefsArray = [appDelegate getPref];
    
    //  1
    Preferences * prefs = self.prefsArray[0];
    
    static GTLServiceAlittlecloser *service = nil;
    if (!service) {
        service = [[GTLServiceAlittlecloser alloc] init];
        service.retryEnabled = YES;
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    GTLAlittlecloserWebAlittlecloserApiMessagesLoginRequest *getparams = [GTLAlittlecloserWebAlittlecloserApiMessagesLoginRequest alloc];
    
    getparams.username = _enteredUsername;
    getparams.password = _enteredPassword;
    
    GTLQueryAlittlecloser *query = [GTLQueryAlittlecloser queryForLoginWithObject:getparams];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAlittlecloserWebAlittlecloserApiMessagesLoginResponse *object, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *apikey = [NSString stringWithFormat:@"%@",  [object apikey]];
        
        
        if (![apikey  isEqual: @"(null)"]) {
            prefs.api = apikey;
            prefs.loggedIn = [NSNumber numberWithInt:1];
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            personInfoObj.api = apikey;
            personInfoObj.loggedIn = [NSNumber numberWithInt:1];;
            [self dismissViewControllerAnimated:true completion:nil];
        }
        else{
            _errorLabel.text = @"Invalid username/password";
        }
        
    }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
 
    if (navigationType == UIWebViewNavigationTypeFormSubmitted && [[request.URL absoluteString]  isEqual: @"https://pivotal-essence-333.appspot.com/"]) {
        [_webview removeFromSuperview];
        _closeSignupButton.alpha = 0;
    }
    
    return YES;
}

@end

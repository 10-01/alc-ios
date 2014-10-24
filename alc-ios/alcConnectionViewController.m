//
//  alcConnectionViewController.m
//  alc-ios
//
//  Created by Haydn Strauss on 11/27/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import "alcConnectionViewController.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTLAlittlecloser.h"
#import "alcConnectionCell.h"
#import "alcConnectionObjectViewController.h"
#import "alcActiveConnection.h"
#import "alcPersonInfo.h"
#import "MBProgressHUD.h"
#import "alcIntroductionViewController.h"
#import "alcAppDelegate.h"
#import "Preferences.h"
#import "TestFlight.h"
#define NSLog TFLog

#import <SDWebImage/UIImageView+WebCache.h>

@interface alcConnectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *connectionCollectionView;
@property (nonatomic,strong)NSMutableArray* connectionsArray;
@property (nonatomic,strong)NSArray* prefsArray;
@property(nonatomic)NSInteger cellCount;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
// ID of the storyboard cell for this CV
NSString *kConnectionCellID = @"connectionResultCell";

@implementation alcConnectionViewController

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
    alcAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    alcPersonInfo *personInfoObj=[alcPersonInfo getInstance];
    
    _cellCount = 0;
    
    //    Add Reload Controller to UI
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.connectionCollectionView addSubview:refreshControl];
    self.connectionCollectionView.alwaysBounceVertical = YES;

    [TestFlight passCheckpoint:@"LOADED_CONNECTIONS_IN_LIST"];
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.prefsArray = [appDelegate getPref];
    
        if ([self.prefsArray count] == 0){
        //  1
        Preferences * prefs = [NSEntityDescription insertNewObjectForEntityForName:@"Preferences"
                                                          inManagedObjectContext:self.managedObjectContext];
        //  2
        prefs.landing = 0;
        prefs.loggedIn = 0;

        personInfoObj.landing = 0;
        personInfoObj.loggedIn = 0;
        
        //  3
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        //  4
        UIViewController *introView = [alcIntroductionViewController new];
        introView.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:introView animated:NO completion:nil];
    }
    else{
        Preferences * userPrefs = self.prefsArray[0];
        
        if (userPrefs.api  != nil) {
           personInfoObj.api = userPrefs.api;
            personInfoObj.loggedIn = [NSNumber numberWithInt:1];;
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }
    
    static GTLServiceAlittlecloser *service = nil;
    if (!service) {
        service = [[GTLServiceAlittlecloser alloc] init];
        service.retryEnabled = YES;
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddRequest *getparams = [GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddRequest alloc];

    GTLQueryAlittlecloser *query = [GTLQueryAlittlecloser queryForConnectionsList];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAlittlecloserWebAlittlecloserApiMessagesConnectionListResponse *object, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSArray *items = [object connections];
        
        alcActiveConnection *activeObj=[alcActiveConnection getInstance];
        activeObj.connectionList = object;
        
        self.connectionsArray = items;
        [self.connectionCollectionView reloadData];
        
    }];

    //Set self to listen for the message "SecondViewControllerDismissed and run a method when this message is detected
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadHomeViewController)
                                                 name:@"reloadHomeViewController"
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    // Designate the length of the collection view based on the number of search results returned
    NSLog(@"%d", [self.connectionsArray count]);
    return [self.connectionsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection = [GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage alloc];
    
    GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse *mediaObject = [GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse alloc];
    
    GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonMessage *mediaEndObject = [GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonMessage alloc];
    
    connection = [self.connectionsArray objectAtIndex:indexPath.item];
    mediaObject = connection.media[0];
    mediaEndObject = mediaObject.mediaItemMessage[3];
    
    
    alcConnectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kConnectionCellID forIndexPath:indexPath];
    
    
    cell.connectionCellImage.contentMode = UIViewContentModeScaleAspectFill;
    
    [cell.connectionCellImage setImageWithURL:[NSURL URLWithString: mediaEndObject.blobKey]
                         placeholderImage:[UIImage imageNamed:@"loading_image"]];
    
    
    cell.connectionTitle.text = connection.title;
    cell.connectionTitle.textColor = [UIColor colorWithRed:0xE8/255.0f
                                                     green:0x49/255.0f
                                                      blue:0x24/255.0f alpha:1];
    cell.titleBackground.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    
        return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)connectionCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    alcActiveConnection *activeObj=[alcActiveConnection getInstance];
    
    
    GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection = [GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage alloc];
    
    GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse *mediaObject = [GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse alloc];
    
    GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonMessage *mediaEndObject = [GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonMessage alloc];
    
    connection = [self.connectionsArray objectAtIndex:indexPath.item];
    activeObj.connection = connection;
    
    alcConnectionCell *cell = [connectionCollectionView cellForItemAtIndexPath:indexPath];

    alcConnectionObjectViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"fullConnectionModal"];
    
    [self presentViewController:controller animated:YES completion:nil];
}



-(void)refreshView:(UIRefreshControl *)refresh{
    [TestFlight passCheckpoint:@"USED_REFRESH_CONTROL"];
    static GTLServiceAlittlecloser *service = nil;
    if (!service) {
        service = [[GTLServiceAlittlecloser alloc] init];
        service.retryEnabled = YES;
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    
    GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddRequest *getparams = [GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddRequest alloc];
    
    GTLQueryAlittlecloser *query = [GTLQueryAlittlecloser queryForConnectionsList];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAlittlecloserWebAlittlecloserApiMessagesConnectionListResponse *object, NSError *error) {

        NSArray *items = [object connections];
        
        alcActiveConnection *activeObj=[alcActiveConnection getInstance];
        activeObj.connectionList = object;
        
        
        self.connectionsArray = items;
        [self.connectionCollectionView reloadData];
        [refresh endRefreshing];
        
    }];
    
}

//UNCOMMENTS ONCE THE SERVER CHANGES THE REQUESTS TO POSTS
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.row==_cellCount){
//    static GTLServiceAlittlecloser *service = nil;
//    if (!service) {
//        service = [[GTLServiceAlittlecloser alloc] init];
//        service.retryEnabled = YES;
//        [GTMHTTPFetcher setLoggingEnabled:YES];
//    }
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//     
//        
//        
//    GTLQueryAlittlecloser *query = [GTLQueryAlittlecloser queryForConnectionsList];
//    
//    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAlittlecloserWebAlittlecloserApiMessagesConnectionListResponse *object, NSError *error) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        NSArray *items = [object connections];
//        
//        _cellCount = _cellCount+[items count];
//        
//        alcActiveConnection *activeObj=[alcActiveConnection getInstance];
//        activeObj.connectionList = object;
//        
//        [self.connectionsArray addObjectsFromArray:items];
//        [self.connectionCollectionView reloadData];
//    }];
//    }
//}



-(void)reloadHomeViewController {
    [TestFlight passCheckpoint:@"ADD_NAVIGATION_BACK_TO_CONNECTIONS_SUCCESSFUL"];
    static GTLServiceAlittlecloser *service = nil;
    if (!service) {
        service = [[GTLServiceAlittlecloser alloc] init];
        service.retryEnabled = YES;
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddRequest *getparams = [GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddRequest alloc];
    
    GTLQueryAlittlecloser *query = [GTLQueryAlittlecloser queryForConnectionsList];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAlittlecloserWebAlittlecloserApiMessagesConnectionListResponse *object, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSArray *items = [object connections];
        
        alcActiveConnection *activeObj=[alcActiveConnection getInstance];
        activeObj.connectionList = object;
        
        self.connectionsArray = items;
        [self.connectionCollectionView reloadData];
        
    }];
    
}
@end

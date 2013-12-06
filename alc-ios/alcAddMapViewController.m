//
//  alcAddMapViewController.m
//  alc-ios
//
//  Created by Haydn Strauss on 11/28/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import "alcAddMapViewController.h"
#import "alcAddConnectionObject.h"
#import "TestFlight.h"
#define NSLog TFLog

@interface alcAddMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *addMap;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@end

@implementation alcAddMapViewController

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
    _nextButton.enabled = false;
    
    
	// Do any additional setup after loading the view.
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5; //user needs to press for 2 seconds
    [_addMap addGestureRecognizer:lpgr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    [_addMap removeAnnotations:_addMap.annotations];
    alcAddConnectionObject *addConnectionObj=[alcAddConnectionObject getInstance];
    
    CGPoint touchPoint = [gestureRecognizer locationInView:_addMap];
    CLLocationCoordinate2D touchMapCoordinate =
    [_addMap convertPoint:touchPoint toCoordinateFromView:_addMap];
    
    NSLog(@"%f", touchMapCoordinate.latitude);
    addConnectionObj.mapLat = touchMapCoordinate.latitude;
    addConnectionObj.mapLong = touchMapCoordinate.longitude;
    
    _nextButton.enabled = true;
    [TestFlight passCheckpoint:@"USER_ADDED_POINT_TO_MAP"];
    
    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.coordinate = touchMapCoordinate;
    [_addMap addAnnotation:annot];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    alcAddConnectionObject *addConnectionObj=[alcAddConnectionObject getInstance];
    
    if (addConnectionObj.resetAdd){
        [TestFlight passCheckpoint:@"ADD_NAVIGATION_BACK_TO_MAP_SUCCESSFUL"];
        [self.navigationController popToRootViewControllerAnimated:NO];
        
    }
}
@end

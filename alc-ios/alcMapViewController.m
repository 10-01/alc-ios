//
//  alcMapViewController.m
//  alc-ios
//
//  Created by Haydn Strauss on 11/27/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import "alcMapViewController.h"
#import "alcMapAnnotation.h"
#import "alcActiveConnection.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTLAlittlecloser.h"
#import "alcConnectionObjectViewController.h"
#import "MBProgressHUD.h"
#import "TestFlight.h"
#define NSLog TFLog

@interface alcMapViewController ()
@property(nonatomic)MKMapView *mapView;

@end

@implementation alcMapViewController

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
    [TestFlight passCheckpoint:@"MAP_LOADED_VIEW"];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    UIView *mapContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    
    [self.view addSubview:mapContainer];
    
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _mapView.delegate = self;
    [mapContainer addSubview:_mapView];
    
    alcActiveConnection *activeObj=[alcActiveConnection getInstance];
    if (activeObj.connectionList == nil) {
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
            [TestFlight passCheckpoint:@"MAP_CONNECTIONS_LOADED"];
            NSArray *items = [object connections];
            
            alcActiveConnection *activeObj=[alcActiveConnection getInstance];
            activeObj.connectionList = object;
            for (GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection in activeObj.connectionList.connections){
                
                alcMapAnnotation *toAdd = [[alcMapAnnotation alloc]init];
                
                CLLocationDegrees lat = [connection.latitude doubleValue];
                CLLocationDegrees lon = [connection.longitude doubleValue];
                
                CLLocationCoordinate2D connPoint = CLLocationCoordinate2DMake(lat, lon);
                
                toAdd.coordinate = connPoint;
                toAdd.title = connection.title;
                
                NSNumber *temp = connection.connectionStage;
                
                if (temp == [NSNumber numberWithLong:0]) {
                    toAdd.pinColor = MKPinAnnotationColorRed;
                }else{
                    toAdd.pinColor = MKPinAnnotationColorGreen;
                }
                
                
                [_mapView addAnnotation:toAdd];
            }
        }];
    }
    else{
        for (GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection in activeObj.connectionList.connections){
            
            alcMapAnnotation *toAdd = [[alcMapAnnotation alloc]init];
            
            CLLocationDegrees lat = [connection.latitude doubleValue];
            CLLocationDegrees lon = [connection.longitude doubleValue];
            
            CLLocationCoordinate2D connPoint = CLLocationCoordinate2DMake(lat, lon);
            
            toAdd.coordinate = connPoint;
            toAdd.title = connection.title;
            
            NSNumber *temp = connection.connectionStage;
            
            if (temp == [NSNumber numberWithLong:0]) {
                toAdd.pinColor = MKPinAnnotationColorRed;
            }else{
                toAdd.pinColor = MKPinAnnotationColorGreen;
            }
            
            
            [_mapView addAnnotation:toAdd];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)annotationView{
    UIButton * disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [TestFlight passCheckpoint:@"MAP_CLICKED_POINT"];
    [disclosureButton addTarget:self
                         action:@selector(presentMoreInfo)
               forControlEvents:UIControlEventTouchUpInside];
    annotationView.rightCalloutAccessoryView = disclosureButton;
    
    alcActiveConnection *activeObj=[alcActiveConnection getInstance];
    for (GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection in activeObj.connectionList.connections){
        if ([connection.latitude doubleValue] == [[annotationView annotation] coordinate].latitude){
            activeObj.connection = connection;
        }
    }
}

- (void)presentMoreInfo {
    alcConnectionObjectViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"fullConnectionModal"];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	// Handle it, such as showing another view controller
    NSLog(@"The");
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    static NSString *identifier = @"MyAnnotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    alcMapAnnotation *myAnnotation = (alcMapAnnotation*) annotation;
    
    annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:identifier];
    
    // Annotation's color
    annotationView.pinColor = myAnnotation.pinColor;
    annotationView.canShowCallout = YES;
    myAnnotation.title = myAnnotation.title;
    
    return annotationView;
}

@end

//
//  alcAddMediaViewController.m
//  alc-ios
//
//  Created by Haydn Strauss on 11/28/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import "alcAddMediaViewController.h"
#import "alcAddConnectionObject.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTLAlittlecloser.h"
#import "alcPersonInfo.h"
#import "MBProgressHUD.h"
#import "alcFixOrientation.h"
#import "TestFlight.h"
#define NSLog TFLog

#import <SDWebImage/UIImageView+WebCache.h>

@interface alcAddMediaViewController ()
- (IBAction)photoLibraryButton:(id)sender;
- (IBAction)cameraOpenButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewer;
@property (weak, nonatomic) IBOutlet UILabel *selectImageLabel;
- (IBAction)submitConnection:(id)sender;
@property(nonatomic)UIImage *origImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitButton;

@property (nonatomic) NSString *modalAction;
@end

@implementation alcAddMediaViewController

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
    _submitButton.enabled = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photoLibraryButton:(id)sender {
    [self startMediaBrowserFromViewController: self usingDelegate: self];
    _modalAction = @"library";
}

- (IBAction)cameraOpenButton:(id)sender {
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
    _modalAction = @"record";
}


- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate{
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = NO;
    
    mediaUI.delegate = delegate;
    
    [TestFlight passCheckpoint:@"USER_LOADED_FROM_LIBRARY"];
    
    [controller presentViewController: mediaUI animated: YES completion: nil];
    
    return YES;
    
}


// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    alcAddConnectionObject *addConnectionObj=[alcAddConnectionObject getInstance];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef)mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        NSURL *imagePath = [info objectForKey:
                                UIImagePickerControllerReferenceURL];
        _origImage = [info objectForKey:
                            UIImagePickerControllerOriginalImage];
        _imageViewer.contentMode = UIViewContentModeScaleAspectFill;
        [_imageViewer setUserInteractionEnabled:YES];
        [_imageViewer setImageWithURL:imagePath ];
        [_imageViewer initWithImage:_origImage];
        _selectImageLabel.text = @"";
        _submitButton.enabled = true;
        [TestFlight passCheckpoint:@"USER_ADDED_MEDIA"];
        addConnectionObj.mediaPath = imagePath;
//        addConnectionObj.mediaName = [info objectForKey:UIImagePickerController]
    }
}




- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [TestFlight passCheckpoint:@"USER_TOOK_PICTURE"];
    
    [controller presentViewController: cameraUI animated: YES completion:nil];
    return YES;
}


- (void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
        [alert show];
    }else{
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        //        [alert show];
    }
}

- (IBAction)submitConnection:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    alcAddConnectionObject *addConnectionObj=[alcAddConnectionObject getInstance];
    alcPersonInfo *personInfo=[alcPersonInfo getInstance];
    
    
    //SAVE TO LOCAL FILE URL AND UPLOAD
    NSData *imageData = UIImageJPEGRepresentation(_origImage, 1.0);
    
    UIImage *thumbnail = [UIImage imageWithData: imageData];
    
    if (thumbnail.imageOrientation == UIImageOrientationUp) {
        
    }
    else{
        UIGraphicsBeginImageContextWithOptions(thumbnail.size, NO, thumbnail.scale);
        [thumbnail drawInRect:(CGRect){0, 0, thumbnail.size}];
        UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        thumbnail = normalizedImage;
    }
    
    
    
    // Create paths to output images
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *outputURL = paths[0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:outputURL withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *randomOutPath = [self makeUniqueString];
    
    outputURL = [outputURL stringByAppendingPathComponent:randomOutPath];
    // Remove Existing File
    [fileManager removeItemAtPath:outputURL error:nil];
    
    
    // Write a UIImage to JPEG with minimum compression (best quality)
    // The value 'image' must be a UIImage object
    // The value '1.0' represents image compression quality as value from 0.0 to 1.0
    [UIImageJPEGRepresentation(thumbnail, 1.0) writeToFile:outputURL atomically:YES];
    NSURL *imageUrl = [NSURL fileURLWithPath:outputURL];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{};
    
    [TestFlight passCheckpoint:@"USER_SUBMITTED_ADD_CONNECTION"];
    
    [manager POST:@"https://pivotal-essence-333.appspot.com/fileupload" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:imageUrl name:@"file" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        static GTLServiceAlittlecloser *service = nil;
        if (!service) {
            service = [[GTLServiceAlittlecloser alloc] init];
            service.retryEnabled = YES;
            [GTMHTTPFetcher setLoggingEnabled:YES];
        }
        
        GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddRequest *getparams = [GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddRequest alloc];
        getparams.media = [self bv_jsonStringWithPrettyPrint:true :responseObject];
        getparams.apikey = personInfo.api;
        getparams.title = addConnectionObj.title;
        getparams.personthingName = addConnectionObj.recipientName;
        getparams.summary = addConnectionObj.giftDescription;
        getparams.requestReason = addConnectionObj.giftReason;
        getparams.latitude =  [NSNumber numberWithFloat: addConnectionObj.mapLat];
        getparams.longitude =  [NSNumber numberWithFloat:addConnectionObj.mapLong ];
        getparams.primaryMedia = randomOutPath;
        
        [TestFlight passCheckpoint:@"ADD_IMAGE_UPLOAD_SUCCESSFUL"];
        
        GTLQueryAlittlecloser *query = [GTLQueryAlittlecloser queryForConnectionsAddWithObject:getparams];
        
        [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAlittlecloserWebAlittlecloserApiMessagesConnectionAddResponse *object, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSString *message = [object message];
            
            if ([message hasPrefix:@"user"]){
                _selectImageLabel.text = @"Maximum 5 outstanding requests per user. Visit your profile on the web to delete one.";
                [TestFlight passCheckpoint:@"USER_HAD_5_CONNECTIONS"];
                }
            else{
                [TestFlight passCheckpoint:@"SUCCESSFULLY_ADDED_CONNECTION"];
                addConnectionObj.resetAdd = YES;
                [self.navigationController popViewControllerAnimated:NO];
            };
        }];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(NSString *)makeUniqueString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyMMddHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    int randomValue = arc4random() % 1000;
    
    NSString *unique = [NSString stringWithFormat:@"%@%d.jpg",dateString,randomValue];
    
    return unique;
}

-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint:(NSDictionary*)inputDict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:inputDict
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}


@end

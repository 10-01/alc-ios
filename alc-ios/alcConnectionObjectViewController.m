//
//  alcConnectionObjectViewController.m
//  alc-ios
//
//  Created by Haydn Strauss on 11/27/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import "alcConnectionObjectViewController.h"
#import "GTLAlittlecloser.h"
#import "alcActiveConnection.h"
#import "TestFlight.h"
#define NSLog TFLog

#import <SDWebImage/UIImageView+WebCache.h>

@interface alcConnectionObjectViewController ()
@property(nonatomic)NSInteger photoNum;
@property(nonatomic)UITableView *connectionDetails;

@end

@implementation alcConnectionObjectViewController

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
    [TestFlight passCheckpoint:@"LOADED_INDIVIDUAL_CONNECTION"];
    _photoNum = 0;
    alcActiveConnection *activeObj=[alcActiveConnection getInstance];
    
    GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection = [GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage alloc];
    
    GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse *mediaObject = [GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse alloc];
    
    GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonMessage *mediaEndObject = [GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonMessage alloc];
    
    connection = activeObj.connection;
    mediaObject = connection.media[_photoNum];
    mediaEndObject = mediaObject.mediaItemMessage[3];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setUserInteractionEnabled:YES];
    [imageView setImageWithURL:[NSURL URLWithString: mediaEndObject.blobKey]
              placeholderImage:[UIImage imageNamed:@"loading_image"]];
    
    [self.view addSubview:imageView];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeLeft= [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight= [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [imageView addGestureRecognizer:swipeDown];
    [imageView addGestureRecognizer:swipeLeft];
    [imageView addGestureRecognizer:swipeRight];
    
    
//    Add text for the connection
    _connectionDetails = [[UITableView alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/2 +40) style:UITableViewStyleGrouped];
    _connectionDetails.delegate = self;
    _connectionDetails.dataSource = self;
    _connectionDetails.backgroundColor = [UIColor whiteColor];
    _connectionDetails.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 0.01f)];
    [self.view addSubview:_connectionDetails];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        [TestFlight passCheckpoint:@"LOADED_INDIVIDUAL_CONNECTION_SWIPE_DOWN"];
        [self dismissViewControllerAnimated:true completion:nil];
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        [TestFlight passCheckpoint:@"LOADED_INDIVIDUAL_CONNECTION_SWIPE_LEFT"];
        _photoNum = _photoNum+1;
        alcActiveConnection *activeObj=[alcActiveConnection getInstance];
        
        GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection = [GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage alloc];
        
        GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse *mediaObject = [GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse alloc];
        
        GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonMessage *mediaEndObject = [GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonMessage alloc];
    
        
        connection = activeObj.connection;
        NSInteger sz = [connection.media count]-1;
        if (_photoNum > sz){
            _photoNum = 0;
        }
        mediaObject = connection.media[_photoNum];
        mediaEndObject = mediaObject.mediaItemMessage[3];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setUserInteractionEnabled:YES];
        [imageView setImageWithURL:[NSURL URLWithString: mediaEndObject.blobKey]
                  placeholderImage:[UIImage imageNamed:@"loading_image"]];
        [self.view addSubview:imageView];
        
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        UISwipeGestureRecognizer *swipeLeft= [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        UISwipeGestureRecognizer *swipeRight= [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        
        [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        
        [imageView addGestureRecognizer:swipeDown];
        [imageView addGestureRecognizer:swipeLeft];
        [imageView addGestureRecognizer:swipeRight];
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        [TestFlight passCheckpoint:@"LOADED_INDIVIDUAL_CONNECTION_SWIPE_RIGHT"];
        _photoNum = _photoNum-1;
        alcActiveConnection *activeObj=[alcActiveConnection getInstance];
        
        GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection = [GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage alloc];
        
        GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse *mediaObject = [GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonFinalResponse alloc];
        
        GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonMessage *mediaEndObject = [GTLAlittlecloserWebAlittlecloserApiMessagesMediaJsonMessage alloc];
        
        
        connection = activeObj.connection;
        NSInteger sz = [connection.media count]-1;
        if (_photoNum < 0){
            _photoNum = sz;
        }
        mediaObject = connection.media[_photoNum];
        mediaEndObject = mediaObject.mediaItemMessage[3];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setUserInteractionEnabled:YES];
        [imageView setImageWithURL:[NSURL URLWithString: mediaEndObject.blobKey]
                  placeholderImage:[UIImage imageNamed:@"loading_image"]];
        [self.view addSubview:imageView];
        
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        UISwipeGestureRecognizer *swipeLeft= [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        UISwipeGestureRecognizer *swipeRight= [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        
        [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        
        [imageView addGestureRecognizer:swipeDown];
        [imageView addGestureRecognizer:swipeLeft];
        [imageView addGestureRecognizer:swipeRight];
    }
    [self.view addSubview:_connectionDetails];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	alcActiveConnection *activeObj=[alcActiveConnection getInstance];
    GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection = [GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage alloc];
    connection = activeObj.connection;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    // Make cell unselectable
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	UITextField* tf = nil ;
	switch ( indexPath.row ) {
        case 0: {
			cell.textLabel.text = connection.title;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.textLabel.minimumScaleFactor = 0;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor colorWithRed:0xE8/255.0f
                                                       green:0x49/255.0f
                                                        blue:0x24/255.0f alpha:1];
            			break ;
		}
        case 1: {
			cell.textLabel.text = @"From";
            cell.textLabel.textColor = [UIColor colorWithRed:0xb6/255.0f
                                                       green:0xe2/255.0f
                                                        blue:0xe9/255.0f alpha:1];
            UILabel *from = [[UILabel alloc] initWithFrame:CGRectMake(65, 2, self.view.frame.size.width-70, 40)];
            from.text = connection.userName;
            from.textColor = [UIColor colorWithRed:0x4d/255.0f
                                             green:0x4e/255.0f
                                              blue:0x4d/255.0f alpha:1];
            [cell addSubview:from];
            
            break ;
		}
        case 2: {
			cell.textLabel.text = @"To";
            cell.textLabel.textColor = [UIColor colorWithRed:0xb6/255.0f
                                                       green:0xe2/255.0f
                                                        blue:0xe9/255.0f alpha:1];
            UILabel *to = [[UILabel alloc] initWithFrame:CGRectMake(65, 2, self.view.frame.size.width-70, 40)];
            to.text = connection.personthingName;
            to.textColor = [UIColor colorWithRed:0x4d/255.0f
                                           green:0x4e/255.0f
                                            blue:0x4d/255.0f alpha:1];
            [cell addSubview:to];
            
            break ;
		}
		case 3: {
			cell.textLabel.text = @"Gift";
            cell.textLabel.textColor = [UIColor colorWithRed:0xb6/255.0f
                                                       green:0xe2/255.0f
                                                        blue:0xe9/255.0f alpha:1];
            
            

            UILabel *gift = [[UILabel alloc] initWithFrame:CGRectMake(65, 2, self.view.frame.size.width-70, 40)];
            gift.text = connection.summary;
            gift.numberOfLines = 0;
            gift.textColor = [UIColor colorWithRed:0x4d/255.0f
                                             green:0x4e/255.0f
                                              blue:0x4d/255.0f alpha:1];
            gift.adjustsFontSizeToFitWidth = YES;
            gift.minimumScaleFactor = 0;
            [cell addSubview:gift];
			break ;
		}
		case 4: {
			cell.textLabel.text = @"Why";
            cell.textLabel.textColor = [UIColor colorWithRed:0xb6/255.0f
                                                       green:0xe2/255.0f
                                                        blue:0xe9/255.0f alpha:1];
            UILabel *why = [[UILabel alloc] initWithFrame:CGRectMake(65, 2, self.view.frame.size.width-70, 40)];
            why.text = connection.reqReason;
            why.numberOfLines = 0;
            why.textColor = [UIColor colorWithRed:0x4d/255.0f
                                            green:0x4e/255.0f
                                             blue:0x4d/255.0f alpha:1];
            why.adjustsFontSizeToFitWidth = YES;
            why.minimumScaleFactor = 0;
            
            [cell addSubview:why];
			break ;
		}
        case 5: {
			
            UIButton *report = [[UIButton alloc] initWithFrame:CGRectMake(35, 2, self.view.frame.size.width-70, 40)];
            [report addTarget:self
                           action:@selector(report)
                 forControlEvents:UIControlEventTouchDown];
            [report setTitle:@"Report Inappropriate Content" forState:UIControlStateNormal];
            [report setFont:[UIFont systemFontOfSize:10]];
            [report setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [cell addSubview:report];
			break ;
		}
	}
    

    
	// Textfield dimensions
	tf.frame = CGRectMake(50, 12, self.view.frame.size.width-20, 30);
    
	// Workaround to dismiss keyboard when Done/Return is tapped
	[tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
	
	// We want to handle textFieldDidEndEditing
	tf.delegate = self ;
    
    return cell;
}

-(void)report{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Report Content?"
                                                    message:@"Thank you for reporting inappropriate content." delegate:self cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
    [TestFlight passCheckpoint:@"INAPPROPRIATE CONTENT"];
}


@end

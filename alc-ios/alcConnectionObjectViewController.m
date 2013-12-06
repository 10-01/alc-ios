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

#import <SDWebImage/UIImageView+WebCache.h>

@interface alcConnectionObjectViewController ()
@property(nonatomic)NSInteger photoNum;

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
    UITableView *connectionDetails = [[UITableView alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/2 +40) style:UITableViewStyleGrouped];
    connectionDetails.delegate = self;
    connectionDetails.dataSource = self;
    connectionDetails.backgroundColor = [UIColor whiteColor];
    connectionDetails.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 0.01f)];
    [self.view addSubview:connectionDetails];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        [self dismissViewControllerAnimated:true completion:nil];
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionLeft){
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	alcActiveConnection *activeObj=[alcActiveConnection getInstance];
    GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection = [GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage alloc];
    connection = activeObj.connection;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    // Make cell unselectable
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	UITextField* tf = nil ;
	switch ( indexPath.row ) {
        case 0: {
			cell.textLabel.text = connection.title;
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
            [why setLineBreakMode:NSLineBreakByWordWrapping];
            [cell addSubview:why];
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
@end

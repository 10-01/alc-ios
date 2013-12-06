//
//  alcAddFormViewController.m
//  alc-ios
//
//  Created by Haydn Strauss on 11/28/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import "alcAddFormViewController.h"
#import "alcAppDelegate.h"
#import "Preferences.h"
#import "alcLoginViewController.h"
#import "alcPersonInfo.h"
#import "alcAddConnectionObject.h"

@interface alcAddFormViewController ()
@property (weak, nonatomic) IBOutlet UITableView *formTable;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong)NSArray* prefsArray;


@property (nonatomic,copy) NSString* title ;
@property (nonatomic,copy) NSString* recipientName ;
@property (nonatomic,copy) NSString* giftReason ;
@property (nonatomic,copy) NSString* giftDescription ;
@end

@implementation alcAddFormViewController

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
    alcPersonInfo *personInfoObj=[alcPersonInfo getInstance];

    if (personInfoObj.loggedIn == 0){
        alcLoginViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"loginModal"];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    // Make cell unselectable
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	UITextField* tf = nil ;
	switch ( indexPath.row ) {
		case 0: {
			tf = titleField_= [self makeTextField:self.title placeholder:@"Title (e.g. Give Flowers to Mom)"];
			[cell addSubview:titleField_];
			break ;
		}
        case 1: {
			tf = recipientNameField_ = [self makeTextField:self.recipientName placeholder:@"Recipient name"];
			[cell addSubview:recipientNameField_];
			break ;
		}
		case 2: {
			tf = giftReason_ = [self makeTextField:self.giftReason placeholder:@"Why would you like to give something?"];
			[cell addSubview:giftReason_];
			break ;
		}
		case 3: {
			tf = giftDescription_ = [self makeTextField:self.giftDescription placeholder:@"Gift Description"];
			[cell addSubview:giftDescription_];
			break ;
		}
	}
    
	// Textfield dimensions
	tf.frame = CGRectMake(20, 12, self.view.frame.size.width-20, 30);
    
	// Workaround to dismiss keyboard when Done/Return is tapped
	[tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
	
	// We want to handle textFieldDidEndEditing
	tf.delegate = self ;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITextField*) makeTextField: (NSString*)text
                  placeholder: (NSString*)placeholder  {
	UITextField *tf = [[UITextField alloc] init];
	tf.placeholder = placeholder ;
	tf.text = text ;
	tf.autocorrectionType = UITextAutocorrectionTypeNo ;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.adjustsFontSizeToFitWidth = YES;
	tf.textColor = [UIColor colorWithRed:0x4d/255.0f
                                   green:0x4e/255.0f
                                    blue:0x4d/255.0f alpha:1];
	return tf ;
}

// Workaround to hide keyboard when Done is tapped
- (IBAction)textFieldFinished:(id)sender {
    // [sender resignFirstResponder];
}

// Textfield value changed, store the new value.
- (void)textFieldDidEndEditing:(UITextField *)textField {
    alcAddConnectionObject *addConnectionObj=[alcAddConnectionObject getInstance];
	if ( textField == titleField_ ) {
		addConnectionObj.title = textField.text ;
	} else if ( textField == recipientNameField_ ) {
		addConnectionObj.recipientName = textField.text ;
	} else if ( textField == giftReason_ ) {
		addConnectionObj.giftReason = textField.text ;
	} else if ( textField == giftDescription_ ) {
		addConnectionObj.giftDescription = textField.text ;
	}
    if (addConnectionObj.title != nil && addConnectionObj.recipientName != nil && addConnectionObj.giftDescription != nil) {
        _nextButton.enabled = true;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    alcAddConnectionObject *addConnectionObj=[alcAddConnectionObject getInstance];
    
    if (addConnectionObj.resetAdd){
        addConnectionObj.resetAdd = NO;
        _nextButton.enabled = false;
        
        [_formTable reloadData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadHomeViewController"
                                                            object:nil
                                                          userInfo:nil];
        
        self.tabBarController.selectedViewController =[self.tabBarController.viewControllers objectAtIndex:0];
    }
}

@end

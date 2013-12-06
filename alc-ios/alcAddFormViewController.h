//
//  alcAddFormViewController.h
//  alc-ios
//
//  Created by Haydn Strauss on 11/28/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface alcAddFormViewController : UIViewController{
    UITextField* titleField_;
    UITextField* recipientNameField_ ;
	UITextField* giftReason_;
    UITextField* giftDescription_;
}

// Creates a textfield with the specified text and placeholder text
-(UITextField*) makeTextField: (NSString*)text
                  placeholder: (NSString*)placeholder  ;


@end

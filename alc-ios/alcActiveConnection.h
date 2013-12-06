//
//  alcActiveConnection.h
//  alc-ios
//
//  Created by Haydn Strauss on 11/27/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTLAlittlecloser.h"

@interface alcActiveConnection : NSObject{
    GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection;
    GTLAlittlecloserWebAlittlecloserApiMessagesConnectionListResponse *connectionList;
}

@property (strong, nonatomic)GTLAlittlecloserWebAlittlecloserApiMessagesConnectionListResponse *connectionList;
@property(strong, nonatomic)GTLAlittlecloserWebAlittlecloserApiMessagesConnectionResponseMessage *connection;
+(alcActiveConnection*)getInstance;

@end

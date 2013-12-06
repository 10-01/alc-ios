//
//  alcPersonInfo.h
//  alc-ios
//
//  Created by Haydn Strauss on 12/3/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface alcPersonInfo : NSObject{
    NSString * api;
    NSNumber * landing;
    NSNumber * loggedIn;
    NSString * username;
}

@property (nonatomic, retain) NSString * api;
@property (nonatomic, retain) NSNumber * landing;
@property (nonatomic, retain) NSNumber * loggedIn;
@property (nonatomic, retain) NSString * username;
+(alcPersonInfo*)getInstance;


@end

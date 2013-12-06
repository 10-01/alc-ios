//
//  alcAddConnectionObject.h
//  alc-ios
//
//  Created by Haydn Strauss on 12/3/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface alcAddConnectionObject : NSObject{
    NSString * api;
    NSString * title;
    NSString * recipientName;
    NSString * giftReason;
    NSString * giftDescription;
    CGFloat * mapLat;
    CGFloat * mapLong;
    NSURL * mediaPath;
    NSString * mediaName;
    BOOL resetAdd;
}

@property (nonatomic, retain) NSString * api;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * recipientName;
@property (nonatomic, retain) NSString * giftReason;
@property (nonatomic, retain) NSString * giftDescription;
@property (nonatomic) CGFloat  mapLat;
@property (nonatomic) CGFloat mapLong;
@property (nonatomic, retain) NSURL * mediaPath;
@property (nonatomic, retain) NSString * mediaName;
@property (nonatomic) BOOL resetAdd;
+(alcAddConnectionObject*)getInstance;


@end

//
//  alcActiveConnection.m
//  alc-ios
//
//  Created by Haydn Strauss on 11/27/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import "alcActiveConnection.h"

@implementation alcActiveConnection

static alcActiveConnection *instance =nil;
+(alcActiveConnection *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [alcActiveConnection new];
        }
    }
    return instance;
}

@end

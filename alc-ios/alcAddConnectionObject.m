//
//  alcAddConnectionObject.m
//  alc-ios
//
//  Created by Haydn Strauss on 12/3/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import "alcAddConnectionObject.h"

@implementation alcAddConnectionObject
static alcAddConnectionObject *instance =nil;
+(alcAddConnectionObject *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [alcAddConnectionObject new];
        }
    }
    return instance;
}
@end

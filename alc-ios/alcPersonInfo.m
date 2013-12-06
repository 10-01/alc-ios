//
//  alcPersonInfo.m
//  alc-ios
//
//  Created by Haydn Strauss on 12/3/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import "alcPersonInfo.h"

@implementation alcPersonInfo
static alcPersonInfo *instance =nil;
+(alcPersonInfo *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [alcPersonInfo new];
        }
    }
    return instance;
}
@end

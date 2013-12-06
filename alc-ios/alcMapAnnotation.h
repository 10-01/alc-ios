//
//  alcMapAnnotation.h
//  alc-ios
//
//  Created by Haydn Strauss on 11/28/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface alcMapAnnotation : NSObject<MKAnnotation>{
    
    NSString *title;
    NSString *subtitle;
    NSString *note;
    CLLocationCoordinate2D coordinate;
    UIButton *rightButton;
    MKPinAnnotationColor pinColor;
}

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (nonatomic)UIButton *rightButton;
@property (nonatomic) MKPinAnnotationColor pinColor;

@end

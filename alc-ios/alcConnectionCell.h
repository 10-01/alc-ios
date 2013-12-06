//
//  alcConnectionCell.h
//  alc-ios
//
//  Created by Haydn Strauss on 11/27/13.
//  Copyright (c) 2013 a-little-closer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface alcConnectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *connectionCellImage;
@property (weak, nonatomic) IBOutlet UILabel *connectionTitle;
@property (weak, nonatomic) IBOutlet UIView *titleBackground;

@end

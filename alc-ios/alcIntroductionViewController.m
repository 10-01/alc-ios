//
//  bubblIntroViewController.m
//  bubbl-ios-tab-bar
//
//  Created by Haydn Strauss on 11/2/13.
//  Copyright (c) 2013 bubbl. All rights reserved.
//

#import "alcIntroductionViewController.h"

#define NUMBER_OF_PAGES 4

#define timeForPage(page) (NSInteger)(self.view.frame.size.width * (page - 1))
#define xForPage(page) timeForPage(page)

@interface alcIntroductionViewController ()
@property (strong, nonatomic) UIImageView *wordmark;
@property (strong, nonatomic) UIImageView *unicorn;
@property (strong, nonatomic) UILabel *lastLabel;

@end

@implementation alcIntroductionViewController

- (id)init
{
    self = [super init];
    
    if (self) {
        self.scrollView.contentSize = CGSizeMake(
                                                 NUMBER_OF_PAGES * self.view.frame.size.width,
                                                 self.view.frame.size.height
                                                 );
        
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        [self placeViews];
        [self configureAnimation];
    }
    
    return self;
}

- (void)placeViews
{
    // put a unicorn in the middle of page two, hidden
    self.unicorn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoLanding"]];
    self.unicorn.center = self.view.center;
    self.unicorn.frame = CGRectOffset(
                                      self.unicorn.frame,
                                      0,
                                      self.view.frame.size.height/2 - 180
                                      );
    self.unicorn.alpha = 1.0f;
    [self.scrollView addSubview:self.unicorn];
    
    // put a logo on top of it
    self.wordmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoLanding"]];
    self.wordmark.center = self.view.center;
    self.wordmark.frame = CGRectOffset(
                                       self.wordmark.frame,
                                       self.view.frame.size.width,
                                       0
                                       );
    [self.scrollView addSubview:self.wordmark];
    
    UILabel *firstPageText = [[UILabel alloc] init];
    firstPageText.text = @"Welcome to ALC";
    firstPageText.textColor = [UIColor colorWithRed:0xE8/255.0f
                                              green:0x49/255.0f
                                               blue:0x24/255.0f alpha:1];
    
    [firstPageText sizeToFit];
    firstPageText.center = self.view.center;
    firstPageText.frame = CGRectOffset(firstPageText.frame, 0, -self.view.frame.size.height/2 + 60);
    
    
    UILabel *firstPageDesc = [[UILabel alloc] init];
    firstPageDesc.text = @"Providing an unexpected gift at an unexpected time.";
    firstPageDesc.textColor = [UIColor colorWithRed:0xE8/255.0f
                                              green:0x49/255.0f
                                               blue:0x24/255.0f alpha:1];
    
    [firstPageDesc sizeToFit];
    firstPageDesc.center = self.view.center;
    firstPageDesc.frame = CGRectOffset(firstPageText.frame, 0, -self.view.frame.size.height/2 + 120);

    [self.scrollView addSubview:firstPageDesc];
    
    
    UIButton *skipIntro = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [skipIntro addTarget:self
                  action:@selector(finishIntroToMainView)
        forControlEvents:UIControlEventTouchDown];
    [skipIntro setTitle:@"Skip" forState:UIControlStateNormal];
    [skipIntro sizeToFit];
    skipIntro.center = self.view.center;
    skipIntro.frame = CGRectOffset(skipIntro.frame, xForPage(1), self.view.frame.size.height/2 - 60);
    [self.scrollView addSubview:skipIntro];
    
    [self.scrollView addSubview:firstPageText];
    
    UILabel *secondPageText = [[UILabel alloc] init];
    secondPageText.text = @"Locate";
    secondPageText.textColor = [UIColor colorWithRed:0xE8/255.0f
                                              green:0x49/255.0f
                                               blue:0x24/255.0f alpha:1];
    [secondPageText sizeToFit];
    secondPageText.center = self.view.center;
    secondPageText.frame = CGRectOffset(secondPageText.frame, xForPage(2), -self.view.frame.size.height/2 + 60);
    [self.scrollView addSubview:secondPageText];
    
    UILabel *thirdPageText = [[UILabel alloc] init];
    thirdPageText.text = @"Select";
    thirdPageText.textColor = [UIColor colorWithRed:0xE8/255.0f
                                               green:0x49/255.0f
                                                blue:0x24/255.0f alpha:1];
    [thirdPageText sizeToFit];
    thirdPageText.center = self.view.center;
    thirdPageText.frame = CGRectOffset(thirdPageText.frame, xForPage(3), -self.view.frame.size.height/2 + 60);
    [self.scrollView addSubview:thirdPageText];
    
    UILabel *fourthPageText = [[UILabel alloc] init];
    fourthPageText.text = @"Share";
    fourthPageText.textColor = [UIColor colorWithRed:0xE8/255.0f
                                               green:0x49/255.0f
                                                blue:0x24/255.0f alpha:1];
    [fourthPageText sizeToFit];
    fourthPageText.center = self.view.center;
    fourthPageText.frame = CGRectOffset(fourthPageText.frame, xForPage(4), -self.view.frame.size.height/2 + 60);
    UIButton *closeIntro = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [closeIntro addTarget:self
                   action:@selector(finishIntroToMainView)
         forControlEvents:UIControlEventTouchDown];
    [closeIntro setTitle:@"Enjoy" forState:UIControlStateNormal];
    [closeIntro sizeToFit];
    closeIntro.center = self.view.center;
    closeIntro.frame = CGRectOffset(closeIntro.frame, xForPage(4), self.view.frame.size.height/2 - 60);
    [self.scrollView addSubview:closeIntro];
    [self.scrollView addSubview:fourthPageText];
    
    self.lastLabel = fourthPageText;
}

- (void)configureAnimation
{
    CGFloat dy = 140;
    
    // first, let's animate the wordmark
    IFTTTFrameAnimation *wordmarkFrameAnimation = [IFTTTFrameAnimation new];
    wordmarkFrameAnimation.view = self.wordmark;
    [self.animator addAnimation:wordmarkFrameAnimation];
    
    // move 200 pixels to the right for parallax effect
    [wordmarkFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1)
                                                                            andFrame:CGRectOffset(self.wordmark.frame, 200, 0)]];
    
    // move to initial frame on page 2 for parallax effect
    [wordmarkFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                            andFrame:self.wordmark.frame]];
    
    // move down and to the right between pages 2 and 3
    [wordmarkFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3)
                                                                            andFrame:CGRectOffset(self.wordmark.frame, self.view.frame.size.width, dy)]];
    
    // move back to initial position on page 4 for parallax effect
    [wordmarkFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4)
                                                                            andFrame:CGRectOffset(self.wordmark.frame, 0, dy)]];
    
    // now, we animate the unicorn
    IFTTTFrameAnimation *unicornFrameAnimation = [IFTTTFrameAnimation new];
    unicornFrameAnimation.view = self.unicorn;
    [self.animator addAnimation:unicornFrameAnimation];
    
    CGFloat ds = 50;
    
    // move down and to the right, and shrink between pages 2 and 3
    [unicornFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1) andFrame:self.unicorn.frame]];
    [unicornFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                           andFrame:CGRectOffset(CGRectInset(self.unicorn.frame, ds, ds), xForPage(1), dy)]];
    // fade the unicorn in on page 2 and out on page 4
    IFTTTAlphaAnimation *unicornAlphaAnimation = [IFTTTAlphaAnimation new];
    unicornAlphaAnimation.view = self.unicorn;
    [self.animator addAnimation:unicornAlphaAnimation];
    
    [unicornAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1) andAlpha:1.0f]];
    [unicornAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2) andAlpha:0.0f]];
    [unicornAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3) andAlpha:0.0f]];
    [unicornAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4) andAlpha:0.0f]];
    
    IFTTTHideAnimation *labelHideAnimation = [[IFTTTHideAnimation alloc] initWithView:self.lastLabel hideAt:timeForPage(4)];
    [self.animator addAnimation:labelHideAnimation];
}

-(void)finishIntroToMainView {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end

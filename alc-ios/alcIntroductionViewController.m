//
//  bubblIntroViewController.m
//  bubbl-ios-tab-bar
//
//  Created by Haydn Strauss on 11/2/13.
//  Copyright (c) 2013 bubbl. All rights reserved.
//

#import "alcIntroductionViewController.h"
#import "TestFlight.h"
#import "alcEULAViewController.h"

#define NSLog TFLog

#define NUMBER_OF_PAGES 4

#define timeForPage(page) (NSInteger)(self.view.frame.size.width * (page - 1))
#define xForPage(page) timeForPage(page)

@interface alcIntroductionViewController ()
@property (strong, nonatomic) UIImageView *wordmark;
@property (strong, nonatomic) UIImageView *unicorn;
@property (strong, nonatomic) UIImageView *bg1;
@property (strong, nonatomic) UIImageView *bg2;
@property (strong, nonatomic) UIImageView *bg3;
@property (strong, nonatomic) UIImageView *bg4;
@property (strong, nonatomic) UIImageView *gift;
@property (strong, nonatomic) UIImageView *social;
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
    [TestFlight passCheckpoint:@"INTRODUCTION_LOADED_VIEW"];
    
    
    // background1
    self.bg1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg1"]];
    self.bg1.center = self.view.center;
    self.bg1.frame = CGRectOffset(
                                  self.bg1.frame,
                                  0,
                                  0
                                  );
    [self.scrollView addSubview:self.bg1];
    
    // background2
    self.bg2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2"]];
    self.bg2.center = self.view.center;
    self.bg2.frame = CGRectOffset(
                                  self.bg2.frame,
                                  self.view.frame.size.width,
                                  0
                                  );
    [self.scrollView addSubview:self.bg2];
    
    // background3
    self.bg3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg3"]];
    self.bg3.center = self.view.center;
    self.bg3.frame = CGRectOffset(
                                  self.bg3.frame,
                                  self.view.frame.size.width*2,
                                  0
                                  );
    [self.scrollView addSubview:self.bg3];
    
    // background4
    self.bg4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg4"]];
    self.bg4.center = self.view.center;
    self.bg4.frame = CGRectOffset(
                                  self.bg4.frame,
                                  self.view.frame.size.width*3,
                                  0
                                  );
    [self.scrollView addSubview:self.bg4];
    
    
    
    // put a unicorn in the middle of page two, hidden
    self.unicorn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoLanding"]];
    self.unicorn.center = self.view.center;
    self.unicorn.frame = CGRectOffset(
                                      self.unicorn.frame,
                                      0,
                                      self.view.frame.size.height/2 - 80
                                      );
    self.unicorn.alpha = 1.0f;
    [self.scrollView addSubview:self.unicorn];
    
    // put a logo on top of it
    self.wordmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"us"]];
    self.wordmark.center = self.view.center;
    self.wordmark.frame = CGRectOffset(
                                       self.wordmark.frame,
                                       self.view.frame.size.width,
                                       0
                                       );
    [self.scrollView addSubview:self.wordmark];
    
    // gift
    self.gift = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gift"]];
    self.gift.center = self.view.center;
    self.gift.frame = CGRectOffset(
                                  self.gift.frame,
                                  self.view.frame.size.width*2,
                                  -40
                                  );
    [self.scrollView addSubview:self.gift];
    
    // gift
    self.social = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"social"]];
    self.social.center = self.view.center;
    self.social.frame = CGRectOffset(
                                   self.social.frame,
                                   self.view.frame.size.width*3,
                                   0
                                   );
    [self.scrollView addSubview:self.social];
    
    
    
//    FIRST PAGE
    UILabel *firstPageText = [[UILabel alloc] init];
    firstPageText.font = [UIFont systemFontOfSize:28];
    firstPageText.text = @"Narrowing the Distance";
    firstPageText.textColor = [UIColor colorWithRed:0xb6/255.0f
                                              green:0xe2/255.0f
                                               blue:0xe9/255.0f alpha:1];
    
    [firstPageText sizeToFit];
    firstPageText.center = self.view.center;
    
    firstPageText.frame = CGRectOffset(firstPageText.frame, 0, -self.view.frame.size.height/2 + 200);
    
    UILabel *firstPageTextSub = [[UILabel alloc] init];
    firstPageTextSub.font = [UIFont systemFontOfSize:17];
    firstPageTextSub.text = @"between you and those you care about";
    firstPageTextSub.textColor = [UIColor colorWithRed:0xf3/255.0f
                                                 green:0x7a/255.0f
                                                  blue:0x62/255.0f alpha:1];
    
    [firstPageTextSub sizeToFit];
    firstPageTextSub.center = self.view.center;
    firstPageTextSub.frame = CGRectOffset(firstPageTextSub.frame, 0, -self.view.frame.size.height/2 + 230);
    
    
//    UILabel *firstPageDesc = [[UILabel alloc] init];
//    firstPageDesc.text = @"Providing an unexpected gift at an unexpected time.";
//    firstPageDesc.textColor = [UIColor whiteColor];
//    
//    [firstPageDesc sizeToFit];
//    firstPageDesc.center = self.view.center;
//    firstPageDesc.frame = CGRectOffset(firstPageDesc.frame, 0, -self.view.frame.size.height/2 + 100);
//
//    [self.scrollView addSubview:firstPageDesc];
    
    [self.scrollView addSubview:firstPageText];
    [self.scrollView addSubview:firstPageTextSub];
    
//    SECOND PAGE
    
    UILabel *secondPageText = [[UILabel alloc] init];
    secondPageText.font = [UIFont systemFontOfSize:28];
    secondPageText.text = @"Locate";
    secondPageText.textColor = [UIColor colorWithRed:0xf3/255.0f
                                               green:0x7a/255.0f
                                                blue:0x62/255.0f alpha:1];
    [secondPageText sizeToFit];
    secondPageText.center = self.view.center;
    secondPageText.frame = CGRectOffset(secondPageText.frame, xForPage(2), -self.view.frame.size.height/2 + 60);
    [self.scrollView addSubview:secondPageText];
    
    UILabel *secondPageTextDesc = [[UILabel alloc] init];
    secondPageTextDesc.lineBreakMode = NSLineBreakByWordWrapping;
    secondPageTextDesc.numberOfLines = 2;
    secondPageTextDesc.textAlignment= UITextAlignmentCenter;
    secondPageTextDesc.text = @"Choose the location of a loved one";
    secondPageTextDesc.textColor = [UIColor whiteColor];
    [secondPageTextDesc sizeToFit];
    secondPageTextDesc.center = self.view.center;
    secondPageTextDesc.frame = CGRectOffset(secondPageTextDesc.frame, xForPage(2), -self.view.frame.size.height/2 + 100);
    [self.scrollView addSubview:secondPageTextDesc];
    UILabel *secondPageTextDesc2 = [[UILabel alloc] init];
    secondPageTextDesc2.lineBreakMode = NSLineBreakByWordWrapping;
    secondPageTextDesc2.numberOfLines = 2;
    secondPageTextDesc2.textAlignment= UITextAlignmentCenter;
    secondPageTextDesc2.text = @"whom you'd like us to surprise";
    secondPageTextDesc2.textColor = [UIColor whiteColor];
    [secondPageTextDesc2 sizeToFit];
    secondPageTextDesc2.center = self.view.center;
    secondPageTextDesc2.frame = CGRectOffset(secondPageTextDesc2.frame, xForPage(2), -self.view.frame.size.height/2 + 120);
    [self.scrollView addSubview:secondPageTextDesc2];
    UILabel *secondPageTextDesc3 = [[UILabel alloc] init];
    secondPageTextDesc3.lineBreakMode = NSLineBreakByWordWrapping;
    secondPageTextDesc3.numberOfLines = 2;
    secondPageTextDesc3.textAlignment= UITextAlignmentCenter;
    secondPageTextDesc3.text = @"with an unexpected gift";
    secondPageTextDesc3.textColor = [UIColor whiteColor];
    [secondPageTextDesc3 sizeToFit];
    secondPageTextDesc3.center = self.view.center;
    secondPageTextDesc3.frame = CGRectOffset(secondPageTextDesc3.frame, xForPage(2), -self.view.frame.size.height/2 + 140);
    [self.scrollView addSubview:secondPageTextDesc3];
    
    
//    THIRD_PAGE
    
    UILabel *thirdPageText = [[UILabel alloc] init];
    thirdPageText.font = [UIFont systemFontOfSize:28];
    thirdPageText.text = @"Select";
    thirdPageText.textColor = [UIColor colorWithRed:0xf3/255.0f
                                              green:0x7a/255.0f
                                               blue:0x62/255.0f alpha:1];
    [thirdPageText sizeToFit];
    thirdPageText.center = self.view.center;
    thirdPageText.frame = CGRectOffset(thirdPageText.frame, xForPage(3), -self.view.frame.size.height/2 + 60);
    [self.scrollView addSubview:thirdPageText];
    
    UILabel *thirdPageTextDesc = [[UILabel alloc] init];
    thirdPageTextDesc.text = @"Fill out a connection request of the";
    thirdPageTextDesc.lineBreakMode = NSLineBreakByWordWrapping;
    thirdPageTextDesc.numberOfLines = 2;
    thirdPageTextDesc.textAlignment= UITextAlignmentCenter;
    thirdPageTextDesc.textColor = [UIColor whiteColor];
    [thirdPageTextDesc sizeToFit];
    thirdPageTextDesc.center = self.view.center;
    thirdPageTextDesc.frame = CGRectOffset(thirdPageTextDesc.frame, xForPage(3), -self.view.frame.size.height/2 + 100);
    [self.scrollView addSubview:thirdPageTextDesc];
    UILabel *thirdPageTextDesc2 = [[UILabel alloc] init];
    thirdPageTextDesc2.text = @"gift you’d like us to bring to them";
    thirdPageTextDesc2.lineBreakMode = NSLineBreakByWordWrapping;
    thirdPageTextDesc2.numberOfLines = 2;
    thirdPageTextDesc2.textAlignment= UITextAlignmentCenter;
    thirdPageTextDesc2.textColor = [UIColor whiteColor];
    [thirdPageTextDesc2 sizeToFit];
    thirdPageTextDesc2.center = self.view.center;
    thirdPageTextDesc2.frame = CGRectOffset(thirdPageTextDesc2.frame, xForPage(3), -self.view.frame.size.height/2 + 120);
    [self.scrollView addSubview:thirdPageTextDesc2];
    
    
//    FOURTH PAGE
    
    UILabel *fourthPageText = [[UILabel alloc] init];
    fourthPageText.font = [UIFont systemFontOfSize:28];
    fourthPageText.text = @"Enjoy";
    fourthPageText.textColor = [UIColor colorWithRed:0xf3/255.0f
                                               green:0x7a/255.0f
                                                blue:0x62/255.0f alpha:1];
    [fourthPageText sizeToFit];
    fourthPageText.center = self.view.center;
    fourthPageText.frame = CGRectOffset(fourthPageText.frame, xForPage(4), -self.view.frame.size.height/2 + 60);
    
    UILabel *fourthPageTextDesc = [[UILabel alloc] init];
    fourthPageTextDesc.text = @"Watch the video, view the pics";
    fourthPageTextDesc.lineBreakMode = NSLineBreakByWordWrapping;
    fourthPageTextDesc.numberOfLines = 2;
    fourthPageTextDesc.textAlignment= UITextAlignmentCenter;
    fourthPageTextDesc.textColor = [UIColor whiteColor];
    [fourthPageTextDesc sizeToFit];
    fourthPageTextDesc.center = self.view.center;
    fourthPageTextDesc.frame = CGRectOffset(fourthPageTextDesc.frame, xForPage(4), -self.view.frame.size.height/2 + 100);
    UILabel *fourthPageTextDesc2 = [[UILabel alloc] init];
    fourthPageTextDesc2.text = @"and read our post to see how they ";
    fourthPageTextDesc2.lineBreakMode = NSLineBreakByWordWrapping;
    fourthPageTextDesc2.numberOfLines = 2;
    fourthPageTextDesc2.textAlignment= UITextAlignmentCenter;
    fourthPageTextDesc2.textColor = [UIColor whiteColor];
    [fourthPageTextDesc2 sizeToFit];
    fourthPageTextDesc2.center = self.view.center;
    fourthPageTextDesc2.frame = CGRectOffset(fourthPageTextDesc2.frame, xForPage(4), -self.view.frame.size.height/2 + 120);
    UILabel *fourthPageTextDesc3 = [[UILabel alloc] init];
    fourthPageTextDesc3.text = @"reacted then share it!";
    fourthPageTextDesc3.lineBreakMode = NSLineBreakByWordWrapping;
    fourthPageTextDesc3.numberOfLines = 2;
    fourthPageTextDesc3.textAlignment= UITextAlignmentCenter;
    fourthPageTextDesc3.textColor = [UIColor whiteColor];
    [fourthPageTextDesc3 sizeToFit];
    fourthPageTextDesc3.center = self.view.center;
    fourthPageTextDesc3.frame = CGRectOffset(fourthPageTextDesc3.frame, xForPage(4), -self.view.frame.size.height/2 + 140);
    
    
    UILabel *fourthPageTextDesc4 = [[UILabel alloc] init];
    fourthPageTextDesc4.text = @"By clicking 'Check out some connections'";
    fourthPageTextDesc4.font = [UIFont systemFontOfSize:10];
    fourthPageTextDesc4.lineBreakMode = NSLineBreakByWordWrapping;
    fourthPageTextDesc4.numberOfLines = 2;
    fourthPageTextDesc4.textAlignment= UITextAlignmentCenter;
    fourthPageTextDesc4.textColor = [UIColor whiteColor];
    [fourthPageTextDesc4 sizeToFit];
    fourthPageTextDesc4.center = self.view.center;
    fourthPageTextDesc4.frame = CGRectOffset(fourthPageTextDesc4.frame, xForPage(4), self.view.frame.size.height/2 - 50);
    
    UILabel *fourthPageTextDesc5 = [[UILabel alloc] init];
    fourthPageTextDesc5.text = @"you agree to our EULA terms";
    fourthPageTextDesc5.font = [UIFont systemFontOfSize:10];
    fourthPageTextDesc5.lineBreakMode = NSLineBreakByWordWrapping;
    fourthPageTextDesc5.numberOfLines = 2;
    fourthPageTextDesc5.textAlignment= UITextAlignmentCenter;
    fourthPageTextDesc5.textColor = [UIColor whiteColor];
    
    [fourthPageTextDesc5 sizeToFit];
    fourthPageTextDesc5.center = self.view.center;
    fourthPageTextDesc5.frame = CGRectOffset(fourthPageTextDesc5.frame, xForPage(4), self.view.frame.size.height/2 - 35);
    
    
    UIButton *closeIntroEula = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [closeIntroEula addTarget:self
                   action:@selector(showEula)
         forControlEvents:UIControlEventTouchDown];
    [closeIntroEula setTitle:@"End User License Agreement (EULA)" forState:UIControlStateNormal];
    [closeIntroEula sizeToFit];
    [closeIntroEula setFont:[UIFont systemFontOfSize:10]];
    closeIntroEula.center = self.view.center;
    closeIntroEula.frame = CGRectOffset(closeIntroEula.frame, xForPage(4), self.view.frame.size.height/2 - 20);
    [self.scrollView addSubview:closeIntroEula];
    
    
    
    UIButton *closeIntro = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [closeIntro addTarget:self
                   action:@selector(finishIntroToMainView)
         forControlEvents:UIControlEventTouchDown];
    [closeIntro setTitle:@"Check out some connections" forState:UIControlStateNormal];
    [closeIntro sizeToFit];
    closeIntro.center = self.view.center;
    closeIntro.frame = CGRectOffset(closeIntro.frame, xForPage(4), self.view.frame.size.height/2 - 80);
    [self.scrollView addSubview:closeIntro];
    [self.scrollView addSubview:fourthPageText];
    [self.scrollView addSubview:fourthPageTextDesc];
    [self.scrollView addSubview:fourthPageTextDesc2];
    [self.scrollView addSubview:fourthPageTextDesc3];
    [self.scrollView addSubview:fourthPageTextDesc4];
    [self.scrollView addSubview:fourthPageTextDesc5];
    
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

-(void)showEula {
    UIViewController *eulaView = [alcEULAViewController new];
    eulaView.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:eulaView animated:YES completion:nil];
}

@end

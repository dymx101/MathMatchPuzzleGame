//
//  FDAdmobManager.h
//  MathMatch
//
//  Created by Dong Yiming on 1/1/15.
//  Copyright (c) 2015 Computer Lab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FDAdmobManager : NSObject

@property (nonatomic, readonly) BOOL    isBannerReady;
@property (nonatomic, readonly) BOOL    isInterstitialReady;
@property(nonatomic, strong)    UIView   *bannerView;
@property (nonatomic, readonly) CGFloat  bannerHeight;

+(instancetype)sharedManager;

-(void)setRootVC:(UIViewController *)rootVC;

-(void)requestAds;

-(void)showInterstitial;

-(void)showBanner;

@end

#define FD_NOTIFICATION_AD_BANNER_READY              @"FD_NOTIFICATION_AD_BANNER_READY"
#define FD_NOTIFICATION_ADMOB_INTERSTITIAL_READY        @"FD_NOTIFICATION_ADMOB_INTERSTITIAL_READY"

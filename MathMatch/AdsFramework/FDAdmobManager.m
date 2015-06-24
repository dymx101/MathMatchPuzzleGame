//
//  FDAdmobManager.m
//  MathMatch
//
//  Created by Dong Yiming on 1/1/15.
//  Copyright (c) 2015 Computer Lab. All rights reserved.
//

#import "FDAdmobManager.h"
#import "NSObject+BeeNotification.h"
#import <Chartboost/Chartboost.h>
#import <Chartboost/CBNewsfeed.h>
#import <iAd/iAd.h>
#import "HMIAPHelper.h"

/* Frameworks needed by Admob & ChartBoost
 AdSupport
 AudioToolbox
 AVFoundation
 CoreGraphics
 CoreTelephony
 EventKit
 EventKitUI
 MessageUI
 StoreKit
 SystemConfiguration
 UIKit
 */

#define DEFAULT_BANNER_HEIGHT           (50)
#define DEFAULT_BANNER_HEIGHT_PAD       (90)

#define ADMOB_BANNER_UNIT_ID        @"ca-app-pub-1354856141599199/2904645865"
#define ADMOB_INTERSTITIAL_UNIT_ID  @"ca-app-pub-1354856141599199/4381379062"

#define CHARTBOOST_APP_ID           @"54b2794004b0167ddb366e00"
#define CHARTBOOST_APP_SIGNATURE    @"98629ca1ebbf6ecab5dbad8df22eb288f61d7b96"


//App Name: Crazy Math Match
//App Id: 54b2794004b0167ddb366e00
//App Signature: 98629ca1ebbf6ecab5dbad8df22eb288f61d7b96



typedef NS_ENUM(NSInteger, EFDBannerType) {
    kFDBannerAdmob
    , kFDBannerIAd
};


@interface FDAdmobManager ()
<GADBannerViewDelegate, GADInterstitialDelegate, ChartboostDelegate, ADBannerViewDelegate> {
    UIViewController    *_rootVC;
    GADInterstitial     *_interstitial;
    
    BOOL                _neverShowedInterstitial;
    NSInteger           _adMobInterstitalShowTimes;
    
    GADBannerView       *_bannerAdmob;
    ADBannerView        *_bannerIAd;
    
    BOOL                _isAdmobBannerReady;
    BOOL                _isIadBannerReady;
}

@end

@implementation FDAdmobManager

-(CGFloat)bannerHeight {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? DEFAULT_BANNER_HEIGHT_PAD : DEFAULT_BANNER_HEIGHT;
}

+(instancetype)sharedManager {
    static FDAdmobManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FDAdmobManager new];
    });
    
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        [self initBanner];
        
        [self initChartboost];
    }
    return self;
}

-(void)setRootVC:(UIViewController *)rootVC {
    _rootVC = rootVC;
    _bannerAdmob.rootViewController = _rootVC;
}

-(void)initBanner {
    CGRect rc = [UIScreen mainScreen].bounds;
    rc.size.height = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? DEFAULT_BANNER_HEIGHT_PAD : DEFAULT_BANNER_HEIGHT;
    _bannerView = [[UIView alloc] initWithFrame:rc];
    
    ///
    _bannerIAd = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    _bannerIAd.delegate = self;
    _bannerIAd.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_bannerView addSubview:_bannerIAd];
    _bannerIAd.hidden = YES;
    
    ///
    _bannerAdmob = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    _bannerAdmob.adUnitID = ADMOB_BANNER_UNIT_ID;
    
    _bannerAdmob.rootViewController = _rootVC;
    _bannerAdmob.delegate = self;
    _bannerAdmob.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_bannerView addSubview:_bannerAdmob];
}

- (void)initChartboost {
    
    if ([SharedIAP hasRemovedAds]) {
        return;
    }
    
    // Initialize the Chartboost library
    [Chartboost startWithAppId:CHARTBOOST_APP_ID
                  appSignature:CHARTBOOST_APP_SIGNATURE
                      delegate:self];
    [Chartboost cacheInterstitial:CBLocationHomeScreen];
}


-(void)requestAds {
    
    if ([SharedIAP hasRemovedAds]) {
        return;
    }
    
    [self requestAdmobBanner];
    [self requestAdmobInterstitial];
}

-(GADRequest *)newRequest {
    GADRequest *request = [GADRequest request];
    request.testDevices =  @[kGADSimulatorID];
    //request.testDevices =  @[ GAD_SIMULATOR_ID, @"28298224a065cc39eb8972e045c6f77a"];
    return request;
}

-(void)requestAdmobBanner {
    GADRequest *request = [self newRequest];
    [_bannerAdmob loadRequest:request];
}

-(void)requestAdmobInterstitial {
    _interstitial = [[GADInterstitial alloc] initWithAdUnitID:ADMOB_INTERSTITIAL_UNIT_ID];
    _interstitial.delegate = self;
    
    GADRequest *request = [self newRequest];
    [_interstitial loadRequest:request];
}

-(void)showInterstitial {
    
    if ([SharedIAP hasRemovedAds]) {
        return;
    }
    
    if (_interstitial.isReady && _adMobInterstitalShowTimes < 2) {
        [_interstitial presentFromRootViewController:_rootVC];
        [self postNotification:FD_NOTIFICATION_ADMOB_INTERSTITIAL_READY withObject:@(NO)];
        
        [self showBannerType:kFDBannerAdmob];
        
        _adMobInterstitalShowTimes++;
        
    } else {
        
        [self cacheCbInterstitialIfNotWithLocation:CBLocationHomeScreen];
        
        [Chartboost showInterstitial:CBLocationHomeScreen];
        
        [self showBannerType:kFDBannerIAd];
        
        _adMobInterstitalShowTimes = 0;
    }
}

-(void)showBannerType:(EFDBannerType)type {
    _bannerAdmob.hidden = YES;
    _bannerIAd.hidden = YES;
    
    if (type == kFDBannerAdmob && _isAdmobBannerReady) {
        _bannerAdmob.hidden = NO;
    } else if (type == kFDBannerIAd && _isIadBannerReady) {
        _bannerIAd.hidden = NO;
    } else if (_isAdmobBannerReady) {
        _bannerAdmob.hidden = NO;
    } else {
        _bannerIAd.hidden = NO;
    }
    
    //[self requestAdmobBanner];
}


-(void)showBanner {
    if (_isAdmobBannerReady) {
        [self showBannerType:kFDBannerAdmob];
    } else {
        [self showBannerType:kFDBannerIAd];
    }
}


#pragma mark - properties
-(BOOL)isInterstitialReady {
    return _interstitial.isReady;
}

-(BOOL)isBannerReady {
    return _isAdmobBannerReady || _isIadBannerReady;
}


#pragma mark - iad banner delegate
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    _isIadBannerReady = YES;
    
    [self postNotification:FD_NOTIFICATION_AD_BANNER_READY];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    _isIadBannerReady = NO;
    _bannerAdmob.hidden = !_isAdmobBannerReady;
}


#pragma mark - banner delegate
- (void)adViewDidReceiveAd:(GADBannerView *)view {
    _isAdmobBannerReady = YES;
    
    [self postNotification:FD_NOTIFICATION_AD_BANNER_READY];
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    _isAdmobBannerReady = NO;
    _bannerIAd.hidden = !_isIadBannerReady;
}

#pragma mark - interstitial delegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    
    if (_neverShowedInterstitial) {
        _neverShowedInterstitial = NO;
        [self showInterstitial];
        
    } else {
        [self postNotification:FD_NOTIFICATION_ADMOB_INTERSTITIAL_READY withObject:@(YES)];
    }
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    [self requestAdmobInterstitial];
}

#pragma mark - chartboost delegate
- (void)didDismissInterstitial:(CBLocation)location {
    [self cacheCbInterstitialIfNotWithLocation:location];
}

- (void)didFailToLoadInterstitial:(CBLocation)location
                        withError:(CBLoadError)error {
    [self cacheCbInterstitialIfNotWithLocation:location];
}

-(void)cacheCbInterstitialIfNotWithLocation:(CBLocation)location {
    if (![Chartboost hasInterstitial:location]) {
        [Chartboost cacheInterstitial:location];
    }
}

@end

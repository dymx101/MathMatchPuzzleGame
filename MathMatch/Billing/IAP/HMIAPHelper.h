//
//  HMIAPHelper.h
//  MucixDown
//
//  Created by Dong Yiming on 6/21/14.
//  Copyright (c) 2014 FS. All rights reserved.
//

#import "IAPHelper.h"

@interface HMIAPHelper : IAPHelper

+ (HMIAPHelper *)sharedInstance;

-(void)removeAds;

-(BOOL)hasRemovedAds;

-(void)prepare;

@end

#define SharedIAP     ([HMIAPHelper sharedInstance])

#define PRODUCT_ID_REMOVE_ADS           @"removeAds"

#define NOTIFY_ID_REMOVE_ADS            @"NOTIFY_ID_REMOVE_ADS"
#define NOTIFY_ID_RESTORE_ADS           @"NOTIFY_ID_RESTORE_ADS"

#define USER_DEFAULT_KEY_ADS_REMOVED    @"USER_DEFAULT_KEY_ADS_REMOVED"



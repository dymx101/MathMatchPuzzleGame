//
//  HMIAPHelper.m
//  MucixDown
//
//  Created by Dong Yiming on 6/21/14.
//  Copyright (c) 2014 FS. All rights reserved.
//

#import "HMIAPHelper.h"
#import "IAPProduct.h"



@implementation HMIAPHelper

+ (HMIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static HMIAPHelper * sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init]; });
    
    return sharedInstance;
}


- (id)init {
    
    IAPProduct * removeAds = [[IAPProduct alloc] initWithProductIdentifier:PRODUCT_ID_REMOVE_ADS];
    NSMutableDictionary * products = [@{removeAds.productIdentifier: removeAds} mutableCopy];
    
    if ((self = [super initWithProducts:products])) {
        
    }
    
    return self;
}


- (void)provideContentForProductIdentifier: (NSString *)productIdentifier {
    
    if ([productIdentifier isEqualToString:PRODUCT_ID_REMOVE_ADS]) {
        
        [self unlockForProductIdentifier: PRODUCT_ID_REMOVE_ADS];
        
    }
}

- (void)takeBackContentForProductIdentifier: (NSString *)productIdentifier {
    if ([productIdentifier isEqualToString:PRODUCT_ID_REMOVE_ADS]) {
        
        [self lockForProductIdentifier: PRODUCT_ID_REMOVE_ADS];
        
    }
}

//- (void)notifyStatusForProduct:(IAPProduct *)product string:(NSString *)string {
//    
//    NSString *title = product.skProduct.localizedTitle;
//    
//    if (title.length) {
//        NSString * message = [NSString stringWithFormat:@"%@: %@", title, string];
//        JSNotifier *notify = [[JSNotifier alloc] initWithTitle:message];
//        [notify showFor:2.0];
//    }
//}

- (void)lockForProductIdentifier:(NSString *) productIdentifier {
    IAPProduct * product = self.products[productIdentifier];
    product.purchase = NO;
    
    if ([productIdentifier isEqualToString:PRODUCT_ID_REMOVE_ADS]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_DEFAULT_KEY_ADS_REMOVED];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self postNotification:NOTIFY_ID_RESTORE_ADS];
        
    }
}

- (void)unlockForProductIdentifier:(NSString *) productIdentifier {
    
    // 1
    IAPProduct * product = self.products[productIdentifier];
    product.purchase = YES;
    
    if ([productIdentifier isEqualToString:PRODUCT_ID_REMOVE_ADS]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_DEFAULT_KEY_ADS_REMOVED];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self postNotification:NOTIFY_ID_REMOVE_ADS];
        
    }
}

-(BOOL)hasRemovedAds {
    //return YES;
    return [[NSUserDefaults standardUserDefaults] boolForKey:USER_DEFAULT_KEY_ADS_REMOVED];
}

-(void)removeAds {
    IAPProduct *product = self.products[PRODUCT_ID_REMOVE_ADS];
    [self buyProduct:product];
}

-(void)prepare {
    // do nothing
}
    
@end

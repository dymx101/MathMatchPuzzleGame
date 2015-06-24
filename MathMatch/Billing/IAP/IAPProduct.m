//
//  IAPProduct.m
//  MucixDown
//
//  Created by Dong Yiming on 6/21/14.
//  Copyright (c) 2014 FS. All rights reserved.
//

#import "IAPProduct.h"

@implementation IAPProduct

- (id)initWithProductIdentifier:(NSString *)productIdentifier {
    if ((self = [super init])) {
        self.availableForPurchase = NO;
        self.productIdentifier = productIdentifier;
        self.skProduct = nil;
    }
    return self;
}


- (BOOL)allowedToPurchase {
    
    if (!self.availableForPurchase) return NO;
    
    if (self.purchaseInProgress) return NO;
    
    if (self.purchase) return NO;
    
    return YES;
}


@end

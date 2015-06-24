//
//  IAPProduct.h
//  MucixDown
//
//  Created by Dong Yiming on 6/21/14.
//  Copyright (c) 2014 FS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKProduct;

@interface IAPProduct : NSObject

- (id)initWithProductIdentifier:(NSString *)productIdentifier;
- (BOOL)allowedToPurchase;

@property (nonatomic, assign) BOOL availableForPurchase;
@property (nonatomic, assign) BOOL purchaseInProgress;
@property (nonatomic, assign) BOOL purchase;

@property (nonatomic, strong) NSString * productIdentifier;
@property (nonatomic, strong) SKProduct * skProduct;

@end

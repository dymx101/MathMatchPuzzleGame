//
//  IAPHelper.h
//  MucixDown
//
//  Created by Dong Yiming on 6/21/14.
//  Copyright (c) 2014 FS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef void (^RequestProductsCompletionHandler) (BOOL success, NSArray * products);
typedef void(^PaymentQueueUpdatedTransactionsBlock)(SKPaymentQueue *queue, NSArray *transactions);

@class IAPProduct;

@interface IAPHelper : NSObject
//- (void)requestProductsWithProductIdentifiers:(NSSet *)productIdentifiers;

- (id)initWithProducts:(NSMutableDictionary *)products;


- (void)buyProduct:(IAPProduct *)product;

- (void)restoreCompletedTransactions;

@property (nonatomic, strong) NSMutableDictionary * products;

@end

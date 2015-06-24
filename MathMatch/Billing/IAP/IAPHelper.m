//
//  IAPHelper.m
//  MucixDown
//
//  Created by Dong Yiming on 6/21/14.
//  Copyright (c) 2014 FS. All rights reserved.
//

#import "IAPHelper.h"
#import "IAPProduct.h"
#import <StoreKit/StoreKit.h>
#import "CargoBay.h"


#define TEST_RECIEPT    @"ewoJInNpZ25hdHVyZSIgPSAiQXAwaHRSaDZGK0Z2YXhhK0lqTzRpN2NxQnlTZ05wb09BOWF1RWdYMkNmSDFNVjJXOHNtZ2M1N3h5M3lYcG5QYlFKVFdxN29nOWhtRUlSWlZMK3Z5Zzl5angxNFhWYzZSK2pxT2pSeXV1VEhFcm16bE9nZ3ViWUowVUZkNjRBYS9GNFN0eVZqVmUzb3JSVDRoQlBzU29zWlpjM0NoUjlmVlY0MVdGei9NMEtHYUFBQURWekNDQTFNd2dnSTdvQU1DQVFJQ0NCdXA0K1BBaG0vTE1BMEdDU3FHU0liM0RRRUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pTQkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIzSmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEUwTURZd056QXdNREl5TVZvWERURTJNRFV4T0RFNE16RXpNRm93WkRFak1DRUdBMVVFQXd3YVVIVnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVrRndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NXNWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZMEFNSUdKQW9HQkFNbVRFdUxnamltTHdSSnh5MW9FZjBlc1VORFZFSWU2d0Rzbm5hbDE0aE5CdDF2MTk1WDZuOTNZTzdnaTNvclBTdXg5RDU1NFNrTXArU2F5Zzg0bFRjMzYyVXRtWUxwV25iMzRucXlHeDlLQlZUeTVPR1Y0bGpFMU93QytvVG5STStRTFJDbWVOeE1iUFpoUzQ3VCtlWnRERWhWQjl1c2szK0pNMkNvZ2Z3bzdBZ01CQUFHamNqQndNQjBHQTFVZERnUVdCQlNKYUVlTnVxOURmNlpmTjY4RmUrSTJ1MjJzc0RBTUJnTlZIUk1CQWY4RUFqQUFNQjhHQTFVZEl3UVlNQmFBRkRZZDZPS2RndElCR0xVeWF3N1hRd3VSV0VNNk1BNEdBMVVkRHdFQi93UUVBd0lIZ0RBUUJnb3Foa2lHOTJOa0JnVUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQWVhSlYyVTUxcnhmY3FBQWU1QzIvZkVXOEtVbDRpTzRsTXV0YTdONlh6UDFwWkl6MU5ra0N0SUl3ZXlOajVVUllISytIalJLU1U5UkxndU5sMG5rZnhxT2JpTWNrd1J1ZEtTcTY5Tkluclp5Q0Q2NlI0Szc3bmI5bE1UQUJTU1lsc0t0OG9OdGxoZ1IvMWtqU1NSUWNIa3RzRGNTaVFHS01ka1NscDRBeVhmN3ZuSFBCZTR5Q3dZVjJQcFNOMDRrYm9pSjNwQmx4c0d3Vi9abEwyNk0ydWVZSEtZQ3VYaGRxRnd4VmdtNTJoM29lSk9PdC92WTRFY1FxN2VxSG02bTAzWjliN1BSellNMktHWEhEbU9Nazd2RHBlTVZsTERQU0dZejErVTNzRHhKemViU3BiYUptVDdpbXpVS2ZnZ0VZN3h4ZjRjemZIMHlqNXdOelNHVE92UT09IjsKCSJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREUwTFRBNExURXlJREl3T2pFeU9qSXlJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluQjFjbU5vWVhObExXUmhkR1V0YlhNaUlEMGdJakUwTURjNE9UazFOREV3TURBaU93b0pJblZ1YVhGMVpTMXBaR1Z1ZEdsbWFXVnlJaUE5SUNJek9XSmlaVGt5WkRNMk9EQTFZVEZpTjJJM1ptVXhOak13Wm1aaE5qSmxNR1ppTjJZek1XVTBJanNLQ1NKdmNtbG5hVzVoYkMxMGNtRnVjMkZqZEdsdmJpMXBaQ0lnUFNBaU1UQXdNREF3TURFeE9UazROREU0TVNJN0Nna2laWGh3YVhKbGN5MWtZWFJsSWlBOUlDSXhOREEzT0RrNU9EUXhNREF3SWpzS0NTSjBjbUZ1YzJGamRHbHZiaTFwWkNJZ1BTQWlNVEF3TURBd01ERXhPVGs0TkRFNE1TSTdDZ2tpYjNKcFoybHVZV3d0Y0hWeVkyaGhjMlV0WkdGMFpTMXRjeUlnUFNBaU1UUXdOemc1T1RVME1qQXdNQ0k3Q2draWQyVmlMVzl5WkdWeUxXeHBibVV0YVhSbGJTMXBaQ0lnUFNBaU1UQXdNREF3TURBeU9EUTVOekF3T1NJN0Nna2lZblp5Y3lJZ1BTQWlNU0k3Q2draWRXNXBjWFZsTFhabGJtUnZjaTFwWkdWdWRHbG1hV1Z5SWlBOUlDSTJNRVpHTUVVMVJDMDNNalpDTFRRM1JEQXRRVEJHTWkxRlFrUkdSRUpEUmtaQ016WWlPd29KSW1WNGNHbHlaWE10WkdGMFpTMW1iM0p0WVhSMFpXUXRjSE4wSWlBOUlDSXlNREUwTFRBNExURXlJREl3T2pFM09qSXhJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkltbDBaVzB0YVdRaUlEMGdJamc1TmpReE5UTXlNU0k3Q2draVpYaHdhWEpsY3kxa1lYUmxMV1p2Y20xaGRIUmxaQ0lnUFNBaU1qQXhOQzB3T0MweE15QXdNem94TnpveU1TQkZkR012UjAxVUlqc0tDU0p3Y205a2RXTjBMV2xrSWlBOUlDSmpiMjB1WjJGblpXbHVMbkJ5YnpGdGIyNTBhQ0k3Q2draWNIVnlZMmhoYzJVdFpHRjBaU0lnUFNBaU1qQXhOQzB3T0MweE15QXdNem94TWpveU1TQkZkR012UjAxVUlqc0tDU0p2Y21sbmFXNWhiQzF3ZFhKamFHRnpaUzFrWVhSbElpQTlJQ0l5TURFMExUQTRMVEV6SURBek9qRXlPakl5SUVWMFl5OUhUVlFpT3dvSkltSnBaQ0lnUFNBaVkyOXRMbWRoWjJWcGJpNW5ZV2RsYVc1QmNIQWlPd29KSW5CMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREUwTFRBNExURXlJREl3T2pFeU9qSXhJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluRjFZVzUwYVhSNUlpQTlJQ0l4SWpzS2ZRPT0iOwoJImVudmlyb25tZW50IiA9ICJTYW5kYm94IjsKCSJwb2QiID0gIjEwMCI7Cgkic2lnbmluZy1zdGF0dXMiID0gIjAiOwp9"

@interface IAPHelper () {
}
@end

@implementation IAPHelper

- (id)initWithProducts:(NSMutableDictionary *)products {
    
    if ((self = [super init])) {
        _products = products;
        
        [[CargoBay sharedManager] setPaymentQueueUpdatedTransactionsBlock:self.paymentQueueUpdatedTransactionsBlock];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:[CargoBay sharedManager]];
    }
    return self;
}

- (void)getProducts:(void(^)(NSArray *products, NSError *error))completionBlock
{
    void (^successHandler)(NSArray *, NSArray *) = ^(NSArray *products, NSArray *invalidIdentifiers) {
        
        NSLog(@"Products: %@", products);
        NSLog(@"Invalid Identifiers: %@", invalidIdentifiers);
        
        for (SKProduct * skProduct in products) {
            IAPProduct * product = _products[skProduct.productIdentifier];
            product.skProduct = skProduct;
            product.availableForPurchase = YES;
        }
        
        ///
        for (NSString * invalidProductIdentifier in invalidIdentifiers) {
            IAPProduct * product = _products[invalidProductIdentifier];
            product.availableForPurchase = NO;
            NSLog(@"Invalid product identifier, removing: %@", invalidProductIdentifier);
        }
        
        ///
        NSMutableArray * availableProducts = [NSMutableArray array];
        for (IAPProduct * product in _products.allValues) {
            if (product.availableForPurchase) {
                [availableProducts addObject:product];
            }
        }
        
        if (completionBlock) { completionBlock(availableProducts, nil); }
        
    };
    
    void (^errorHandler)(NSError *) = ^(NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        if (completionBlock) { completionBlock(nil, error); }
        
    };
    
    ///
    NSMutableSet * productIdentifiers = [NSMutableSet setWithCapacity:_products.count];
    
    for (IAPProduct * product in _products.allValues) {
        product.availableForPurchase = NO;
        [productIdentifiers addObject:product.productIdentifier];
    }
    
    //NSSet *productIndentifierSet = [NSSet setWithArray:self.productIDs];
    [[CargoBay sharedManager] productsWithIdentifiers:productIdentifiers
                                              success:successHandler
                                              failure:errorHandler];
}



- (void)verifyAndReport:(SKPaymentTransaction *)transaction
{
    [[CargoBay sharedManager] verifyTransaction:transaction password:nil success:^(NSDictionary *receipt) {
        
        NSLog(@"Purchased stuff:\n %@", transaction.originalTransaction.payment.productIdentifier);
        NSLog(@"Receipt: %@", receipt);
        
        //NSData *reciept = CBTransactionReceiptFromPaymentTransaction(transaction);
        //NSString *base64CodedReceipt = CBBase64EncodedStringFromData(reciept);
        
        [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
        
        NSInteger status = [[receipt objectForKey:@"status"] integerValue];
        if (status == CargoBayStatusReceiptValidButSubscriptionExpired) { // expired
            [self takeBackContentForTransaction:transaction productIdentifier:transaction.payment.productIdentifier];
        } else {
            [self provideContentForTransaction:transaction productIdentifier: transaction.payment.productIdentifier];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"Error %ld (%@)", (long)error.code, error.localizedDescription);
        
        [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    }];
}

- (PaymentQueueUpdatedTransactionsBlock)paymentQueueUpdatedTransactionsBlock;
{
    PaymentQueueUpdatedTransactionsBlock block = ^(SKPaymentQueue *queue, NSArray *transactions) {
        
        NSLog(@"%@, %@", queue, transactions);
        
        [transactions enumerateObjectsUsingBlock:^(SKPaymentTransaction *transaction, NSUInteger idx, BOOL *stop) {
            
            switch (transaction.transactionState) {
                    
                case SKPaymentTransactionStatePurchasing:
                    NSLog(@"Buying stuff:\n %@", transaction.payment.productIdentifier);
                    
                    break;
                    
                case SKPaymentTransactionStatePurchased: {
                    
                    [self verifyAndReport:transaction];
                    
                    break;
                }
                    
                case SKPaymentTransactionStateFailed: {
                    
                    if (transaction.error.code != SKErrorPaymentCancelled) {
                        [self takeBackContentForTransaction:transaction productIdentifier:transaction.payment.productIdentifier];
                    }
                    
                    [self failedTransaction:transaction];
                    
                } break;
                    
                case SKPaymentTransactionStateRestored: {
                    [self verifyAndReport:transaction];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase restored." message:@"All Ads are now removed." delegate:nil cancelButtonTitle:@"Cool" otherButtonTitles:nil];
                    [alert show];
                    
                    break;
                }
                default:
                    break;
            }
        }];
    };
    
    return block;
}


- (void)buyProduct:(IAPProduct *)product {
    
    //NSAssert(product.allowedToPurchase, @"This product isn'tallowed to be purchased!");
    
    void (^presentOptions)(NSArray *) = ^(NSArray *products) {
        
        if (!product.allowedToPurchase) {
            NSLog(@"can't buy %@...", product.productIdentifier);
            return;
        }
        
        product.purchaseInProgress = YES;
        SKPayment * payment = [SKPayment paymentWithProduct:product.skProduct];
        [[SKPaymentQueue defaultQueue] addPayment:payment];

    };
    
    ///
    [self getProducts:^(NSArray *products, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //[SVProgressHUD dismiss];
        }];
        presentOptions(products);
    }];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        //[SVProgressHUD showWithStatus:@"Loading"];
    }];
}


- (void)restoreCompletedTransactions {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}


#pragma mark - transaction handling
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"completeTransaction...");
    [self provideContentForTransaction:transaction productIdentifier:transaction.payment.productIdentifier];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"restoreTransaction...");
    [self provideContentForTransaction:transaction productIdentifier: transaction.originalTransaction.payment.productIdentifier];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    IAPProduct * product = _products[transaction.payment.productIdentifier];
    //[self notifyStatusForProductIdentifier: transaction.payment.productIdentifier string:@"Purchase failed."];
    product.purchaseInProgress = NO;
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}


#pragma mark - provide content
- (void)provideContentForTransaction: (SKPaymentTransaction *)transaction productIdentifier:(NSString *)productIdentifier {
    
    IAPProduct * product = _products[productIdentifier];
    
    [self provideContentForProductIdentifier:productIdentifier];
    //[self notifyStatusForProductIdentifier:productIdentifier string:@"Purchase complete!"];
    product.purchaseInProgress = NO;
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)takeBackContentForTransaction: (SKPaymentTransaction *)transaction productIdentifier:(NSString *)productIdentifier {
    
    IAPProduct * product = _products[productIdentifier];
    
    [self takeBackContentForProductIdentifier:productIdentifier];
    //[self notifyStatusForProductIdentifier:productIdentifier string:@"Purchase complete!"];
    product.purchaseInProgress = NO;
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)takeBackContentForProductIdentifier: (NSString *)productIdentifier {
}

- (void)provideContentForProductIdentifier: (NSString *)productIdentifier {
}


//#pragma mark - notify
//- (void)notifyStatusForProductIdentifier:(NSString *)productIdentifier string:(NSString *)string {
//    
//    IAPProduct * product = _products[productIdentifier];
//    [self notifyStatusForProduct:product string:string];
//}
//
//
//- (void)notifyStatusForProduct:(IAPProduct *)product string:(NSString *)string {
//}



#pragma mark - title helper
-(NSString *)titleForProduct:(SKProduct *)aProduct {
    
    NSNumberFormatter *productPriceFormatter = [NSNumberFormatter new];
    productPriceFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    productPriceFormatter.locale = aProduct.priceLocale;
    NSString *productPriceWithCurrency = (aProduct.price) ? [productPriceFormatter stringFromNumber:aProduct.price] : @"Free";
    NSString *productTitle = [NSString stringWithFormat:@"%@ (%@)", aProduct.localizedTitle, productPriceWithCurrency];
    
    return productTitle;
}


-(NSArray *)titlesForProducts:(NSArray *)aProducts {
    NSMutableArray *productTitles = [NSMutableArray new];
    
    
    [aProducts enumerateObjectsUsingBlock:^(SKProduct *product, NSUInteger idx, BOOL *stop) {
        
        [productTitles addObject:[self titleForProduct:product]];
    }];
    
    return productTitles;
}

@end

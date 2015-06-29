//
//  MMXDataManager.m
//  MathMatch
//
//  Created by Dong Yiming on 6/29/15.
//  Copyright (c) 2015 Computer Lab. All rights reserved.
//

#import "MMXDataManager.h"
#import "MMXClass.h"

#define HAS_FILLED_DATABASE   @"HAS_FILLED_DATABASE"

@implementation MMXDataManager

+(void)initDataBase {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:HAS_FILLED_DATABASE]) {
        
        [self fillDataBase];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:HAS_FILLED_DATABASE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(void)fillDataBase {
    
    MMXClass *class = [MMXClass MR_createEntity];
    class.title = @"Addition";
}

@end

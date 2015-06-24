//
//  UIViewController+PSContainment.m
//  PathSource
//
//  Created by D. D. on 4/1/15.
//  Copyright (c) 2015 Path Source. All rights reserved.
//

#import "UIViewController+PSContainment.h"

@implementation UIViewController (PSContainment)


- (void)installChildVC: (UIViewController*) childVC toContainerView:(UIView *)containerView;
{
    if (childVC && [containerView isDescendantOfView:self.view]) {
        
        [self addChildViewController:childVC];
        childVC.view.frame = containerView.bounds;
        childVC.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [containerView addSubview:childVC.view];
        [childVC didMoveToParentViewController:self];
    }
}


-(void)uninstallFromParent {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end

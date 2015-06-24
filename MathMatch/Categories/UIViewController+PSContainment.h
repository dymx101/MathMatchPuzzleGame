//
//  UIViewController+PSContainment.h
//  PathSource
//
//  Created by D. D. on 4/1/15.
//  Copyright (c) 2015 Path Source. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PSContainment)

/// Remove self from parent view conroller, all in one
-(void)uninstallFromParent;

/// Add a child view controller to a descendant view of self.view
- (void)installChildVC: (UIViewController*) childVC toContainerView:(UIView *)containerView;
@end

//
//  FbTModelController.h
//  ExactTarget NSSet Test
//
//  Created by Don Huff on 3/6/14.
//  Copyright (c) 2014 15 by 10, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FbTDataViewController;

@interface FbTModelController : NSObject <UIPageViewControllerDataSource>

- (FbTDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(FbTDataViewController *)viewController;

@end

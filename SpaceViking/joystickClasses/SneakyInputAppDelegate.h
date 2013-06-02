//
//  SneakyInputAppDelegate.h
//  SneakyInput
//
//  Created by Nick Pannuto on 2/18/10.
//  Copyright Sneakyness, llc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "AppDelegate.h"

@interface SneakyInputAppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;
    
	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end

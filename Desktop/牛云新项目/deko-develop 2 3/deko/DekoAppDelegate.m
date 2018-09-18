//
//  DekoAppDelegate.m
//  deko
//
//  Created by Johan Halin on 26.11.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import "DekoAppDelegate.h"
#import "Dekojw0803ViewController.h"
#import "DekoIAPManager.h"
#import "HarmonySettingGenerator.h"
#import "Dekojw0803ShareHelper.h"
#import "DekoSceneManager.h"
#import "DekoGalleryViewController.h"
#import "DekoIAPViewController.h"
#import "Harmonyjw0803ColorGenerator.h"

@implementation DekoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	Harmonyjw0803ColorGenerator *colorGenerator = [[Harmonyjw0803ColorGenerator alloc] init];
	Dekojw0803ShareHelper *shareHelper = [[Dekojw0803ShareHelper alloc] init];
	DekoSceneManager *sceneManager = [[DekoSceneManager alloc] init];
	DekoIAPManager *purchaseManager = [[DekoIAPManager alloc] init];
	[purchaseManager startManager];
	
	HarmonySettingGenerator *settingGenerator = [[HarmonySettingGenerator alloc] init];
	settingGenerator.colorGenerator = colorGenerator;

	DekoGalleryViewController *galleryViewController = [[DekoGalleryViewController alloc] initWithNibName:nil bundle:nil];
	galleryViewController.sceneManager = sceneManager;
	
	DekoIAPViewController *iapViewController = [[DekoIAPViewController alloc] initWithNibName:nil bundle:nil];
	iapViewController.purchaseManager = purchaseManager;
	
	self.viewController = [[Dekojw0803ViewController alloc] init];
	self.viewController.purchaseManager = purchaseManager;
	self.viewController.settingGenerator = settingGenerator;
	self.viewController.shareHelper = shareHelper;
	self.viewController.sceneManager = sceneManager;
	self.viewController.galleryViewController = galleryViewController;
	self.viewController.iapViewController = iapViewController;
	self.viewController.colorGenerator = colorGenerator;
	
	self.window.rootViewController = self.viewController;
	[self.window makeKeyAndVisible];
		
	return YES;
}

@end

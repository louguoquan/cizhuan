//
//  UIApplication+Sunday.h
//  SundayFramework
//
//  Created by 管振东 on 16/4/20.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Sunday)

/// "Documents" folder in this app's sandbox.
@property (nullable, nonatomic, readonly) NSURL *documentsURL;
@property (nullable, nonatomic, readonly) NSString *documentsPath;

/// "Caches" folder in this app's sandbox.
@property (nullable, nonatomic, readonly) NSURL *cachesURL;
@property (nullable, nonatomic, readonly) NSString *cachesPath;

/// "Library" folder in this app's sandbox.
@property (nullable, nonatomic, readonly) NSURL *libraryURL;
@property (nullable, nonatomic, readonly) NSString *libraryPath;

/// Application's Bundle Name (show in SpringBoard).
@property (nullable, nonatomic, readonly) NSString *appBundleName;

/// Application's Bundle ID.  e.g. "com.ibireme.MyApp"
@property (nullable, nonatomic, readonly) NSString *appBundleID;

/// Application's Version.  e.g. "1.2.0"
@property (nullable, nonatomic, readonly) NSString *appVersion;

/// Application's Build number. e.g. "123"
@property (nullable, nonatomic, readonly) NSString *appBuildVersion;

/// Whether this app is pirated (not install from appstore).
@property (nonatomic, readonly) BOOL isPirated;

/// Whether this app is being debugged (debugger attached).
@property (nonatomic, readonly) BOOL isBeingDebugged;

/// Current thread real memory used in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryUsage;

/// Current thread CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float cpuUsage;

@end

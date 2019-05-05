#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120200 && __IPHONE_OS_VERSION_MAX_ALLOWED < 130000

#import "Xcode10_2_XCTest_CDStructures.h"
#import "Xcode10_2_SharedHeader.h"
#import <Foundation/Foundation.h>

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCUITransformParameters : NSObject <NSCopying>
{
    unsigned long long _windowID;
    unsigned long long _displayID;
}

+ (id)transformParametersWithWindowID:(unsigned long long)arg1 displayID:(unsigned long long)arg2;
@property(readonly) unsigned long long displayID; // @synthesize displayID=_displayID;
@property(readonly) unsigned long long windowID; // @synthesize windowID=_windowID;
- (id)copyWithZone:(struct _NSZone *)arg1;

@end

#endif
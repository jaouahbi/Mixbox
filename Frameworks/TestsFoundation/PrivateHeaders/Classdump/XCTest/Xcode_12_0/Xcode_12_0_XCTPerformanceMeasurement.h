#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 140000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 150000

#import "Xcode_12_0_XCTest_CDStructures.h"
#import "Xcode_12_0_SharedHeader.h"
#import <Foundation/Foundation.h>
#import <XCTest/XCTMetric.h>

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
@interface XCTPerformanceMeasurement ()
{
    NSString *_identifier;
    NSString *_displayName;
    NSMeasurement *_value;
    double _doubleValue;
    NSString *_unitSymbol;
    long long _polarity;
}

+ (id)displayFriendlyMeasurement:(id)arg1;
@property(readonly) long long polarity; // @synthesize polarity=_polarity;
- (id)initWithIdentifier:(id)arg1 displayName:(id)arg2 value:(id)arg3 polarity:(long long)arg4;
- (id)initWithIdentifier:(id)arg1 displayName:(id)arg2 doubleValue:(double)arg3 unitSymbol:(id)arg4 polarity:(long long)arg5;

@end

#endif

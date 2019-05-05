#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120200 && __IPHONE_OS_VERSION_MAX_ALLOWED < 130000

#import "Xcode10_2_XCTest_CDStructures.h"
#import "Xcode10_2_SharedHeader.h"
#import "Xcode10_2_XCTElementSnapshotAttributeDataSource.h"

@class XCTElementQuery, XCTElementQueryResults;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@protocol XCTRunnerAutomationSession <XCTElementSnapshotAttributeDataSource>
@property(readonly) _Bool supportsAnimationsIdleNotifications;
@property(readonly) _Bool supportsMainRunLoopIdleNotifications;
@property(readonly) _Bool supportsFetchingAttributesForElement;
- (void)notifyWhenAnimationsAreIdle:(void (^)(NSError *))arg1;
- (void)notifyWhenMainRunLoopIsIdle:(void (^)(NSError *))arg1;
- (XCTElementQueryResults *)matchesForQuery:(XCTElementQuery *)arg1 error:(id *)arg2;
@end

#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120200 && __IPHONE_OS_VERSION_MAX_ALLOWED < 130000

#import "Xcode10_2_XCTest_CDStructures.h"
#import "Xcode10_2_SharedHeader.h"
#import "Xcode10_2_XCTRunnerAutomationSession.h"
#import <Foundation/Foundation.h>

@protocol XCUICapabilities;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCTRunnerAutomationSession : NSObject <XCTRunnerAutomationSession>
{
    int _connectionPid;
    NSXPCConnection *_connection;
    id <XCUICapabilities> _capabilities;
}

@property(readonly) id <XCUICapabilities> capabilities; // @synthesize capabilities=_capabilities;
@property(readonly) int connectionPid; // @synthesize connectionPid=_connectionPid;
@property(readonly) NSXPCConnection *connection; // @synthesize connection=_connection;
@property(readonly) _Bool usePointTransformationsForFrameConversions;
@property(readonly) _Bool supportsHostedViewCoordinateTransformations;
- (id)parameterizedAttribute:(id)arg1 forElement:(id)arg2 parameter:(id)arg3 error:(id *)arg4;
- (id)attributesForElement:(id)arg1 attributes:(id)arg2 error:(id *)arg3;
@property(readonly) _Bool allowsRemoteAccess;
- (void)notifyWhenAnimationsAreIdle:(CDUnknownBlockType)arg1;
@property(readonly) _Bool supportsAnimationsIdleNotifications;
- (void)notifyWhenMainRunLoopIsIdle:(CDUnknownBlockType)arg1;
@property(readonly) _Bool supportsMainRunLoopIdleNotifications;
@property(readonly) _Bool supportsFetchingAttributesForElement;
- (id)matchesForQuery:(id)arg1 error:(id *)arg2;
- (id)initWithEndpoint:(id)arg1 pid:(int)arg2 capabilities:(id)arg3;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

#endif
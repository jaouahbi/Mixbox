#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 140000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 150000

#import "Xcode_12_0_XCTest_CDStructures.h"
#import "Xcode_12_0_SharedHeader.h"
#import "Xcode_12_0_XCTWaiterManagement.h"
#import "Xcode_12_0_XCTestExpectationDelegate.h"
#import <Foundation/Foundation.h>
#import <XCTest/XCTWaiter.h>

@protocol XCTWaiterDelegate;

@class CFRunLoop, XCTWaiterManager;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCTWaiter ()
{
    _Bool _enforceOrderOfFulfillment;
    id <XCTWaiterDelegate> _delegate;
    NSObject *_delegateQueue;
    long long _state;
    long long _result;
    double _timeout;
    NSArray *_waitCallStackReturnAddresses;
    NSArray *_expectations;
    NSMutableArray *_mutableFulfilledExpectations;
    struct __CFRunLoop *_waitingRunLoop;
    XCTWaiterManager *_manager;
}

+ (void)wait:(double)arg1;
+ (void)setStallHandler:(CDUnknownBlockType)arg1;
+ (void)handleStalledWaiter:(id)arg1;
+ (CDUnknownBlockType)installWatchdogForWaiter:(id)arg1 timeout:(double)arg2;
+ (double)watchdogTimeoutSlop;
+ (void)setWatchdogTimeoutSlop:(double)arg1;
+ (id)subsystemQueue;
@property __weak XCTWaiterManager *manager; // @synthesize manager=_manager;
@property struct __CFRunLoop *waitingRunLoop; // @synthesize waitingRunLoop=_waitingRunLoop;
@property(readonly, nonatomic) NSMutableArray *mutableFulfilledExpectations; // @synthesize mutableFulfilledExpectations=_mutableFulfilledExpectations;
@property(copy, nonatomic) NSArray *expectations; // @synthesize expectations=_expectations;
@property(copy) NSArray *waitCallStackReturnAddresses; // @synthesize waitCallStackReturnAddresses=_waitCallStackReturnAddresses;
@property _Bool enforceOrderOfFulfillment; // @synthesize enforceOrderOfFulfillment=_enforceOrderOfFulfillment;
@property double timeout; // @synthesize timeout=_timeout;
@property long long result; // @synthesize result=_result;
@property long long state; // @synthesize state=_state;
@property(readonly, nonatomic) NSObject *delegateQueue; // @synthesize delegateQueue=_delegateQueue;
@property(readonly) _Bool currentContextIsNested;
@property(readonly, getter=isInProgress) _Bool inProgress;
- (void)_queue_validateExpectationFulfillmentWithTimeoutState:(_Bool)arg1;
- (_Bool)_queue_enforceOrderingWithFulfilledExpectations:(id)arg1;
- (void)_queue_computeInitiallyFulfilledExpectations;
- (void)_queue_setExpectations:(id)arg1;
- (void)_validateExpectationFulfillmentWithTimeoutState:(_Bool)arg1;
- (void)didFulfillExpectation:(id)arg1;
- (void)cancelPrimitiveWait;
- (void)cancelWaiting;
- (void)primitiveWait:(double)arg1;
- (void)interruptForWaiter:(id)arg1;

- (void)dealloc;

- (id)init;

// Remaining properties

@end

#endif
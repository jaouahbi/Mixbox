#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 120200 && __IPHONE_OS_VERSION_MAX_ALLOWED < 130000

#import "Xcode10_2_XCTest_CDStructures.h"
#import "Xcode10_2_SharedHeader.h"
#import <Foundation/Foundation.h>
#import <XCTest/XCUISiriService.h>

@protocol XCUIDevice, XCUIRemoteSiriInterface;

@class XCUIApplication;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCUISiriService ()
{
    XCUIApplication *_siriApplication;
    id <XCUIDevice> _device;
    id <XCUIRemoteSiriInterface> _remoteSiriInterface;
}

@property(readonly) id <XCUIRemoteSiriInterface> remoteSiriInterface; // @synthesize remoteSiriInterface=_remoteSiriInterface;
@property(readonly) id <XCUIDevice> device; // @synthesize device=_device;
@property(readonly) XCUIApplication *siriApplication; // @synthesize siriApplication=_siriApplication;
- (id)forwardingTargetForSelector:(SEL)arg1;
- (void)_waitForActivation;
- (void)_assertSiriEnabled;
@property(readonly, getter=isEnabled) _Bool enabled;
- (void)injectVoiceRecognitionAudioInputPaths:(id)arg1;
- (void)injectAssistantRecognitionStrings:(id)arg1;

- (id)initWithDevice:(id)arg1 remoteSiriInterface:(id)arg2;

@end

#endif
#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "LBXScanLineAnimation.h"
#import "LBXScanNative.h"
#import "LBXScanNetAnimation.h"
#import "LBXScanResult.h"
#import "LBXScanView.h"
#import "LBXScanViewController.h"
#import "LBXScanViewStyle.h"
#import "LBXScanWrapper.h"
#import "LBXZXCapture.h"
#import "LBXZXCaptureDelegate.h"
#import "ZXingWrapper.h"

FOUNDATION_EXPORT double LBXScanVersionNumber;
FOUNDATION_EXPORT const unsigned char LBXScanVersionString[];


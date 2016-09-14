/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 Abstract:
 View controller for camera interface.
 */

#import "AAPLCameraVCDelegate.h"


@import UIKit;
@class AAPLPreviewView;


@interface AAPLCameraViewController : UIViewController
@property (nonatomic, weak) IBOutlet AAPLPreviewView *previewView;
@property (retain) id <AAPLCameraVCDelegate>delegate;
    
- (void)toggleMovieRecording;
- (void)changeCamera;
@end

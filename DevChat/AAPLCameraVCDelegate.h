//
//  AAPLCameraVCDelegate.h
//  DevChat
//
//  Created by brenda saavedra on 13/09/16.
//  Copyright © 2016 bsc. All rights reserved.
//

#ifndef Header_h
#define Header_h
#include <UIKit/UIKit.h>

@protocol AAPLCameraVCDelegate <NSObject>
-(void)shouldEnableRecordUI:(BOOL)enable;
-(void)shouldEnableCameraUI:(BOOL)enable;
-(void)canStartRecording;
-(void)recordingHasStarted;
-(void)videoRecordingComplet:(NSURL*)videoURL;
-(void)videoRecordingFailed;
-(void)snapshotTaken:(NSData*)snapshotData;
-(void)snapshotFailed;
@end

#endif /* Header_h */

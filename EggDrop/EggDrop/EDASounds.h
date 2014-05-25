//
//  EDASounds.h
//  PixelNoise
//
//  Created by Jonathan Fox on 5/5/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//
/////////////////////////////////
// THIS WILL MANAGE THE SOUNDS //
/////////////////////////////////

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface EDASounds : NSObject <AVAudioPlayerDelegate>

@property (nonatomic) AVAudioPlayer * player;

-(void)playSoundWithName:(NSString *)soundName loops:(int)loops;


@end

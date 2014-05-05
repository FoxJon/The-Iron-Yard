//
//  PNAPixelSounds.h
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

@interface PNAPixelSounds : NSObject <AVAudioPlayerDelegate>

@property (nonatomic) AVAudioPlayer * player;
//@property (nonatomic) NSMutableArray * players;

-(void)playSoundWithName:(NSString *)soundName;


@end

//
//  EDASounds.m
//  PixelNoise
//
//  Created by Jonathan Fox on 5/5/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "EDASounds.h"

@implementation EDASounds

-(void)playSoundWithName:(NSString *)soundName loops:(int)loops
{
    NSData *fileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"]];
    
    //PLAYER MUST BE A PROPERTY!!  if not, the pointer gets closed out at end of method before the sound even gets to play. Now the property stays alive as long as pixelSounds stays alive.
    self.player = [[AVAudioPlayer alloc]initWithData:fileData error:nil];
    
    //make it -1 to make it infinite loop!
    self.player.numberOfLoops = loops;
    
    [self.player play];
}

@end

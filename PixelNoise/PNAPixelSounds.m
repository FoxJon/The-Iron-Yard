//
//  PNAPixelSounds.m
//  PixelNoise
//
//  Created by Jonathan Fox on 5/5/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "PNAPixelSounds.h"
@implementation PNAPixelSounds

-(id)init
{
    self = [super init];
    if(self)
    {
        self.players = [@[]mutableCopy];
    }
    return self;
}

-(void)playSoundWithName:(NSString *)soundName
{
    NSData *filePixelData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"]];
    
    //PLAYER MUST BE A PROPERTY!!  if not, the pointer gets closed out at end of method before the sound even gets to play. Now the property stays alive as long as pixelSounds stays alive.
    
    AVAudioPlayer * player = [[AVAudioPlayer alloc]initWithData:filePixelData error:nil];
    
    player.delegate = self;
    
    [self.players addObject:player];
    
    //make it -1 to make it infinite loop!
    //player.numberOfLoops = 0;
    
    [player play];
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.players removeObjectIdenticalTo:player];
    NSLog(@"players %d", (int) [self.players count]);
}

@end

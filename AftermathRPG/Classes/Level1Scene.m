//
//  Level1Scene.m
//  AftermathRPG
//
//  Created by Jason Woolard on 6/12/14.
//  Copyright Jason Woolard 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "Level1Scene.h"
#import "IntroScene.h"

// -----------------------------------------------------------------------
#pragma mark - Level1Scene
// -----------------------------------------------------------------------

@implementation Level1Scene
@synthesize hudLayer, gameLayer;
// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (Level1Scene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Adding the game layer node to the scene
    self.gameLayer = [Level1GameLayer node];
    [self addChild:gameLayer z:-1];
    
    // Adding the hud layer node to the scene
    self.hudLayer = [HudLayer node];
    [self addChild:hudLayer z:1];
   
	return self;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // Playing the Scene Track in the background on loop with a minimized volume from the original.
    [[OALSimpleAudio sharedInstance] playBg:@"SceneTrack.mp3" volume:0.3f pan:0.5f loop:YES];
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}


@end

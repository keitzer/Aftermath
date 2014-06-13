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
    
    self.gameLayer = [Level1GameLayer node];
    [self addChild:gameLayer z:-1];
    
    hudLayer = [HudLayer node];
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
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}


@end

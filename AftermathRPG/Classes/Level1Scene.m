//
//  Level1Scene.m
//  AftermathRPG
//
//  Created by Jason Woolard on 6/10/14.
//  Copyright Jason Woolard 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "Level1Scene.h"
#import "MenuScene.h"

// -----------------------------------------------------------------------
#pragma mark - Level1Scene
// -----------------------------------------------------------------------

@implementation Level1Scene
@synthesize _mainCharacter, _zombieBoss, _zombieCharacter1, _zombieCharacter2, _zombiePirate, _level1Map, _bgLayer,_floorLayer,_wallsLayer;

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
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    self._level1Map = [CCTiledMap tiledMapWithFile:@"AftermathRpg.tmx"];
    self._bgLayer = [_level1Map layerNamed:@"bg-water"];
    self._wallsLayer = [_level1Map layerNamed:@"walls"];
    self._floorLayer = [_level1Map layerNamed:@"floor"];
    
    [self addChild:_level1Map z:-1];
    
    CCTiledMapObjectGroup *objects = [_level1Map objectGroupNamed:@"mainChar"];
    NSMutableDictionary *startPoint = [objects objectNamed:@"startPosition"];
    int x = [[startPoint valueForKey:@"x"] intValue];
    int y = [[startPoint valueForKey:@"y"] intValue];
    
    self._mainCharacter = [CCSprite spriteWithImageNamed:@"mainCharacter_e.png"];
    _mainCharacter.position = ccp(x,y);
    [self addChild:_mainCharacter];
    
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];

    // done
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
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
 
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
@end

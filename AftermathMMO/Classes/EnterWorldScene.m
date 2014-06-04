//
//  EnterWorldScene.m
//  AftermathMMO
//
//  Created by Jason Woolard on 6/3/14.
//  Copyright Jason Woolard 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "EnterWorldScene.h"
#import "IntroScene.h"

// -----------------------------------------------------------------------
#pragma mark - EnterWorldScene
// -----------------------------------------------------------------------

@implementation EnterWorldScene
{
    CCSprite *_mainCharacter;
    CCSprite *_zombiePirateInitial;
    CCSprite *_zombiePirateWalking1;
    CCSprite *_zombiePirateWalking2;
    CCSprite *_zombiePirateWalking3;
    CCSprite *_bullet;


}
// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (EnterWorldScene *)scene
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
    
    CCSprite* background = [CCSprite spriteWithImageNamed:@"AftermathMap.png"];
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background];
    
    
    // Add a sprite
//    _mainCharacter = [CCSprite spriteWithImageNamed:@"Icon-72.png"];
//    _mainCharacter.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
//    [self addChild:_sprite];
    _zombiePirateInitial = [CCSprite spriteWithImageNamed:@"zombie-pirate-front.png"];
    _zombiePirateInitial.position  = ccp(525,205);
    [self addChild:_zombiePirateInitial];
    
    _mainCharacter = [CCSprite spriteWithImageNamed:@"mainCharacterInitial.png"];
    _mainCharacter.position  = ccp(185,205);
    [self addChild:_mainCharacter];
    
    _bullet = [CCSprite spriteWithImageNamed:@"bullet.png"];

//
//    // Animate sprite with action
//    CCActionRotateBy* actionSpin = [CCActionRotateBy actionWithDuration:1.5f angle:360];
//    [_sprite runAction:[CCActionRepeatForever actionWithAction:actionSpin]];
    
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

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
    // Log touch location
    CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    
    // Move our sprite to touch location
    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:touchLoc];
    [_zombiePirateInitial runAction:actionMove];
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
@end

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
@synthesize  levelOneMap, mainChar, metaTileLayer, zombieBoss, zombieHumanOne, zombieHumanTwo, dagger, zombiePirate;

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
    self.levelOneMap = [CCTiledMap tiledMapWithFile:@"Level1.tmx"];
    self.metaTileLayer = [levelOneMap layerNamed:@"Meta"];
    metaTileLayer.visible = NO;

    
    CCTiledMapObjectGroup *objects0  =    [levelOneMap objectGroupNamed:@"mainChar"];
    NSMutableDictionary *startPoint0 =    [objects0 objectNamed:@"startPosition"];
    int x0 = [[startPoint0 valueForKey:@"x"] intValue];
    int y0 = [[startPoint0 valueForKey:@"y"] intValue];
    
    self.mainChar     = [CCSprite spriteWithImageNamed:@"mainChar.png"];
    mainChar.position = ccp(x0,y0);
    [self addChild:mainChar];
    
    [self addChild:levelOneMap z:-1];
    
    CCTiledMapObjectGroup *objects1  =    [levelOneMap objectGroupNamed:@"zombiePirate"];
    NSMutableDictionary *startPoint1 =    [objects1 objectNamed:@"startPoint"];
    int x1 = [[startPoint1 valueForKey:@"x"] intValue];
    int y1 = [[startPoint1 valueForKey:@"y"] intValue];
    
    self.mainChar     = [CCSprite spriteWithImageNamed:@"zombiePirate.png"];
    mainChar.position = ccp(x1,y1);
    [self addChild:mainChar];
    
    CCTiledMapObjectGroup *objects2  =    [levelOneMap objectGroupNamed:@"zombieChar1"];
    NSMutableDictionary *startPoint2 =    [objects2 objectNamed:@"startPoint"];
    int x2 = [[startPoint2 valueForKey:@"x"] intValue];
    int y2 = [[startPoint2 valueForKey:@"y"] intValue];
    
    self.zombieHumanOne     = [CCSprite spriteWithImageNamed:@"zombieHuman.png"];
    zombieHumanOne.position = ccp(x2,y2);
    [self addChild:zombieHumanOne];

    CCTiledMapObjectGroup *objects3  =    [levelOneMap objectGroupNamed:@"zombieChar2"];
    NSMutableDictionary *startPoint3 =    [objects3 objectNamed:@"startPoint"];
    int x3 = [[startPoint3 valueForKey:@"x"] intValue];
    int y3 = [[startPoint3 valueForKey:@"y"] intValue];
    
    self.zombieHumanTwo     = [CCSprite spriteWithImageNamed:@"zombieHumanTwo.png"];
    zombieHumanTwo.position = ccp(x3,y3);
    [self addChild:zombieHumanTwo];

    CCTiledMapObjectGroup *objects4  =    [levelOneMap objectGroupNamed:@"zombieBoss"];
    NSMutableDictionary *startPoint4 =    [objects4 objectNamed:@"startPoint"];
    int x4 = [[startPoint4 valueForKey:@"x"] intValue];
    int y4 = [[startPoint4 valueForKey:@"y"] intValue];
    
    self.zombieBoss     = [CCSprite spriteWithImageNamed:@"zombieBoss.png"];
    zombieBoss.position = ccp(x4,y4);
    [self addChild:zombieBoss];
    
    CCTiledMapObjectGroup *objects5  =    [levelOneMap objectGroupNamed:@"spawn"];
    NSMutableDictionary *startPoint5 =    [objects5 objectNamed:@"daggerSpawn"];
    int x5 = [[startPoint5 valueForKey:@"x"] intValue];
    int y5 = [[startPoint5 valueForKey:@"y"] intValue];
    
    self.dagger     = [CCSprite spriteWithImageNamed:@"dagger.png"];
    dagger.position = ccp(x5,y5);
    [self addChild:dagger];
    
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
    
//    // Move our sprite to touch location
//    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:touchLoc];
//    [_sprite runAction:actionMove];
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

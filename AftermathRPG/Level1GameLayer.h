//
//  Level1GameLayer.h
//  AftermathRPG
//
//  Created by Jason Woolard on 6/12/14.
//  Copyright (c) 2014 Jason Woolard. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "HudLayer.h"
#import "CCAnimatedSprite.h"

@interface Level1GameLayer : CCNode <CCPhysicsCollisionDelegate>
{
    // Maps & Layers
    CCTiledMap *levelOneMap;
    CCTiledMapLayer *metaTileLayer;
    CCTiledMapLayer *metaTileTwoLayer;

    // Sprites
    CCAnimatedSprite *mainChar;
    CCAnimatedSprite *zombiePirate;
    CCAnimatedSprite *zombieHumanOne;
    CCAnimatedSprite *zombieHumanTwo;
    CCSprite *zombieBoss;
    CCSprite *dagger;
    CCSprite *bullet;
    HudLayer *hud;
}
// Properties
@property (nonatomic, retain) CCTiledMap *levelOneMap;
@property (nonatomic, retain) CCTiledMapLayer *metaTileLayer;
@property (nonatomic, retain) CCTiledMapLayer *metaTileTwoLayer;
@property (nonatomic, retain) CCAnimatedSprite *mainChar;
@property (nonatomic, retain) CCAnimatedSprite *zombiePirate;
@property (nonatomic, retain) CCAnimatedSprite *zombieHumanOne;
@property (nonatomic, retain) CCAnimatedSprite *zombieHumanTwo;
@property (nonatomic, retain) CCSprite *zombieBoss;
@property (nonatomic, retain) CCSprite *dagger;
@property (nonatomic, retain) CCSprite *bullet;
@property (nonatomic, assign) CCPhysicsNode *physicsWorldNode;

@property (nonatomic, strong) CCAction *moveAction;
@property (nonatomic, strong) CCAction *walkAction;
- (void) shootBulletsFromGun:(id)sender;

@end

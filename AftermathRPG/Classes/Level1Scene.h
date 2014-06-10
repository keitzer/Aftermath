//
//  Level1Scene.h
//  AftermathRPG
//
//  Created by Jason Woolard on 6/10/14.
//  Copyright Jason Woolard 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface Level1Scene : CCScene
{
    CCSprite *_mainCharacter;
    CCSprite *_zombiePirate;
    CCSprite *_zombieCharacter1;
    CCSprite *_zombieCharacter2;
    CCSprite *_zombieBoss;
    CCTiledMap *_level1Map;
    CCTiledMapLayer *_bgLayer;
    CCTiledMapLayer *_floorLayer;
    CCTiledMapLayer *_wallsLayer;
}

// -----------------------------------------------------------------------

+ (Level1Scene *)scene;
- (id)init;

// Properties
@property (nonatomic, retain) CCSprite *_mainCharacter;
@property (nonatomic, retain) CCSprite *_zombiePirate;
@property (nonatomic, retain) CCSprite *_zombieCharacter1;
@property (nonatomic, retain) CCSprite *_zombieCharacter2;
@property (nonatomic, retain) CCSprite *_zombieBoss;
@property (nonatomic, retain) CCTiledMap *_level1Map;
@property (nonatomic, retain) CCTiledMapLayer *_bgLayer;
@property (nonatomic, retain) CCTiledMapLayer *_floorLayer;
@property (nonatomic, retain) CCTiledMapLayer *_wallsLayer;

// -----------------------------------------------------------------------
@end
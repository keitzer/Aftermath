//
//  Level1Scene.h
//  AftermathRPG
//
//  Created by Jason Woolard on 6/12/14.
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
    // Maps & Layers
    CCTiledMap *levelOneMap;
    CCTiledMapLayer *metaTileLayer;
    
    // Sprites
    CCSprite *mainChar;
    CCSprite *zombiePirate;
    CCSprite *zombieHumanOne;
    CCSprite *zombieHumanTwo;
    CCSprite *zombieBoss;
    CCSprite *dagger;

}
// -----------------------------------------------------------------------

+ (Level1Scene *)scene;
- (id)init;

// Properties
@property (nonatomic, retain) CCTiledMap *levelOneMap;
@property (nonatomic, retain) CCTiledMapLayer *metaTileLayer;
@property (nonatomic, retain) CCSprite *mainChar;
@property (nonatomic, retain) CCSprite *zombiePirate;
@property (nonatomic, retain) CCSprite *zombieHumanOne;
@property (nonatomic, retain) CCSprite *zombieHumanTwo;
@property (nonatomic, retain) CCSprite *zombieBoss;
@property (nonatomic, retain) CCSprite *dagger;

// -----------------------------------------------------------------------
@end
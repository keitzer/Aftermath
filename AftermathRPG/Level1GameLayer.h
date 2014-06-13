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

@interface Level1GameLayer : CCNode
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
// Properties
@property (nonatomic, retain) CCTiledMap *levelOneMap;
@property (nonatomic, retain) CCTiledMapLayer *metaTileLayer;
@property (nonatomic, retain) CCSprite *mainChar;
@property (nonatomic, retain) CCSprite *zombiePirate;
@property (nonatomic, retain) CCSprite *zombieHumanOne;
@property (nonatomic, retain) CCSprite *zombieHumanTwo;
@property (nonatomic, retain) CCSprite *zombieBoss;
@property (nonatomic, retain) CCSprite *dagger;

@end

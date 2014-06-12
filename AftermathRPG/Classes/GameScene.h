//
//  GameScene.h
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
@interface GameScene : CCScene
{
    CCTiledMap *theMap;
    CCSprite *mainChar;


}
// -----------------------------------------------------------------------

+ (GameScene *)scene;
- (id)init;
@property (nonatomic, retain) CCTiledMap *theMap;
@property (nonatomic, retain) CCSprite *mainChar;

// -----------------------------------------------------------------------
@end
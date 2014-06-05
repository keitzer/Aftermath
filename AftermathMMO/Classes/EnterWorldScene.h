//
//  EnterWorldScene.h
//  AftermathMMO
//
//  Created by Jason Woolard on 6/3/14.
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
@interface EnterWorldScene : CCScene <CCPhysicsCollisionDelegate>

// -----------------------------------------------------------------------
+ (EnterWorldScene *)scene;
- (id)init;
@property (nonatomic, strong) CCSprite *background;
@property (nonatomic, strong) CCSprite *bullet;
@property (nonatomic, strong) CCSprite *zombiePirate;
@property (nonatomic, strong) CCSprite *zombiePirateWalking;
@property (nonatomic, strong) CCSprite *player;
@property (nonatomic, assign) CGPoint targetPosition;
@property (nonatomic, assign) CCPhysicsNode *physicsWorldNode;

// -----------------------------------------------------------------------
@end
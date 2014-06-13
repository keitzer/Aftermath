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
#import "Level1GameLayer.h"
#import "HudLayer.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface Level1Scene : CCScene
{


}
// -----------------------------------------------------------------------

+ (Level1Scene *)scene;
- (id)init;

// Properties
@property (nonatomic, retain) Level1GameLayer *gameLayer;
@property (nonatomic ,retain) HudLayer *hudLayer;

// -----------------------------------------------------------------------
@end
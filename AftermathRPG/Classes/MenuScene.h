//
//  MenuScene.h
//  AftermathRPG
//
//  Created by Jason Woolard on 6/10/14.
//  Copyright Jason Woolard 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using cocos2d-v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The menu scene
 *  Note, that scenes should now be based on CCScene, and not CCLayer, as previous versions
 *  Main usage for CCLayer now, is to make colored backgrounds (rectangles)
 *
 */
@interface MenuScene : CCScene

// -----------------------------------------------------------------------

+ (MenuScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end
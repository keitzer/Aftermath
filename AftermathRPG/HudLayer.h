//
//  HudLayer.h
//  AftermathRPG
//
//  Created by Jason Woolard on 6/12/14.
//  Copyright (c) 2014 Jason Woolard. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"
#import "CCAnimatedSprite.h"
@class SneakyJoystick;
@class SneakyButton;
@interface HudLayer : CCNode
{
    CCLabelTTF *zombiesKilled;
    CCLabelTTF *userInfoTxt;
    CCAnimatedSprite *healthBar;
    SneakyJoystick *leftJoystick;
	SneakyButton *rightButton;

}

@property (nonatomic, retain) CCAnimatedSprite *healthBar;

@end

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

@interface HudLayer : CCNode
{
    CCLabelTTF *zombiesKilled;
    CCLabelTTF *userPickupTxt;
    CCAnimatedSprite *healthBar;
    CCAnimatedSprite *sideBar;
    CCAnimatedSprite *objectiveGump;
}

@property (nonatomic, retain) CCAnimatedSprite *healthBar;
@property (nonatomic, retain) CCAnimatedSprite *sideBar;
@property (nonatomic, retain) CCAnimatedSprite *objectiveGump;
-(void)shootButtonClicked:(id)sender;

@end

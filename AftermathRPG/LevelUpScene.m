//
//  LevelUpScene.m
//  AftermathRPG
//
//  Created by Jason Woolard on 6/20/14.
//  Copyright (c) 2014 Jason Woolard. All rights reserved.
//

#import "LevelUpScene.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"

@implementation LevelUpScene
-(id)init
{
    self = [super init];
    
    if (self)
    {
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        
        CCLabelTTF *levelUpText = [CCLabelTTF labelWithString:@"You've cleared all the zombies here time to move forward..." fontName:@"Arial" fontSize:15];
        levelUpText.position = ccp(viewSize.width * 0.50, viewSize.height * 0.50 );
        [self addChild:levelUpText];
        
        CCButton *levelTwo = [[CCButton alloc] initWithTitle:@"Proceed" fontName:@"Arial" fontSize:22.0f];
        levelTwo.position  = ccp(viewSize.width * 0.50, viewSize.height * 0.35);
        
        [self addChild:levelTwo];
        
    }
    return self;
}

+ (LevelUpScene *)scene
{
    return [[self alloc] init];
}

@end

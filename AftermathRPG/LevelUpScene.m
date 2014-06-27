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
#import "IntroScene.h"

@implementation LevelUpScene
-(id)init
{
    self = [super init];
    
    if (self)
    {
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            CCLabelTTF *levelUpText = [CCLabelTTF labelWithString:@"You've cleared all the zombies here, check back soon for level 2!" fontName:@"Arial" fontSize:33.0f];
            levelUpText.position = ccp(viewSize.width * 0.50, viewSize.height * 0.50 );
            [self addChild:levelUpText];
        
            CCButton *levelTwo = [[CCButton alloc] initWithTitle:@"[ Main Menu ]" fontName:@"Arial" fontSize:35];
            [levelTwo setTarget:self selector:@selector(onMainMenu:)];
            levelTwo.position  = ccp(viewSize.width * 0.50, viewSize.height * 0.35);
        
            [self addChild:levelTwo];
        }
        else
        {
            CCLabelTTF *levelUpText = [CCLabelTTF labelWithString:@"You've cleared all the zombies here, check back soon for level 2!" fontName:@"Arial" fontSize:15.0f];
            levelUpText.position = ccp(viewSize.width * 0.50, viewSize.height * 0.50 );
            [self addChild:levelUpText];
            
            CCButton *levelTwo = [[CCButton alloc] initWithTitle:@"[ Main Menu ]" fontName:@"Arial" fontSize:22.0f];
            [levelTwo setTarget:self selector:@selector(onMainMenu:)];
            levelTwo.position  = ccp(viewSize.width * 0.50, viewSize.height * 0.35);
            
            [self addChild:levelTwo];
        }
        
    }
    return self;
}

+ (LevelUpScene *)scene
{
    return [[self alloc] init];
}
- (void) onMainMenu:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionDown duration:1.0f]];
}
@end

//
//  GameOverScene.m
//  AftermathRPG
//
//  Created by Jason Woolard on 6/12/14.
//  Copyright (c) 2014 Jason Woolard. All rights reserved.
//

#import "GameOverScene.h"
#import "IntroScene.h"
#import "Level1Scene.h"

@implementation GameOverScene
+(GameOverScene *)scene
{
    return [[self alloc] init];
}

-(id)init
{
    self = [super init];
    if (!self) return(nil);
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"You are dead!" fontName:@"Chalkduster" fontSize:54.0f];
        label.positionType = CCPositionTypeNormalized;
        label.color = [CCColor redColor];
        label.position = ccp(0.5f, 0.5f); // Middle of screen
        [self addChild:label];
        
        CCButton *playAgainButton = [CCButton buttonWithTitle:@"[ Play again ]" fontName:@"Verdana-Bold" fontSize:30.0f];
        playAgainButton.positionType = CCPositionTypeNormalized;
        playAgainButton.position = ccp(0.5f, 0.35f);
        [playAgainButton setTarget:self selector:@selector(onPlayRestart:)];
        [self addChild:playAgainButton];
        
        CCButton *mainMenuButton = [CCButton buttonWithTitle:@"[ Main Menu ]" fontName:@"Verdana-Bold" fontSize:30.0f];
        mainMenuButton.positionType = CCPositionTypeNormalized;
        mainMenuButton.position = ccp(0.5f, 0.20f);
        [mainMenuButton setTarget:self selector:@selector(onMainMenu:)];
        [self addChild:mainMenuButton];


    }
    else
    {
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"You are dead!" fontName:@"Chalkduster" fontSize:42.0f];
        label.positionType = CCPositionTypeNormalized;
        label.color = [CCColor redColor];
        label.position = ccp(0.5f, 0.5f); // Middle of screen
        [self addChild:label];
        
        CCButton *playAgainButton = [CCButton buttonWithTitle:@"[ Play again ]" fontName:@"Verdana-Bold" fontSize:18.0f];
        playAgainButton.positionType = CCPositionTypeNormalized;
        playAgainButton.position = ccp(0.5f, 0.35f);
        [playAgainButton setTarget:self selector:@selector(onPlayRestart:)];
        [self addChild:playAgainButton];
        
        CCButton *mainMenuButton = [CCButton buttonWithTitle:@"[ Main Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
        mainMenuButton.positionType = CCPositionTypeNormalized;
        mainMenuButton.position = ccp(0.5f, 0.20f);
        [mainMenuButton setTarget:self selector:@selector(onMainMenu:)];
        [self addChild:mainMenuButton];


    }
    
    // done
    return self;
    
}
- (void)onPlayRestart:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[Level1Scene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.5f]];
}
- (void)onMainMenu:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}
@end

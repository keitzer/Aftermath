//
//  GameOverScene.m
//  AftermathMMO
//
//  Created by Jason Woolard on 6/5/14.
//  Copyright 2014 Jason Woolard. All rights reserved.
//

#import "GameOverScene.h"
#import "IntroScene.h"
#import "EnterWorldScene.h"

@implementation GameOverScene

+(GameOverScene *)scene
{
    return [[self alloc] init];
}

-(id)init
{
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"You are dead!" fontName:@"Chalkduster" fontSize:42.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];
    
    // Helloworld scene button
    CCButton *playAgainButton = [CCButton buttonWithTitle:@"[ Play again ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    playAgainButton.positionType = CCPositionTypeNormalized;
    playAgainButton.position = ccp(0.5f, 0.35f);
    [playAgainButton setTarget:self selector:@selector(onPlayRestart:)];
    [self addChild:playAgainButton];
    
    // done
	return self;

}
- (void)onPlayRestart:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[EnterWorldScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.5f]];
}
@end

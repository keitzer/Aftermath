//
//  CreditsScene.m
//  AftermathRPG
//
//  Created by Jason Woolard on 6/26/14.
//  Copyright 2014 Jason Woolard. All rights reserved.
//

#import "CreditsScene.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"
#import "IntroScene.h"

@implementation CreditsScene
// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (CreditsScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    [[OALSimpleAudio sharedInstance] stopEverything];
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        CCLabelTTF *creditsHeader = [CCLabelTTF labelWithString:@"Credits" fontName:@"Arial" fontSize:45.0f];
        creditsHeader.position = ccp(viewSize.width/2 , viewSize.height/1.1);
        [self addChild:creditsHeader];
        
        CCLabelTTF *credits = [CCLabelTTF labelWithString:@"Game Art: \n Tiles - LPG Contributors (OGA) , adrix89 \n HUD - Buch  \n Sprites - Chris Hamons, Curt  \n \n Music:  \n  BG(s) - Soundcloud 	\n Effects - 	PremiumBeat, Pond5 \n  \n  Guidance & Instructor: \n Joseph Sheckels \n \n  Development & Images: \n Jason Woolard \n" fontName:@"Arial" fontSize:35.0f];
        credits.position = ccp(viewSize.width/2 , viewSize.height / 2);
        [self addChild:credits];
        
        CCButton *backButton = [CCButton buttonWithTitle:@"< Back" fontName:@"Arial" fontSize:28.0f];
        backButton.position = ccp(viewSize.width/9.5 , viewSize.height / 1.1);
        [backButton setTarget:self selector:@selector(onBackButtonClicked:)];
        [self addChild:backButton];

        
    }
    else
    {
        CCLabelTTF *creditsHeader = [CCLabelTTF labelWithString:@"Credits" fontName:@"Arial" fontSize:25.0f];
        creditsHeader.position = ccp(viewSize.width/2 , viewSize.height/1.1);
        [self addChild:creditsHeader];
        
        CCLabelTTF *credits = [CCLabelTTF labelWithString:@"Game Art: \n Tiles - LPG Contributors (OGA) , adrix89 \n HUD - Buch  \n Sprites - Chris Hamons, Curt  \n \n Music:  \n  BG(s) - Soundcloud 	\n Effects - 	PremiumBeat, Pond5 \n  \n  Guidance & Instructor: \n Joseph Sheckels \n \n  Development & Images: \n Jason Woolard \n" fontName:@"Arial" fontSize:15.0f];
        credits.position = ccp(viewSize.width/2 , viewSize.height / 2);
        [self addChild:credits];
        
        CCButton *backButton = [CCButton buttonWithTitle:@"< Back" fontName:@"Arial" fontSize:14.0f];
        backButton.position = ccp(viewSize.width/9.5 , viewSize.height / 1.1);
        [backButton setTarget:self selector:@selector(onBackButtonClicked:)];
        [self addChild:backButton];
        
    }
    
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackButtonClicked:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.5f]];}

@end

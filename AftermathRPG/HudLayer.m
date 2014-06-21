//
//  HudLayer.m
//  AftermathRPG
//
//  Created by Jason Woolard on 6/12/14.
//  Copyright (c) 2014 Jason Woolard. All rights reserved.
//

#import "HudLayer.h"
#import "IntroScene.h"
#import "PauseScene.h"

@implementation HudLayer

@synthesize healthBar;
-(id)init
{
    self = [super init];
    
    if (self)
    {
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:22.0f];
            backButton.position = ccp(0.90f * viewSize.width, 0.95f * viewSize.height);
            [backButton setTarget:self selector:@selector(onBackClicked:)];
            [self addChild:backButton];
            
            CCButton *pauseButton = [CCButton buttonWithTitle:@"Pause" fontName:@"Verdana-Bold" fontSize:22.0f];
            pauseButton.position = ccp(0.75f * viewSize.width, 0.95f * viewSize.height);
            [pauseButton setTarget:self selector:@selector(onPauseClicked:)];
            [self addChild:pauseButton];
            
            userInfoTxt = [CCLabelTTF labelWithString:@"Rah" fontName:@"Arial" fontSize:16.0f];
            userInfoTxt.position = ccp(0.75f * viewSize.width, 0.85f * viewSize.height);
            [self addChild:userInfoTxt];
            
            zombiesKilled = [CCLabelTTF labelWithString:@"Zombies Killed: 0" fontName:@"Arial" fontSize:19.0f];
            zombiesKilled.position = ccp(viewSize.width * 0.85, viewSize.height * 0.05 );
            [self addChild:zombiesKilled];
            
            self.healthBar = [CCAnimatedSprite animatedSpriteWithPlist:@"Health.plist"];
            healthBar.position = ccp(0.05f * viewSize.width, 0.95f * viewSize.height);
            [healthBar setFrame:@"Health-4.png"];
            [self addChild:healthBar];

        }
        else
        {
            CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
            backButton.position = ccp(0.90f * viewSize.width, 0.95f * viewSize.height);
            [backButton setTarget:self selector:@selector(onBackClicked:)];
            [self addChild:backButton];
            
            CCButton *pauseButton = [CCButton buttonWithTitle:@"Pause" fontName:@"Verdana-Bold" fontSize:18.0f];
            pauseButton.position = ccp(0.75f * viewSize.width, 0.95f * viewSize.height);
            [pauseButton setTarget:self selector:@selector(onPauseClicked:)];
            [self addChild:pauseButton];
            
            
            zombiesKilled = [CCLabelTTF labelWithString:@"Zombies Killed: 0" fontName:@"Arial" fontSize:15];
            zombiesKilled.position = ccp(viewSize.width * 0.85, viewSize.height * 0.05 );
            [self addChild:zombiesKilled];
            
            self.healthBar = [CCAnimatedSprite animatedSpriteWithPlist:@"Health.plist"];
            healthBar.position = ccp(0.05f * viewSize.width, 0.95f * viewSize.height);
            [healthBar setFrame:@"Health-4.png"];
            [self addChild:healthBar];


        }
    }
    return self;
}
-(void)provideUserInfo:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    if (userInfo)
        
    {
        NSString *text = userInfo[@"textInfo"];
    //    CCActionFadeIn *fadeIn = [CCActionFadeIn actionWithDuration:2.0f];
     //   CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:2.0f];
     //   [userInfoTxt runAction:fadeIn];
        userInfoTxt.string = text;
    //    [userInfoTxt runAction:fadeOut];
        
        //userInfoTxt.string = @"";

    }
}
-(void)updateHealth:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    if (userInfo)
        
    {
        NSString *text = userInfo[@"livesLeft"];
        NSInteger livesLeft = [text integerValue];
        switch (livesLeft)
        {
            case 0:
                [healthBar setFrame:@"Health-1.png"];
                break;
            case 1:
                [healthBar setFrame:@"Health-2.png"];
                break;
            case 2:
                [healthBar setFrame:@"Health-3.png"];
                break;
            case 3:
                [healthBar setFrame:@"Health-4.png"];
                break;
        }
    }
    NSLog(@"Health should be updated...");
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}
- (void)onPauseClicked:(id)sender
{
    CCScene *pauseScene = [PauseScene node];
    // back to intro scene with transition
    [[CCDirector sharedDirector] pushScene:pauseScene];
    [[OALSimpleAudio sharedInstance] stopEverything];

}

// -----------------------------------------------------------------------
- (void) onEnter
{
    [super onEnter];
    NSNotificationCenter* notiCenter = [NSNotificationCenter defaultCenter];
    
    [notiCenter addObserver:self
                   selector:@selector(onUpdateZombieText:)
                       name:@"HudLayerUpdateZombieNotification"
                     object:nil];
    [notiCenter addObserver:self
                   selector:@selector(updateHealth:)
                       name:@"HudLayerUpdateHealthNotification"
                     object:nil];
    [notiCenter addObserver:self
                   selector:@selector(provideUserInfo:)
                       name:@"HudLayerUpdateTextNotification"
                     object:nil];


}
- (void)onExit
{
    [super onExit];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)onUpdateZombieText:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    if (userInfo)
    {
        NSString* text = userInfo[@"zombiesKilled"];
        
        if (text)
        {
            zombiesKilled.string = text;
        }
        else
        {
            CCLOG(@"Text parameter invalid for zombies killed!.");
        }
    }
    else
    {
        CCLOG(@"invalid user info for zombies killed!");
    }
}
@end

//
//  HudLayer.m
//  AftermathRPG
//
//  Created by Jason Woolard on 6/12/14.
//  Copyright (c) 2014 Jason Woolard. All rights reserved.
//

#import "HudLayer.h"
#import "IntroScene.h"

@implementation HudLayer
-(id)init
{
    self = [super init];
    
    if (self)
    {
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        
        
        CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
        backButton.position = ccp(0.85f * viewSize.width, 0.95f * viewSize.height);
        [backButton setTarget:self selector:@selector(onBackClicked:)];
        [self addChild:backButton];
        
        zombiesKilled = [CCLabelTTF labelWithString:@"Zombies Killed: 0" fontName:@"Arial" fontSize:15];
        zombiesKilled.position = ccp(viewSize.width * 0.85, viewSize.height * 0.1 );
        [self addChild:zombiesKilled];
        
        
    }
    return self;
}
-(void)updateZombiesKilled:(NSString*)value
{
    zombiesKilled.string = value;
    NSLog(@"Zombies should be updated...");
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

// -----------------------------------------------------------------------
- (void) onEnter
{
    [super onEnter];
    NSNotificationCenter* notiCenter = [NSNotificationCenter defaultCenter];
    
    [notiCenter addObserver:self
                   selector:@selector(onUpdateZombieText:)
                       name:@"HudLayerUpdateZombieNotification"
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
            [self updateZombiesKilled:text];
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

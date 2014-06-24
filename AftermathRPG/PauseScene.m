//
//  PauseScene.m
//  AftermathRPG
//
//  Created by Jason Woolard on 6/17/14.
//  Copyright (c) 2014 Jason Woolard. All rights reserved.
//

#import "PauseScene.h"
#import "cocos2d.h"
#import "cocos2d.h"
#import "CCButton.h"
#import "IntroScene.h"

@implementation PauseScene
-(id)init
{
    self = [super init];
    
    if (self)
    {
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
      
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            CCLabelTTF *pausedText = [CCLabelTTF labelWithString:@"Game Paused" fontName:@"Arial" fontSize:60.0f];
            pausedText.position = ccp(viewSize.width * 0.50, viewSize.height * 0.75);
            [self addChild:pausedText];

            CCButton *resumeButton = [CCButton buttonWithTitle:@"[ Resume ]" fontName:@"Verdana-Bold" fontSize:30.0f];
            resumeButton.position = ccp(0.50f * viewSize.width, 0.50f * viewSize.height);
            [resumeButton setTarget:self selector:@selector(onResumeClicked:)];
            [self addChild:resumeButton];
            
            CCButton *menuButton = [CCButton buttonWithTitle:@"[ Main Menu ]" fontName:@"Verdana-Bold" fontSize:30.0f];
            menuButton.position = ccp(0.50f * viewSize.width, 0.35f * viewSize.height);
            [menuButton setTarget:self selector:@selector(onMenuClicked:)];
            [self addChild:menuButton];

        }
        else
        {
            CCLabelTTF *pausedText = [CCLabelTTF labelWithString:@"Game Paused" fontName:@"Arial" fontSize:36.0f];
            pausedText.position = ccp(viewSize.width * 0.50, viewSize.height * 0.75);
            [self addChild:pausedText];
            
            CCButton *resumeButton = [CCButton buttonWithTitle:@"[ Resume ]" fontName:@"Verdana-Bold" fontSize:18.0f];
            resumeButton.position = ccp(0.50f * viewSize.width, 0.50f * viewSize.height);
            [resumeButton setTarget:self selector:@selector(onResumeClicked:)];
            [self addChild:resumeButton];
            
            CCButton *menuButton = [CCButton buttonWithTitle:@"[ Main Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
            menuButton.position = ccp(0.50f * viewSize.width, 0.35f * viewSize.height);
            [menuButton setTarget:self selector:@selector(onMenuClicked:)];
            [self addChild:menuButton];

        }
        
        
    }
    return self;
}

- (void)onResumeClicked:(id)sender
{
    [[CCDirector sharedDirector] popScene];

}
-(void)onMenuClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}
@end

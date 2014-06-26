//
//  IntroScene.m
//  AftermathRPG
//
//  Created by Jason Woolard on 6/12/14.
//  Copyright Jason Woolard 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "Level1Scene.h"
#import "CreditsScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];

        // Create a colored background (Dark Grey)
        CCSprite *bgImage = [CCSprite spriteWithImageNamed:@"aftermathBG.png"];
        bgImage.scale = 2.5f;
        [self addChild:bgImage z:-100];

        CCSprite *logo = [CCSprite spriteWithImageNamed:@"aftermathLogo-iPad.png"];
        logo.position =  ccp(viewSize.width * 0.5f, viewSize.height * 0.60f); // Middle of screen
        [self addChild:logo];

        CCButton *playNowButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"playNowBtn-iPad.png"]];
        playNowButton.positionType = CCPositionTypeNormalized;
        playNowButton.position = ccp(0.5f, 0.42f);
        [playNowButton setTarget:self selector:@selector(onPlayNowClicked:)];
        [self addChild:playNowButton];
        
        CCButton *creditsButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"creditsBtn-iPad.png"]];
        creditsButton.positionType = CCPositionTypeNormalized;
        creditsButton.position = ccp(0.5f, 0.25f);
        [creditsButton setTarget:self selector:@selector(onCreditsClicked:)];
        [self addChild:creditsButton];


        
        }
    else
    {
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];

        // Create a colored background (Dark Grey)
        CCSprite *bgImage = [CCSprite spriteWithImageNamed:@"aftermathBG.png"];
        [self addChild:bgImage z:-100];

        CCSprite *logo = [CCSprite spriteWithImageNamed:@"aftermathLogo-iPhone.png"];
        logo.position =  ccp(viewSize.width * 0.5f, viewSize.width * 0.35f); // Middle of screen
        [self addChild:logo];

        CCButton *playNowButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"playNowBtn-iPhone.png"]];
        playNowButton.positionType = CCPositionTypeNormalized;
        playNowButton.position = ccp(0.5f, 0.42f);
        [playNowButton setTarget:self selector:@selector(onPlayNowClicked:)];
        [self addChild:playNowButton];
        
        CCButton *creditsButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"creditsBtn-iPhone.png"]];
        creditsButton.positionType = CCPositionTypeNormalized;
        creditsButton.position = ccp(0.5f, 0.22f);
        [creditsButton setTarget:self selector:@selector(onCreditsClicked:)];
        [self addChild:creditsButton];
    }
    
    [[OALSimpleAudio sharedInstance] playBg:@"MenuTrack.mp3" volume:0.3f pan:0.5f loop:YES];
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onPlayNowClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[Level1Scene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}
- (void)onCreditsClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[CreditsScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end

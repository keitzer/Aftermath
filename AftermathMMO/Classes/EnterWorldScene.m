//
//  EnterWorldScene.m
//  AftermathMMO
//
//  Created by Jason Woolard on 6/3/14.
//  Copyright Jason Woolard 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "EnterWorldScene.h"
#import "IntroScene.h"

// -----------------------------------------------------------------------
#pragma mark - EnterWorldScene
// -----------------------------------------------------------------------

@implementation EnterWorldScene
@synthesize zombiePirate, player, bullet, zombiePirateWalking, background;
// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (EnterWorldScene *)scene
{
    
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    
    // Adding the Background for the Aftermath Map
    // Created Map using Tileset in app called 'Tiled' //
    self.background = [CCSprite spriteWithImageNamed:@"AftermathMap.png"];
    self.background.anchorPoint = CGPointMake(0, 0);
    [self addChild: self.background];
    
    // Adding the Zombie Pirate Enemy
    self.zombiePirate = [CCSprite spriteWithImageNamed:@"zombie-pirate-front.png"];
    self.zombiePirate.position  = ccp(525,205);
    [self addChild: self.zombiePirate];
    
    // Adding the Player
    self.player = [CCSprite spriteWithImageNamed:@"mainCharacterInitial.png"];
    self.player.position  = ccp(185,205);
    [self addChild: self.player];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild: backButton];
    

    
    // done
	return self;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
    
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    [[OALSimpleAudio sharedInstance] playBg:@"SceneTrack.mp3" loop:YES];

    // Adding the bullet projectile
    self.bullet = [CCSprite spriteWithImageNamed:@"bullet.png"];
    // Positioning the bullet
    self.bullet.position = self.player.position;
    // Setting it visible to false, until fired (screen tapped)
    self.bullet.visible = FALSE;
    // Adding bullet as child element
    [self addChild: self.bullet];
    

}

// -----------------------------------------------------------------------

- (void)onExit
{

    
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    // Setting the touchLocation CGPoint to user touched location
    CGPoint touchLocation = [touch locationInNode:self];
    // Obtaining the difference between the touchLocation CGPoint and the main characters position
    CGPoint difference    = ccpSub(touchLocation, self.player.position);
    float ratio = difference.y / difference.x;
    int x = self.player.contentSize.width / 2 + self.contentSize.width;
    int y = (x * ratio) + self.player.position.y;
    self.targetPosition = ccp(x, y);  // Or can use self.zombiePirate.position to just have it target the zombie itself, rather then where the user clicks, maybe for a newbie mode??
   
    // Checking to see if the bullet current has no actions running, if so then run this sequence of events on the bullet projectile
    if (!self.bullet.numberOfRunningActions)
    {
        // Playing GunShot sound when bullet is fired
        [[OALSimpleAudio sharedInstance] playEffect:@"Gunshot.mp3"];
        // Moving bullet projectile to the target's tapped position
        CCActionShow *showBullet = [CCActionShow action];
        CCActionMoveTo *moveBullet = [CCActionMoveTo actionWithDuration:0.6f position:self.targetPosition];
        CCActionRemove *hideBullet = [CCActionHide action];
        // Moving the bullet projectile back to the main character, to be shot again (reusing the same sprite rather then creating a new one each time)
        CCActionDelay *returnBullet = [CCActionMoveTo actionWithDuration:0 position:self.player.position];
        // Action to simply delay the spam of bullets
        CCActionDelay *bulletDelay = [CCActionDelay actionWithDuration:0.6];
        // Running actions in sequence, as opposed to all at the same time
        CCActionSequence* bulletSequence = [CCActionSequence actions:showBullet, moveBullet, hideBullet, returnBullet, bulletDelay, nil];
        [self.bullet runAction: bulletSequence];
    }

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
@end

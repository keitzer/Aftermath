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
{
    CCButton *objectiveRight;
    CCSprite *objectiveLeft;
    CGSize viewSize;
    CCLabelTTF *level1Header;
    CCLabelTTF *level1Objectives;
    CCSprite *inventoryGump;
    CCButton *inventoryCloseGump;
    CCButton *daggerIcon;
    CCLabelTTF *alert;
    CCSprite *collectedBase;
    NSString *pickupText;
    NSString *healthText;
    CCLabelTTF *userHealthTxt;
}
@synthesize healthBar, objectiveGump, sideBar;


-(id)init
{
    self = [super init];
    
    if (self)
    {
        // Setting viewSize constant to size of device window
        viewSize = [[CCDirector sharedDirector] viewSize];
        
        // Checking if user is on iPad or iPhone, then resizing all assets accordingly.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            // User's pick up text (dagger for now)
            userPickupTxt = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:14.0f];
            userPickupTxt.position = ccp(viewSize.width * 0.50, viewSize.height * 0.65 );
            [self addChild:userPickupTxt z:6];
            
            // User's health text
            userHealthTxt = [CCLabelTTF labelWithString:@"" fontName:@"Arial-Bold" fontSize:16.0f];
            userHealthTxt.color = [CCColor colorWithRed:1.0f green:0.0f blue:0.0f];
            userHealthTxt.position = ccp(viewSize.width * 0.325, viewSize.height * 0.965 );
            [self addChild:userHealthTxt];
            
            // Skill Slot (max skills 3 at the moment)
            CCSprite *skillSlot = [CCSprite spriteWithImageNamed:@"skillSlot2.png"];
            skillSlot.position = ccp(viewSize.width * 0.16, viewSize.height * 0.06);
            [self addChild:skillSlot];
            
            // Displaying user objective gump - TODO: Make this it's own object eventually when I go to reuse it for other levels.
            [self displayObjectiveGump:viewSize];
            
            // Shoot button to allow user's to shoot bullet projectiles across the map
            CCButton *shootButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"shoot-iPad.png"]];
            [shootButton setTarget:self selector:@selector(shootButtonClicked:)];
            shootButton.position = ccp(skillSlot.position.x - 87, skillSlot.position.y);
            [self addChild:shootButton];
            
            // User's health bar
            self.healthBar = [CCAnimatedSprite animatedSpriteWithPlist:@"healthBar.plist"];
            healthBar.position = ccp(0.15f * viewSize.width, 0.91f * viewSize.height);
            [healthBar setFrame:@"healthBar-iPad-4.png"];
            [self addChild:healthBar];
            
            // User's side bar with button's overlayed
            self.sideBar = [CCAnimatedSprite animatedSpriteWithPlist:@"sideBar.plist"];
            sideBar.position = ccp(0.87f * viewSize.width, 0.64f * viewSize.height);
            [sideBar setFrame:@"sideBar-iPad-1.png"];
            [self addChild:sideBar];
            
            // Overlay button 1 - Objective Gump Button
            CCButton *objectiveButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"objectiveButton-iPad-1.png"]];
             objectiveButton.position = ccp(0.95f * viewSize.width, 0.596f * viewSize.height);
            [objectiveButton setTarget:self selector:@selector(onShowObjectiveGumpClicked:)];
            [self addChild:objectiveButton];
            
            // Overlay button 2 - Pause Scene Button
            CCButton *pauseButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"pauseButton-iPad-1.png"]];
            pauseButton.position = ccp(0.95f * viewSize.width, 0.47f * viewSize.height);
            [pauseButton setTarget:self selector:@selector(onPauseClicked:)];
            [self addChild:pauseButton];
            
            // Overlay button 3 - Inventory Gump Button
            CCButton *inventoryButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"inventoryButton-iPad-1.png"]];
            inventoryButton.position = ccp(0.95f * viewSize.width, 0.3470f * viewSize.height);
            [inventoryButton setTarget:self selector:@selector(onShowInventoryGumpClicked:)];
            [self addChild:inventoryButton];
        
            // Base background for collected items
            collectedBase = [CCSprite spriteWithImageNamed:@"collectedBg-iPad.png"];
            collectedBase.visible = FALSE;
            collectedBase.position = ccp(viewSize.width *0.5,viewSize.height*0.65);
            [self addChild:collectedBase z:5];
        
            // How to Play label
            CCLabelTTF *howToPlay = [CCLabelTTF labelWithString:@"How To Play: \n-Tap screen to navigate\n-Tap bullet icon to shoot\n-Follow on screen objectives\nbased on the current level!" fontName:@"Arial" fontSize:12.0f];
            howToPlay.position = ccp(viewSize.width * 0.88, viewSize.height * 0.86);
            [self addChild:howToPlay];
            
        }
        else
        {
            
            userPickupTxt = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:8.0f];
            userPickupTxt.position = ccp(viewSize.width * 0.50, viewSize.height * 0.65 );
            [self addChild:userPickupTxt z:6];

            // User's health text
            userHealthTxt = [CCLabelTTF labelWithString:@"" fontName:@"Arial-Bold" fontSize:14.0f];
            userHealthTxt.color = [CCColor colorWithRed:1.0f green:0.0f blue:0.0f];
            userHealthTxt.position = ccp(viewSize.width * 0.325, viewSize.height * 0.965 );
            [self addChild:userHealthTxt];
            
            CCSprite *skillSlot = [CCSprite spriteWithImageNamed:@"skillSlot_iPhone.png"];
            skillSlot.position = ccp(viewSize.width * 0.14, viewSize.height * 0.07);
            [self addChild:skillSlot];
            
            [self displayObjectiveGump:viewSize];

            CCButton *shootButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"shoot-iPhone.png"]];
            [shootButton setTarget:self selector:@selector(shootButtonClicked:)];
            shootButton.position = ccp(skillSlot.position.x - 44, skillSlot.position.y);
            [self addChild:shootButton];

            self.healthBar = [CCAnimatedSprite animatedSpriteWithPlist:@"healthBar.plist"];
            healthBar.position = ccp(0.14f * viewSize.width, 0.89f * viewSize.height);
            [healthBar setFrame:@"healthBar-4.png"];
            [self addChild:healthBar];
            
            self.sideBar = [CCAnimatedSprite animatedSpriteWithPlist:@"sideBar.plist"];
            sideBar.position = ccp(0.88f * viewSize.width, 0.56f * viewSize.height);
            [sideBar setFrame:@"sideBar-iPhone-1.png"];
            [self addChild:sideBar];
            
            CCButton *objectiveButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"objectiveButton-iPhone-1.png"]];
            objectiveButton.position = ccp(0.953f * viewSize.width, 0.506f * viewSize.height);
            [objectiveButton setTarget:self selector:@selector(onShowObjectiveGumpClicked:)];

            [self addChild:objectiveButton];
            
            CCButton *pauseButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"pauseButton-iPhone-1.png"]];
            pauseButton.position = ccp(0.953f * viewSize.width, 0.3565f * viewSize.height);
            [pauseButton setTarget:self selector:@selector(onPauseClicked:)];
            [self addChild:pauseButton];
            
            CCButton *inventoryButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"inventoryButton-iPhone-1.png"]];
            inventoryButton.position = ccp(0.953f * viewSize.width, 0.21 * viewSize.height);
            [inventoryButton setTarget:self selector:@selector(onShowInventoryGumpClicked:)];
            [self addChild:inventoryButton];

            // Base background for collected items
            collectedBase = [CCSprite spriteWithImageNamed:@"collectedBg-iPhone.png"];
            collectedBase.visible = FALSE;
            collectedBase.position = ccp(viewSize.width *0.5,viewSize.height*0.65);
            [self addChild:collectedBase z:5];
            
            // How to Play label
            CCLabelTTF *howToPlay = [CCLabelTTF labelWithString:@"How To Play: \n-Tap screen to move\n-Tap bullet icon to shoot\n-Follow objectives" fontName:@"Arial" fontSize:8.0f];
            howToPlay.position = ccp(viewSize.width * 0.885, viewSize.height * 0.80);
            [self addChild:howToPlay];
        }
    }
    return self;
}
- (void)displayObjectiveGump:(CGSize)size
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

        objectiveLeft = [CCSprite spriteWithImageNamed:@"objectiveGumpLeft-iPad.png"];
        objectiveLeft.position = ccp(size.width * 0.755, size.height * 0.09);
        [self addChild:objectiveLeft];
    
        objectiveRight = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"objectiveGumpRight-iPad.png"]];
        [objectiveRight setTarget:self selector:@selector(hideObjectiveGumpClicked:)];
        objectiveRight.position = ccp(size.width * 0.945, size.height * 0.09);
        [self addChild:objectiveRight];
    
        level1Header = [CCLabelTTF labelWithString:@"Level 1 Objective(s)" fontName:@"Arial" fontSize:14.0f];
        level1Header.position = ccp(objectiveLeft.position.x + 5, objectiveLeft.position.y + 35);
        [self addChild:level1Header];
    
        level1Objectives = [CCLabelTTF labelWithString:@"- Clear the zombies from southern part of town\n- Head to the northern part of the town" fontName:@"Arial" fontSize:12.0f];
        level1Objectives.position = ccp(objectiveLeft.position.x + 5, objectiveLeft.position.y + 10);
        [self addChild:level1Objectives];
    }
    else
    {
        objectiveLeft = [CCSprite spriteWithImageNamed:@"objectiveGumpLeft-iPhone.png"];
        objectiveLeft.position = ccp(size.width * 0.55, size.height * 0.1);
        [self addChild:objectiveLeft];
        
        objectiveRight = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"objectiveGumpRight-iPhone.png"]];
        [objectiveRight setTarget:self selector:@selector(hideObjectiveGumpClicked:)];
        objectiveRight.position = ccp(size.width * 0.724, size.height * 0.1);
        [self addChild:objectiveRight];
        
        level1Header = [CCLabelTTF labelWithString:@"Level 1 Objective(s)" fontName:@"Arial" fontSize:12.0f];
        level1Header.position = ccp(objectiveLeft.position.x + 5, objectiveLeft.position.y + 13);
        [self addChild:level1Header];
        
        level1Objectives = [CCLabelTTF labelWithString:@"- Kill all zombies\n- Head north in town" fontName:@"Arial" fontSize:10.0f];
        level1Objectives.position = ccp(objectiveLeft.position.x + 5, objectiveLeft.position.y - 5);
        [self addChild:level1Objectives];

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
- (void)onPauseClicked:(id)sender
{
    CCScene *pauseScene = [PauseScene node];
    // back to intro scene with transition
    [[CCDirector sharedDirector] pushScene:pauseScene];
    [[OALSimpleAudio sharedInstance] stopEverything];

}
-(void)onShowObjectiveGumpClicked:(id)sender
{
    [objectiveRight removeFromParent];
    [objectiveLeft removeFromParent];
    [level1Header removeFromParent];
    [level1Objectives removeFromParent];
    [self displayObjectiveGump:viewSize];
}
-(void)shootButtonClicked:(id)sender
{
    NSString* notiName2 = @"Level1GameLayerShootGun";
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName2
                                                        object:self userInfo:nil];
}
- (void)hideObjectiveGumpClicked:(id)sender
{
    [objectiveRight removeFromParent];
    [objectiveLeft removeFromParent];
    [level1Header removeFromParent];
    [level1Objectives removeFromParent];
}
- (void)hideInventoryGumpClicked:(id)sender
{
    [daggerIcon removeFromParent];
    [inventoryCloseGump removeFromParent];
    [inventoryGump removeFromParent];
    [[OALSimpleAudio sharedInstance] playEffect:@"leather_inventory.wav" volume:0.3f pitch:1.0f pan:10.0f loop:0];

    
}
- (void) onShowInventoryGumpClicked:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [inventoryCloseGump removeFromParent];
        [inventoryGump removeFromParent];
        [daggerIcon removeFromParent];
        
        [[OALSimpleAudio sharedInstance] playEffect:@"leather_inventory.wav" volume:0.3f pitch:1.0f pan:10.0f loop:0];

        inventoryGump = [CCSprite spriteWithImageNamed:@"inventoryGump-iPad.png"];
        inventoryGump.position = ccp(viewSize.width * 0.50, viewSize.height * 0.50);
        [self addChild:inventoryGump];
        
        inventoryCloseGump = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"inventoryCloseBtn-iPad.png"]];
        [inventoryCloseGump setTarget:self selector:@selector(hideInventoryGumpClicked:)];
        inventoryCloseGump.position = ccp(viewSize.width * 0.634, viewSize.height * 0.605);
        [self addChild:inventoryCloseGump];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *value = [defaults stringForKey:@"daggerPickedUp"];
        if ([value isEqualToString:@"YES"])
        {
            daggerIcon = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"inventory-dagger-iPad.png"]];
            daggerIcon.position = ccp(inventoryGump.position.x -97,inventoryGump.position.y + 8);
            [self addChild:daggerIcon];
        }
        else
        {
            
        }
    }
    else
    {
        [inventoryCloseGump removeFromParent];
        [inventoryGump removeFromParent];
        [daggerIcon removeFromParent];
        
        [[OALSimpleAudio sharedInstance] playEffect:@"leather_inventory.wav" volume:0.3f pitch:1.0f pan:10.0f loop:0];

        inventoryGump = [CCSprite spriteWithImageNamed:@"inventoryGump-iPhone.png"];
        inventoryGump.position = ccp(viewSize.width * 0.50, viewSize.height * 0.50);
        [self addChild:inventoryGump];
        
        inventoryCloseGump = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"inventoryCloseBtn-iPhone.png"]];
        [inventoryCloseGump setTarget:self selector:@selector(hideInventoryGumpClicked:)];
        inventoryCloseGump.position = ccp(viewSize.width * 0.621, viewSize.height * 0.625);
        [self addChild:inventoryCloseGump];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *value = [defaults stringForKey:@"daggerPickedUp"];
        NSLog(@"%@", value);
        if ([value isEqualToString:@"YES"])
        {
            daggerIcon = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"inventory-dagger-iPhone.png"]];
            daggerIcon.position = ccp(inventoryGump.position.x - 48,inventoryGump.position.y + 4);
            [self addChild:daggerIcon];
        }
        else
        {
            
        }

        
    }
}
// -----------------------------------------------------------------------
#pragma mark - onEnter / onExit
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
                   selector:@selector(showCollectionGump:)
                       name:@"HudLayerUpdateTextNotification"
                     object:nil];
    [notiCenter addObserver:self
                   selector:@selector(setHealthText:)
                       name:@"HudLayerUpdateHealthTextNotification"
                     object:nil];

}
- (void)onExit
{
    [super onExit];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// -----------------------------------------------------------------------
#pragma mark - Update UI
// -----------------------------------------------------------------------
-(void)showCollectionGump:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    if (userInfo)
        
    {
        pickupText = userInfo[@"textInfo"];
        
        CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:1.8f];
        CCActionFadeIn *show = [CCActionShow action];
        CCActionFadeOut *hide = [CCActionHide action];
        CCActionFadeOut *delay = [CCActionDelay actionWithDuration:1.8f];
        
        CCActionSequence *showAndHideText= [CCActionSequence actions: [CCActionCallFunc actionWithTarget:self selector:@selector(setText)], fadeOut, [CCActionCallFunc actionWithTarget:self selector:@selector(resetText)], nil];
        CCActionSequence *showAndHideGump= [CCActionSequence actions: show, delay, hide, nil];
        
        [userPickupTxt runAction:showAndHideText];
        [collectedBase runAction:showAndHideGump];
        
    }
}
- (void)onUpdateZombieText:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    if (userInfo)
    {
        NSString* zText = userInfo[@"zombiesKilled"];
        
        if (zText)
        {
            zombiesKilled.string = pickupText;
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
-(void) setText
{
    userPickupTxt.string = pickupText;
}
-(void) resetText
{
    userPickupTxt.string = @"";
}
-(void)setHealthTxt
{
    userHealthTxt.string = healthText;
}
-(void)resetHealthTxt
{
    userHealthTxt.string = @"";
}
-(void) setHealthText:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    if (userInfo)
        
    {
        healthText = userInfo[@"textInfo"];
        
        CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:2.5f];
        
        CCActionSequence *showAndHideText= [CCActionSequence actions: [CCActionCallFunc actionWithTarget:self selector:@selector(setHealthTxt)], fadeOut, [CCActionCallFunc actionWithTarget:self selector:@selector(resetHealthText)], nil];
        
        [userHealthTxt runAction:showAndHideText];
    }
}
-(void) resetHealthText
{
    userHealthTxt.string = @"";
}
-(void)updateHealth:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    if (userInfo)
        
    {
        NSString *lText = userInfo[@"livesLeft"];
        NSInteger livesLeft = [lText integerValue];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            switch (livesLeft)
            {
                case 0:
                    [healthBar setFrame:@"healthBar-iPad-1.png"];
                    break;
                case 1:
                    [healthBar setFrame:@"healthBar-iPad-2.png"];
                    break;
                case 2:
                    [healthBar setFrame:@"healthBar-iPad-3.png"];
                    break;
                case 3:
                    [healthBar setFrame:@"healthBar-iPad-4.png"];
                    break;
            }
        }
        else
        {
            switch (livesLeft)
            {
                case 0:
                    [healthBar setFrame:@"healthBar-1.png"];
                    break;
                case 1:
                    [healthBar setFrame:@"healthBar-2.png"];
                    break;
                case 2:
                    [healthBar setFrame:@"healthBar-3.png"];
                    break;
                case 3:
                    [healthBar setFrame:@"healthBar-4.png"];
                    break;
            }
        }
    }
    NSLog(@"Health should be updated...");
}
@end

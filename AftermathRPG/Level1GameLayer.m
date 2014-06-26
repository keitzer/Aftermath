//
//  Level1GameLayer.m
//  AftermathRPG
//
//  Created by Jason Woolard on 6/12/14.
//  Copyright (c) 2014 Jason Woolard. All rights reserved.
//

#import "Level1GameLayer.h"
#import "GameOverScene.h"
#import "HudLayer.h"
#import "CCAnimatedSprite.h"
#import "LevelUpScene.h"

@implementation Level1GameLayer
{
    BOOL holdingDagger;
    BOOL daggerPickedUp;
    int zombiesDropped;
    int livesLeft;
    /* 0 = North
       1 =  South
       2 =  East
       3 = West */
    int charDirection;
    CCActionMoveTo *moveBullet;
    CCActionMoveTo *repositionBullet;
    CCActionShow *showBullet;
    CCActionRemove *hideBullet;
    CCActionDelay *returnBullet;
    CCActionDelay *bulletDelay;
    
}
@synthesize levelOneMap, metaTileLayer, mainChar, zombiePirate, zombieBoss, zombieHumanTwo, zombieHumanOne, dagger,physicsWorldNode, metaTileTwoLayer, bullet;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        // Enable touch handling on scene node
        self.userInteractionEnabled = YES;
        

        // Setting the levelOneMap to the one created in Tiled
        self.levelOneMap = [CCTiledMap tiledMapWithFile:@"AftermathRPG-Level1.tmx"];
        
        // Setting the Meta Layer to the layer created to prevent players from colliding, and allow them to pick up items throughout the level
        self.metaTileLayer = [levelOneMap layerNamed:@"meta"];
        
        // Making Meta Layer invisible, as they're acting rather then providing visual appearance
        metaTileLayer.visible = NO;
        
        // Setting the Meta Layer to the layer created to prevent players from colliding, and allow them to pick up items throughout the level
        self.metaTileTwoLayer = [levelOneMap layerNamed:@"meta2"];
        
        // Making Meta Layer invisible, as they're acting rather then providing visual appearance
        metaTileTwoLayer.visible = NO;
        
        // Setting content size of layer to the map size
        self.contentSize = levelOneMap.contentSize;
        
        // Adding Map to the Scene
        [self addChild:levelOneMap z:-1];
        
        self.physicsWorldNode = [CCPhysicsNode node];
        self.physicsWorldNode.collisionDelegate = self;
        self.physicsWorldNode.debugDraw = NO;
        self.physicsWorldNode.gravity = ccp(0,0);
        [self addChild:self.physicsWorldNode];
        
        // Spawning Sprites to Scene
        [self spawnLevelOneSprites];
        [self schedule:@selector(animateMonsters) interval:12];
        
        // Setting default of dagger not picked up through NSUserDefaults to be used in HUD Layer
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"NO" forKey:@"daggerPickedUp"];
        [defaults synchronize];
        
        daggerPickedUp = NO;
        holdingDagger = NO;
        zombiesDropped = 0;
        livesLeft = 3;
        
        // Setting character direction to facing east by default
        charDirection = 1;
        
        [self setCenterOfScreen:mainChar.position];

      //  NSLog(@"%@, %@, %@",NSStringFromCGPoint(self.zombiePirate.position) , NSStringFromCGPoint(self.zombieHumanOne.position), NSStringFromCGPoint(self.zombieHumanTwo.position));

        // Adding the bullet projectile
        self.bullet = [CCSprite spriteWithImageNamed:@"bullet.png"];
        // Positioning the bullet
        self.bullet.position = ccp(0,0);
        // Setting it visible to false, until fired (screen tapped)
        self.bullet.visible = FALSE;
        self.bullet.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.bullet.contentSize} cornerRadius:0];
        // Setting the Collison Group & Type for further comparison later on...
        self.bullet.physicsBody.collisionGroup = @"groupPlayer";
        self.bullet.physicsBody.collisionType = @"collisionAmmo";
        // Adding Bullet to the Physics World
        [self.physicsWorldNode addChild: self.bullet];
        
        NSNotificationCenter* notiCenter = [NSNotificationCenter defaultCenter];
        
        [notiCenter addObserver:self
                       selector:@selector(shootBulletsFromGun:)
                           name:@"Level1GameLayerShootGun"
                         object:nil];
    }
    return self;
}
- (void) shootBulletsFromGun:(id)sender
{
    // Checking to see if the bullet current has no actions running, if so then run this sequence of events on the bullet projectile
    if (!self.bullet.numberOfRunningActions)
    {
        // Playing GunShot sound when bullet is fired
        [[OALSimpleAudio sharedInstance] playEffect:@"Gunshot.mp3" volume:0.3f pitch:1.0f pan:10.0f loop:0];
        // Moving bullet projectile to the target's tapped position
        repositionBullet = [CCActionMoveTo actionWithDuration:0 position:self.mainChar.position];
        showBullet = [CCActionShow action];
        hideBullet = [CCActionHide action];
        // Moving the bullet projectile back to the main character, to be shot again (reusing the same sprite rather then creating a new one each time)
        returnBullet = [CCActionMoveTo actionWithDuration:0 position:self.mainChar.position];
        // Action to simply delay the spam of bullets
        bulletDelay = [CCActionDelay actionWithDuration:0.6];
        
        if (charDirection == 0)
        {
            
            moveBullet = [CCActionMoveTo actionWithDuration:0.6f position:ccp(mainChar.position.x, mainChar.position.y + 350)];
            CCActionRotateBy *rotateBullet = [CCActionRotateBy actionWithDuration:0 angle:270];
            CCActionRotateBy *rotateBulletBack = [CCActionRotateBy actionWithDuration:0 angle:90];
            bullet.flipX = NO;
            
            // Running actions in sequence, as opposed to all at the same time
            CCActionSequence* bulletSequence = [CCActionSequence actions: repositionBullet, rotateBullet,showBullet, moveBullet, hideBullet, rotateBulletBack, returnBullet, bulletDelay, nil];
            [self.bullet runAction: bulletSequence];
        }
        else if (charDirection == 1)
        {
            moveBullet = [CCActionMoveTo actionWithDuration:0.6f position:ccp(mainChar.position.x, mainChar.position.y - 350)];
            CCActionRotateBy *rotateBullet = [CCActionRotateBy actionWithDuration:0 angle:90];
            CCActionRotateBy *rotateBulletBack = [CCActionRotateBy actionWithDuration:0 angle:270];
            bullet.flipX = NO;
            
            // Running actions in sequence, as opposed to all at the same time
            CCActionSequence* bulletSequence = [CCActionSequence actions: repositionBullet, rotateBullet,showBullet, moveBullet, hideBullet, rotateBulletBack, returnBullet, bulletDelay, nil];
            [self.bullet runAction: bulletSequence];
        }
        else if (charDirection == 2)
        {
            moveBullet = [CCActionMoveTo actionWithDuration:0.6f position:ccp(mainChar.position.x + 350, mainChar.position.y)];
            bullet.flipX = NO;
            // Running actions in sequence, as opposed to all at the same time
            CCActionSequence* bulletSequence = [CCActionSequence actions: repositionBullet,showBullet, moveBullet, hideBullet, returnBullet, bulletDelay, nil];
            [self.bullet runAction: bulletSequence];
            
            
        }
        else if (charDirection == 3)
        {
            moveBullet = [CCActionMoveTo actionWithDuration:0.6f position:ccp(mainChar.position.x - 350, mainChar.position.y)];
            bullet.flipX = YES;
            // Running actions in sequence, as opposed to all at the same time
            CCActionSequence* bulletSequence = [CCActionSequence actions: repositionBullet,showBullet, moveBullet, hideBullet, returnBullet, bulletDelay, nil];
            [self.bullet runAction: bulletSequence];
            
            
        }
        else
        {
        }
    }
}

-(void) onEnter
{
    [super onEnter];
   
}
- (void)setCenterOfScreen:(CGPoint) position {
    // Setting the user's screensize to a CGSize var to be used
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    // Setting x and y integers to the max value of positions' x & y to the center of the screen
    int x = MAX(position.x, screenSize.width / 2);
    int y = MAX(position.y, screenSize.height / 2);
    
    // Setting the minimum x / y center to the maps width & height times the  maps individual tileSize (total size), minus the users viewsize / 2
    x = MIN(x, levelOneMap.mapSize.width * levelOneMap.tileSize.width - screenSize.width / 2);
    y = MIN(y, levelOneMap.mapSize.height * levelOneMap.tileSize.height - screenSize.height / 2);
    
    // Setting the good point
    CGPoint goodPoint = ccp(x,y);
    // Obtaining center of screen and storing it to centerOfScreen var
    CGPoint centerOfScreen = ccp(screenSize.width / 2, screenSize.height / 2);
    // Subtracting the difference between the center of the user's screen & goodPoint
    CGPoint difference = ccpSub(centerOfScreen, goodPoint);
    // Setting the position to the difference
    self.position = difference;
}
-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    // Storing touched location
    CGPoint touchLoc = [touch locationInNode:self];
    // Storing current players location, as well as the difference between the touched location and player position
    CGPoint playerPos = mainChar.position;
    CGPoint diff = ccpSub(touchLoc, playerPos);
    
    // If the abstract value of the difference in X is greater then Y's...
    // Meaning, did the user tap further left or right then up or down based on their current position...
    // If further left or right..
    if (abs(diff.x) > abs(diff.y))
    {
        // If difference in x is greater than 0
        if (diff.x > 0)
        {
            // Move player to the right a tile
            playerPos.x += levelOneMap.tileSize.width;
            self.mainChar.flipX = NO;
            charDirection = 2;
            [mainChar runAnimation:@"AnimateChar"];

        }
        else
        {
            // Move player to the left a tile
            
            playerPos.x -= levelOneMap.tileSize.width;
            self.mainChar.flipX = YES;
            charDirection = 3;
            [mainChar runAnimation:@"AnimateChar"];

        }
    }
    // Further up or down..
    else
    {
        if (diff.y > 0)
        {
            // Move player up a tile
            playerPos.y += levelOneMap.tileSize.height;
            charDirection = 0;
            [mainChar runAnimation:@"AnimateChar-N"];

        }
        else
        {
            // Move player down a tiles
            playerPos.y -= levelOneMap.tileSize.height;
            charDirection = 1;
            [mainChar runAnimation:@"AnimateChar-S"];
        }
    }
    // If player's position is less then or equal to the level's map size, and it's greater than 0,0
    // than...set the player's position
    if (playerPos.x <= (levelOneMap.mapSize.width * levelOneMap.tileSize.width) &&
        playerPos.y <= (levelOneMap.mapSize.height * levelOneMap.tileSize.height) &&
        playerPos.y >= 0 &&
        playerPos.x >= 0)
    {
        // Obtaining user's requested position and storing it into CGPoint
        CGPoint mapTileCoords = [self returnCoordsFromPosition:playerPos];
        // Obtaining tileGID properties for requested tile position
        int tileGidCheck = [metaTileLayer tileGIDAt:mapTileCoords];
        int tileGidCheck2 = [metaTileTwoLayer tileGIDAt:mapTileCoords];
        
        // If indeed in the metaLayer, and contains collidable property set to true, then return out of method and prevent location from being set
        if (tileGidCheck) {
            NSDictionary *properties = [levelOneMap propertiesForGID:tileGidCheck];
            if (properties) {
                // Setting properties Collidable to be checked, then performing the appropriate action after checking tile
                NSString *checkCollision = properties[@"Collidable"];
                NSString *checkCollectable = properties[@"Collectable"];
                if (checkCollision && [checkCollision isEqualToString:@"True"]) {
                    // Return out of method / ie. do not call the mainChar.position = position line beneath this conditional
                    return;
                    NSLog(@"Meta Tile (Wall Blocker) detected!");
                }
                else if (checkCollectable && [checkCollectable isEqualToString:@"True"])
                {
                    if (daggerPickedUp == NO)
                    {
                        NSLog(@"Meta Tile (Collectable) detected!");
                        [[OALSimpleAudio sharedInstance] playEffect:@"itemPickup.mp3" volume:10.0f pitch:1.0f pan:0 loop:NO];
                        
                        NSDictionary* userInfo2 = @{@"textInfo" : @"Dagger found!"};
                        NSString* notiName2 = @"HudLayerUpdateTextNotification";
                        [[NSNotificationCenter defaultCenter] postNotificationName:notiName2
                                                                            object:self userInfo:userInfo2];
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        [defaults setObject:@"YES" forKey:@"daggerPickedUp"];
                        [defaults synchronize];
                        
                        daggerPickedUp = YES;
                        CCAction *blockAction = [CCActionCallBlock actionWithBlock:^{
                            [dagger removeFromParentAndCleanup:YES];
                            holdingDagger = YES;
                        }];
                        [dagger runAction:blockAction];
                    }
                }
            }
        }
        else if (tileGidCheck2)
        {
            NSDictionary *properties = [levelOneMap propertiesForGID:tileGidCheck2];
            if (properties) {
                NSString *checkDeadEnd = properties[@"DeadEnd"];
                NSString *checkLevelUp = properties[@"LevelUp"];
                if (checkDeadEnd && [checkDeadEnd isEqualToString:@"True"])
                {
                    NSDictionary* userInfo2 = @{@"textInfo" : @"Hazardous Area!"};
                    NSString* notiName2 = @"HudLayerUpdateTextNotification";
                    [[NSNotificationCenter defaultCenter] postNotificationName:notiName2
                                                                        object:self userInfo:userInfo2];
                }
                else if (checkLevelUp && [checkLevelUp isEqualToString:@"True"])
                {
                    if (zombiesDropped >=4)
                    {
                        // Go to level up scene
                        NSLog(@"CheckLevelUpHit");
                        [[CCDirector sharedDirector] replaceScene:[LevelUpScene scene]
                                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
                        
                    }
                    else
                    {
                        // Alert user to check map for remaining zombies
                        NSDictionary* userInfo2 = @{@"textInfo" : @"Clear all the zombies!"};
                        NSString* notiName2 = @"HudLayerUpdateTextNotification";
                        [[NSNotificationCenter defaultCenter] postNotificationName:notiName2
                                                                            object:self userInfo:userInfo2];

                    }
                }
                else
                {
                    
                }
            }
        }
        // Setting characters position, granted no collison detected
        CCActionMoveTo *moveChar = [CCActionMoveTo actionWithDuration:0.5 position:playerPos];
        CCActionSequence *moveCharacter = [CCActionSequence actions: moveChar, [CCActionDelay actionWithDuration:2.0f], nil];
        [mainChar runAction:moveCharacter];
    }
    // Setting the center of screen on the character
    [self setCenterOfScreen:mainChar.position];
}
- (void) setPlayerPosition:(CGPoint)position
{
    NSLog(@"Setting Player Position!");

}
- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [mainChar stopAnimation];
   // [mainChar stopAllActions];
}
// Add new method
- (CGPoint)returnCoordsFromPosition:(CGPoint)position {
    // Obtaining and returning coordinates from position
    int x = position.x / levelOneMap.tileSize.width;
    int y = ((levelOneMap.mapSize.height * levelOneMap.tileSize.height) - position.y) / levelOneMap.tileSize.height;
    
    return ccp(x, y);
}
- (void)spawnLevelOneSprites
{
    CCTiledMapObjectGroup *objects0  =    [levelOneMap objectGroupNamed:@"mainChar"];
    NSMutableDictionary *startPoint0 =    [objects0 objectNamed:@"startPosition"];
    int x0 = [[startPoint0 valueForKey:@"x"] intValue];
    int y0 = [[startPoint0 valueForKey:@"y"] intValue];
    self.mainChar     = [CCAnimatedSprite animatedSpriteWithPlist:@"AnimateChar.plist"];
    mainChar.position = ccp(x0,y0);
    [mainChar setFrame:@"AnimateChar-S-1.png"];
    mainChar.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, mainChar.contentSize} cornerRadius:0];
    mainChar.physicsBody.collisionGroup = @"groupPlayer";
    mainChar.physicsBody.collisionType = @"collisionPlayer";
    [mainChar addAnimationwithDelayBetweenFrames:0.1f name:@"AnimateChar"];
    [mainChar addAnimationwithDelayBetweenFrames:0.1f name:@"AnimateChar-N"];
    [mainChar addAnimationwithDelayBetweenFrames:0.1f name:@"AnimateChar-S"];
    [self.physicsWorldNode addChild: mainChar];
    
    CCTiledMapObjectGroup *objects1  =    [levelOneMap objectGroupNamed:@"zombiePirate"];
    NSMutableDictionary *startPoint1 =    [objects1 objectNamed:@"startPoint"];
    int x1 = [[startPoint1 valueForKey:@"x"] intValue];
    int y1 = [[startPoint1 valueForKey:@"y"] intValue];
    self.zombiePirate     = [CCAnimatedSprite animatedSpriteWithPlist:@"zombiePirate.plist"];
    [zombiePirate setFrame:@"zombiePirate-1.png"];

    zombiePirate.position = ccp(x1,y1);
    zombiePirate.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, zombiePirate.contentSize} cornerRadius:0];
    zombiePirate.physicsBody.collisionGroup = @"groupMonster";
    zombiePirate.physicsBody.collisionType = @"collisionMonster";
    [zombiePirate addAnimationwithDelayBetweenFrames:0.1f name:@"zombiePirate"];

    [self.physicsWorldNode addChild: zombiePirate];

    CCTiledMapObjectGroup *objects2  =    [levelOneMap objectGroupNamed:@"zombieChar1"];
    NSMutableDictionary *startPoint2 =    [objects2 objectNamed:@"startPoint"];
    int x2 = [[startPoint2 valueForKey:@"x"] intValue];
    int y2 = [[startPoint2 valueForKey:@"y"] intValue];
    self.zombieHumanOne     = [CCAnimatedSprite animatedSpriteWithPlist:@"zombieHuman.plist"];
    [zombieHumanOne setFrame:@"zombieHuman-1.png"];
    zombieHumanOne.position = ccp(x2,y2);
    zombieHumanOne.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, zombieHumanOne.contentSize} cornerRadius:0];
    zombieHumanOne.physicsBody.collisionGroup = @"groupMonster";
    zombieHumanOne.physicsBody.collisionType = @"collisionMonster";
    [zombieHumanOne addAnimationwithDelayBetweenFrames:0.1f name:@"zombieHuman"];
    [self.physicsWorldNode addChild: zombieHumanOne];
    
    CCTiledMapObjectGroup *objects3  =    [levelOneMap objectGroupNamed:@"zombieChar2"];
    NSMutableDictionary *startPoint3 =    [objects3 objectNamed:@"startPoint"];
    int x3 = [[startPoint3 valueForKey:@"x"] intValue];
    int y3 = [[startPoint3 valueForKey:@"y"] intValue];
    self.zombieHumanTwo     = [CCAnimatedSprite animatedSpriteWithPlist:@"zombieHuman2.plist"];
    [zombieHumanTwo setFrame:@"zombieHuman2-1.png"];
    zombieHumanTwo.position = ccp(x3,y3);
    zombieHumanTwo.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, zombieHumanTwo.contentSize} cornerRadius:0];
    zombieHumanTwo.physicsBody.collisionGroup = @"groupMonster";
    zombieHumanTwo.physicsBody.collisionType = @"collisionMonster";
    [zombieHumanTwo addAnimationwithDelayBetweenFrames:0.1f name:@"zombieHuman2"];
    [zombieHumanTwo addAnimationwithDelayBetweenFrames:0.1f name:@"zombieHuman2-N"];
    [self.physicsWorldNode addChild: zombieHumanTwo];
    
    CCTiledMapObjectGroup *objects4  =    [levelOneMap objectGroupNamed:@"zombieBoss"];
    NSMutableDictionary *startPoint4 =    [objects4 objectNamed:@"startPoint"];
    int x4 = [[startPoint4 valueForKey:@"x"] intValue];
    int y4 = [[startPoint4 valueForKey:@"y"] intValue];
    self.zombieBoss     = [CCSprite spriteWithImageNamed:@"zombieBoss.png"];
    zombieBoss.position = ccp(x4,y4);
    zombieBoss.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, zombieBoss.contentSize} cornerRadius:0];
    zombieBoss.physicsBody.collisionGroup = @"groupMonster";
    zombieBoss.physicsBody.collisionType = @"collisionMonster";
    [self.physicsWorldNode addChild: zombieBoss];

    CCTiledMapObjectGroup *objects5  =    [levelOneMap objectGroupNamed:@"spawn"];
    NSMutableDictionary *startPoint5 =    [objects5 objectNamed:@"daggerSpawn"];
    int x5 = [[startPoint5 valueForKey:@"x"] intValue];
    int y5 = [[startPoint5 valueForKey:@"y"] intValue];
    self.dagger     = [CCSprite spriteWithImageNamed:@"dagger.png"];
    dagger.position = ccp(x5,y5);
    [self addChild:dagger];
}

#pragma mark - Collisions
// Method to call when there is a collision between ammo & a monster npc!
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair collisionMonster:(CCNode *)monster collisionAmmo:(CCNode *)ammo
{
    [monster stopAllActions];
    
    // Playing the zombie sound effect with maximized volume, and of course no loop, once the zombie npc is hit
    
    [[OALSimpleAudio sharedInstance] playEffect:@"Zombie.mp3" volume:10.0f pitch:1.0f pan:0 loop:NO];
    
    CCActionRotateTo* actionSpin = [CCActionRotateBy actionWithDuration:0 angle:90];
    [monster runAction:actionSpin];
    
    CCActionDelay *corpseDecayDelay = [CCActionDelay actionWithDuration:0.6];
    CCActionFadeOut *corpseFade = [CCActionFadeOut actionWithDuration:0.3];
    
    CCActionRemove *removeElement = [CCActionRemove action];
    CCActionSequence* monsterDeathSequence = [CCActionSequence actions:corpseDecayDelay,corpseFade, removeElement, nil];
    [monster runAction:monsterDeathSequence];
    
    [self zombieKilledUpdateHud];

    return YES;
}

- (void)zombieKilledUpdateHud
{
    zombiesDropped++;
    if (zombiesDropped >= 4)
    {
        NSDictionary* userInfo2 = @{@"textInfo" : @"Level clear, head north!"};
        NSString* notiName2 = @"HudLayerUpdateTextNotification";
        [[NSNotificationCenter defaultCenter] postNotificationName:notiName2
                                                            object:self userInfo:userInfo2];
    }
    else
    {
        NSDictionary* userInfo2 = @{@"textInfo" : @"+50 xp"};
        NSString* notiName2 = @"HudLayerUpdateTextNotification";
        [[NSNotificationCenter defaultCenter] postNotificationName:notiName2
                                                            object:self userInfo:userInfo2];
    }
    NSDictionary* userInfo = @{@"zombiesKilled" : [NSString stringWithFormat:@"Zombies Killed: %d", zombiesDropped]};
    NSString* notiName = @"HudLayerUpdateZombieNotification";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName
                                                        object:self userInfo:userInfo];
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair collisionPlayer:(CCNode *)user collisionMonster:(CCNode *)monster
{
    if (holdingDagger)
    {
        [monster stopAllActions];
    
        // Playing the zombie sound effect with maximized volume, and of course no loop, once the zombie npc is hit
        
        [[OALSimpleAudio sharedInstance] playEffect:@"Zombie.mp3" volume:10.0f pitch:1.0f pan:0 loop:NO];
        
        CCActionRotateTo* actionSpin = [CCActionRotateBy actionWithDuration:0 angle:90];
        [monster runAction:actionSpin];
        
        CCActionDelay *corpseDecayDelay = [CCActionDelay actionWithDuration:0.6];
        CCActionFadeOut *corpseFade = [CCActionFadeOut actionWithDuration:0.3];
        
        CCActionRemove *removeElement = [CCActionRemove action];
        CCActionSequence* monsterDeathSequence = [CCActionSequence actions:corpseDecayDelay,corpseFade, removeElement, nil];
        [monster runAction:monsterDeathSequence];
        
        [self zombieKilledUpdateHud];
    }
    else
    {
        if (livesLeft >= 1)
        {
            [[OALSimpleAudio sharedInstance] playEffect:@"DeathByZombie.mp3" volume:0.7f pitch:1.0f pan:0 loop:NO];
            livesLeft--;
            
            NSDictionary* userInfo = @{@"livesLeft" : [NSString stringWithFormat:@"%d", livesLeft]};
            NSString* notiName = @"HudLayerUpdateHealthNotification";
            [[NSNotificationCenter defaultCenter] postNotificationName:notiName
                                                                object:self userInfo:userInfo];
            NSDictionary* userInfo2 = @{@"textInfo" : @"-1 life"};
            NSString* notiName2 = @"HudLayerUpdateHealthTextNotification";
            [[NSNotificationCenter defaultCenter] postNotificationName:notiName2
                                                                object:self userInfo:userInfo2];
        }
        else
        {
            [[OALSimpleAudio sharedInstance] playEffect:@"gameOver.mp3" volume:0.7f pitch:1.0f pan:10.0f loop:0];
            
            CCActionRemove *removeElement = [CCActionRemove action];
            [user runAction:removeElement];
            
            [[CCDirector sharedDirector] replaceScene:[GameOverScene scene]
                                       withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
        }

    }
        return NO;
}
#pragma mark - Animations

- (void)animateMonsters {
  
    int minimumTime = 3.0;
    int maximumTime = 6.0;
    int rangeDuration = maximumTime - minimumTime;
    int randomDuration = (arc4random() % rangeDuration) + (minimumTime * 0.8);
    
    CCAction *actionMove = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombiePirate.position.x -100, zombiePirate.position.y)];
    CCAction *actionMove2 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombiePirate.position.x +100, zombiePirate.position.y)];
    CCAction *actionMove3 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombiePirate.position.x -50, zombiePirate.position.y)];
    CCAction *actionMove4 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombiePirate.position.x +50, zombiePirate.position.y)];
    
    
    CCTiledMapObjectGroup *objects1  =    [levelOneMap objectGroupNamed:@"zombiePirate"];
    NSMutableDictionary *startPoint1 =    [objects1 objectNamed:@"startPoint"];
    int x1 = [[startPoint1 valueForKey:@"x"] intValue];
    int y1 = [[startPoint1 valueForKey:@"y"] intValue];
    CCAction *resetMoves = [CCActionMoveTo actionWithDuration:2 position:ccp(x1,y1)];
    
    CCAction *actionMove5 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombieHumanOne.position.x +50, zombieHumanOne.position.y)];
    CCAction *actionMove6 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombieHumanOne.position.x -50, zombieHumanOne.position.y)];
    CCAction *actionMove7 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombieHumanOne.position.x +50, zombieHumanOne.position.y)];
    CCAction *actionMove8 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombieHumanOne.position.x -50, zombieHumanOne.position.y)];
  
    
    CCTiledMapObjectGroup *objects2  =    [levelOneMap objectGroupNamed:@"zombieChar1"];
    NSMutableDictionary *startPoint2 =    [objects2 objectNamed:@"startPoint"];
    int x2 = [[startPoint2 valueForKey:@"x"] intValue];
    int y2 = [[startPoint2 valueForKey:@"y"] intValue];
    CCAction *resetMoves2 = [CCActionMoveTo actionWithDuration:2 position:ccp(x2,y2)];

    CCAction *actionMove9 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombieHumanTwo.position.x, zombieHumanTwo.position.y + 50)];
    CCAction *actionMove10 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombieHumanTwo.position.x, zombieHumanTwo.position.y - 30)];
    CCAction *actionMove11 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombieHumanTwo.position.x, zombieHumanTwo.position.y + 50)];
    CCAction *actionMove12 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(zombieHumanTwo.position.x, zombieHumanTwo.position.y - 70)];
    
    
    CCTiledMapObjectGroup *objects3  =    [levelOneMap objectGroupNamed:@"zombieChar2"];
    NSMutableDictionary *startPoint3 =    [objects3 objectNamed:@"startPoint"];
    int x3 = [[startPoint3 valueForKey:@"x"] intValue];
    int y3 = [[startPoint3 valueForKey:@"y"] intValue];
    CCAction *resetMoves3 = [CCActionMoveTo actionWithDuration:randomDuration position:ccp(x3,y3)];
    
    CCActionCallFunc *actionAnimateSouth = [CCActionCallFunc actionWithTarget:self selector:@selector(actionAnimateSouth)];
    CCActionCallFunc *actionAnimateNorth = [CCActionCallFunc actionWithTarget:self selector:@selector(actionAnimateNorth)];
    CCActionCallFunc *actionAnimateStop = [CCActionCallFunc actionWithTarget:self selector:@selector(actionAnimateStopZ1)];
    CCActionCallFunc *actionAnimateEast = [CCActionCallFunc actionWithTarget:self selector:@selector(actionAnimateEast)];
    CCActionCallFunc *actionAnimateWest = [CCActionCallFunc actionWithTarget:self selector:@selector(actionAnimateWest)];
    CCActionCallFunc *actionAnimateStop2 = [CCActionCallFunc actionWithTarget:self selector:@selector(actionAnimateStopZ2)];
    CCActionCallFunc *actionAnimateStop3 = [CCActionCallFunc actionWithTarget:self selector:@selector(actionAnimateStopZ3)];
    CCActionCallFunc *actionAnimateEast2 = [CCActionCallFunc actionWithTarget:self selector:@selector(actionAnimateEast2)];
    CCActionCallFunc *actionAnimateWest2 = [CCActionCallFunc actionWithTarget:self selector:@selector(actionAnimateWest2)];
    
    [self.zombiePirate runAction:[CCActionSequence actionWithArray:@[actionAnimateWest2, actionMove, actionAnimateStop3, actionAnimateEast2, actionMove2, actionAnimateStop3,actionAnimateWest2, actionMove3, actionAnimateStop3, actionAnimateEast2, actionMove4, actionAnimateStop3, actionAnimateWest2, resetMoves]]];
    [self.zombieHumanOne runAction:[CCActionSequence actionWithArray:@[actionAnimateWest, actionMove5, actionAnimateStop, actionAnimateEast, actionMove6, actionAnimateStop, actionAnimateWest,  actionMove7, actionAnimateStop, actionAnimateEast, actionMove8,actionAnimateStop, actionAnimateWest,  resetMoves2]]];
    [self.zombieHumanTwo runAction:[CCActionSequence actionWithArray:@[actionAnimateNorth, actionMove9, actionAnimateStop2, actionAnimateSouth, actionMove10, actionAnimateStop2, actionAnimateNorth, actionMove11, actionAnimateStop, actionAnimateSouth, actionMove12, actionAnimateStop2, actionAnimateNorth, resetMoves3]]];

}

-(void)actionAnimateEast
{
    self.zombieHumanOne.flipX = YES;
    [zombieHumanOne runAnimation:@"zombieHuman"];
}
-(void)actionAnimateWest
{
    self.zombieHumanOne.flipX = NO;
    [zombieHumanOne runAnimation:@"zombieHuman"];
}
-(void)actionAnimateSouth
{
    [zombieHumanTwo runAnimation:@"zombieHuman2"];

}
-(void)actionAnimateNorth
{
    [zombieHumanTwo runAnimation:@"zombieHuman2-N"];

}
-(void)actionAnimateStopZ1
{
    [zombieHumanOne stopAnimation];
    
}
-(void)actionAnimateStopZ2
{
    [zombieHumanTwo stopAnimation];
    
}
-(void)actionAnimateStopZ3
{
    [zombiePirate stopAnimation];
    
}
-(void)actionAnimateEast2
{
    self.zombiePirate.flipX = YES;
    [zombiePirate runAnimation:@"zombiePirate"];
}
-(void)actionAnimateWest2
{
    self.zombiePirate.flipX = NO;
    [zombiePirate runAnimation:@"zombiePirate"];
}

@end

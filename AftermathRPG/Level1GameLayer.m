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

@implementation Level1GameLayer
{
    BOOL holdingDagger;
}
@synthesize levelOneMap, metaTileLayer, mainChar, zombiePirate, zombieBoss, zombieHumanTwo, zombieHumanOne, dagger,physicsWorldNode;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        // Enable touch handling on scene node
        self.userInteractionEnabled = YES;
        
        // Setting the levelOneMap to the one created in Tiled
        self.levelOneMap = [CCTiledMap tiledMapWithFile:@"Level1.tmx"];
        
        // Setting the Meta Layer to the layer created to prevent players from colliding, and allow them to pick up items throughout the level
        self.metaTileLayer = [levelOneMap layerNamed:@"Meta"];
        
        // Making Meta Layer invisible, as they're acting rather then providing visual appearance
        metaTileLayer.visible = NO;
        
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
        
        holdingDagger = NO;

    }
    return self;
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
        }
        else
        {
            // Move player to the left a tile
            
            playerPos.x -= levelOneMap.tileSize.width;
        }
    }
    // Further up or down..
    else
    {
        if (diff.y > 0)
        {
            // Move player up a tile
            playerPos.y += levelOneMap.tileSize.height;
            
        }
        else
        {
            // Move player down a tiles
            playerPos.y -= levelOneMap.tileSize.height;
            
        }
    }
    // If player's position is less then or equal to the level's map size, and it's greater than 0,0
    // than...set the player's position
    if (playerPos.x <= (levelOneMap.mapSize.width * levelOneMap.tileSize.width) &&
        playerPos.y <= (levelOneMap.mapSize.height * levelOneMap.tileSize.height) &&
        playerPos.y >= 0 &&
        playerPos.x >= 0)
    {
        [self setPlayerPosition:playerPos];
    }
    // Setting the center of screen on the character
    [self setCenterOfScreen:mainChar.position];
}
- (void) setPlayerPosition:(CGPoint)position
{
    NSLog(@"Setting Player Position!");

    [hud updateZombiesKilled:@"Zombies Killed: 1"];
    // Obtaining user's requested position and storing it into CGPoint
    CGPoint mapTileCoords = [self returnCoordsFromPosition:position];
    // Obtaining tileGID properties for requested tile position
    int tileGidCheck = [metaTileLayer tileGIDAt:mapTileCoords];
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
                NSLog(@"Meta Tile (Collectable) detected!");

                CCAction *blockAction = [CCActionCallBlock actionWithBlock:^{
                    [dagger removeFromParentAndCleanup:YES];
                    holdingDagger = YES;
                }];
                [dagger runAction:blockAction];
            }
            else
            {
                
            }
        }
    }
    // Setting characters position, granted no collison detected
    mainChar.position = position;
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
    self.mainChar     = [CCSprite spriteWithImageNamed:@"mainChar.png"];
    mainChar.position = ccp(x0,y0);
    mainChar.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, mainChar.contentSize} cornerRadius:0];
    mainChar.physicsBody.collisionGroup = @"groupPlayer";
    mainChar.physicsBody.collisionType = @"collisionPlayer";
    [self.physicsWorldNode addChild: mainChar];
    
    
    CCTiledMapObjectGroup *objects1  =    [levelOneMap objectGroupNamed:@"zombiePirate"];
    NSMutableDictionary *startPoint1 =    [objects1 objectNamed:@"startPoint"];
    int x1 = [[startPoint1 valueForKey:@"x"] intValue];
    int y1 = [[startPoint1 valueForKey:@"y"] intValue];
    self.zombiePirate     = [CCSprite spriteWithImageNamed:@"zombiePirate.png"];
    zombiePirate.position = ccp(x1,y1);
    zombiePirate.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, zombiePirate.contentSize} cornerRadius:0];
    zombiePirate.physicsBody.collisionGroup = @"groupMonster";
    zombiePirate.physicsBody.collisionType = @"collisionMonster";
    [self.physicsWorldNode addChild: zombiePirate];

    CCTiledMapObjectGroup *objects2  =    [levelOneMap objectGroupNamed:@"zombieChar1"];
    NSMutableDictionary *startPoint2 =    [objects2 objectNamed:@"startPoint"];
    int x2 = [[startPoint2 valueForKey:@"x"] intValue];
    int y2 = [[startPoint2 valueForKey:@"y"] intValue];
    self.zombieHumanOne     = [CCSprite spriteWithImageNamed:@"zombieHumanTwo.png"];
    zombieHumanOne.position = ccp(x2,y2);
    zombieHumanOne.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, zombieHumanOne.contentSize} cornerRadius:0];
    zombieHumanOne.physicsBody.collisionGroup = @"groupMonster";
    zombieHumanOne.physicsBody.collisionType = @"collisionMonster";
    [self.physicsWorldNode addChild: zombieHumanOne];
    
    CCTiledMapObjectGroup *objects3  =    [levelOneMap objectGroupNamed:@"zombieChar2"];
    NSMutableDictionary *startPoint3 =    [objects3 objectNamed:@"startPoint"];
    int x3 = [[startPoint3 valueForKey:@"x"] intValue];
    int y3 = [[startPoint3 valueForKey:@"y"] intValue];
    self.zombieHumanTwo     = [CCSprite spriteWithImageNamed:@"zombieHuman.png"];
    zombieHumanTwo.position = ccp(x3,y3);
    zombieHumanTwo.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, zombieHumanTwo.contentSize} cornerRadius:0];
    zombieHumanTwo.physicsBody.collisionGroup = @"groupMonster";
    zombieHumanTwo.physicsBody.collisionType = @"collisionMonster";
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
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair collisionPlayer:(CCNode *)user collisionMonster:(CCNode *)monster
{
    if (holdingDagger)
    {
        [monster stopAllActions];
        
        
        // Playing the zombie sound effect with maximized volume, and of course no loop, once the zombie npc is hit
        
        [[OALSimpleAudio sharedInstance] playEffect:@"Zombie.mp3" volume:10.0f pitch:1.0f pan:0 loop:NO];
        
        CCActionRotateTo* actionSpin = [CCActionRotateBy actionWithDuration:0 angle:90];
        [monster runAction:actionSpin];
        
        CCActionDelay *corpseDecayDelay = [CCActionDelay actionWithDuration:0.8];
        CCActionFadeOut *corpseFade = [CCActionFadeOut actionWithDuration:0.5];
        
        CCActionRemove *removeElement = [CCActionRemove action];
        CCActionSequence* monsterDeathSequence = [CCActionSequence actions:corpseDecayDelay,corpseFade, removeElement, nil];
        [monster runAction:monsterDeathSequence];
    }
    else
    {
        [[OALSimpleAudio sharedInstance] playEffect:@"DeathByZombie.mp3" volume:0.7f pitch:1.0f pan:10.0f loop:0];
        
        CCActionRemove *removeElement = [CCActionRemove action];
        [user runAction:removeElement];
        
        [[CCDirector sharedDirector] replaceScene:[GameOverScene scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];

    }
        return YES;
}

@end

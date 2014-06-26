//
//  CreditsScene.m
//  AftermathRPG
//
//  Created by Jason Woolard on 6/26/14.
//  Copyright 2014 Jason Woolard. All rights reserved.
//

#import "CreditsScene.h"


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
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        
        
        
    }
    else
    {
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        
        
    }
    
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackButtonClicked:(id)sender
{
    
}

@end

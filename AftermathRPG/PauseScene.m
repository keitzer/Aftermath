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

@implementation PauseScene
-(id)init
{
    self = [super init];
    
    if (self)
    {
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
      
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            CCButton *resumeButton = [CCButton buttonWithTitle:@"[ Resume ]" fontName:@"Verdana-Bold" fontSize:30.0f];
            resumeButton.position = ccp(0.50f * viewSize.width, 0.50f * viewSize.height);
            [resumeButton setTarget:self selector:@selector(onResumeClicked:)];
            [self addChild:resumeButton];

        }
        else
        {
            CCButton *resumeButton = [CCButton buttonWithTitle:@"[ Resume ]" fontName:@"Verdana-Bold" fontSize:18.0f];
            resumeButton.position = ccp(0.50f * viewSize.width, 0.50f * viewSize.height);
            [resumeButton setTarget:self selector:@selector(onResumeClicked:)];
            [self addChild:resumeButton];

        }
        
        
    }
    return self;
}

- (void)onResumeClicked:(id)sender
{
    [[CCDirector sharedDirector] popScene];

}
@end

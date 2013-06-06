//
//  Mallet.m
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/5/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import "Mallet.h"

@implementation Mallet

@synthesize malletAnim;

-(void)changeState:(CharacterStates)newState
{
    if (newState == kStateSpawning)
    {
        id action = [CCRepeatForever actionWithAction:
                     [CCAnimate actionWithAnimation:malletAnim]];
        
        [self runAction:action];
    }
    else
    {
        [self setVisible:NO]; // Picked up
        [self removeFromParentAndCleanup:YES];
    }
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime
           andListOfGameObjects:(CCArray*)listOfGameObjects
{
    float groundHeight = screenSize.height * 0.065f;
    
    if ([self position].y > groundHeight)
    {
        [self setPosition:ccp([self position].x,
                              [self position].y - 5.0f)];
    }
}

-(void)initAnimations
{
    [self setMalletAnim:
     [self loadPlistForAnimationWithName:@"malletAnim"
                            andClassName:NSStringFromClass([self class])]];
}

-(id) initWithSpriteFrameName:(NSString *)spriteFrameName
{
    if(self=[super initWithSpriteFrameName:spriteFrameName])
    {
        screenSize = [CCDirector sharedDirector].winSize;
        gameObjectType = kPowerUpTypeMallet;
        [self initAnimations];
        [self changeState:kStateSpawning];
    }
    return self;
}

@end

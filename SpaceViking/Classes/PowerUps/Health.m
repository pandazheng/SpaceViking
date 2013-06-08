//
//  Health.m
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/5/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import "Health.h"

@implementation Health

@synthesize healthAnim;

-(void)changeState:(CharacterStates)newState
{
    if (newState == kStateSpawning)
    {
        id action = [CCRepeatForever actionWithAction:
                     [CCAnimate actionWithAnimation:healthAnim]];
        [self runAction:action];
    }
    else
    {
        [self setVisible:NO];// Picked up
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
    [self setHealthAnim:
     [self loadPlistForAnimationWithName:@"healthAnim"
                            andClassName:NSStringFromClass([self class])]];
}

-(id) initWithSpriteFrameName:(NSString *)spriteFrameName
{
    if(self=[super initWithSpriteFrameName:spriteFrameName])
    {
        screenSize = [CCDirector sharedDirector].winSize;
        [self initAnimations];
        [self changeState:kStateSpawning];
        gameObjectType = kPowerUpTypeHealth;
        
    }
    return self;
}

@end

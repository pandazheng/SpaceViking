//
//  RadarDish.m
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/4/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import "RadarDish.h"

@implementation RadarDish
@synthesize tiltingAnim;
@synthesize transmittingAnim;
@synthesize takingAHitAnim;
@synthesize blowingUpAnim;

-(void)changeState:(CharacterStates)newState
{
    [self stopAllActions];
    id action = nil;
    [self setCharacterState:newState];
    
    switch (newState)
    {
        //Spawning - Starts up the RadarDish with the tilting animation, which is the dish moving up and down.
        case kStateSpawning:
            CCLOG(@"RadarDish->Starting the Spawning Animation");
            action = [CCAnimate actionWithAnimation:tiltingAnim];
            break;
           
        //Idle - Runs the transmitting animation, which is the RadarDish blinking.
        case kStateIdle:
            CCLOG(@"RadarDish->Changing State to Idle");
            action = [CCAnimate actionWithAnimation:transmittingAnim];
            break;
            
        //Taking Damage - Runs the taking damage animation, showing a hit to the RadarDish. The RadarDish health is reduced according to the type of weapon being used against it.
        case kStateTakingDamage:
            CCLOG(@"RadarDish->Changing State to TakingDamage");
            characterHealth =
            characterHealth - [vikingCharacter getWeaponDamage];
            if (characterHealth <= 0.0f)
            {
                [self changeState:kStateDead];
            }
            else
            {
                action = [CCAnimate actionWithAnimation:takingAHitAnim];
            }
            break;
            
        //Dead - The RadarDish plays a death animation of it blowing up. This state occurs once the RadarDish health is at or below zero.
        case kStateDead:
            CCLOG(@"RadarDish->Changing State to Dead");
            action = [CCAnimate actionWithAnimation:blowingUpAnim];
            break;
            
        default:
            CCLOG(@"Unhandled state %d in RadarDish", newState);
            break;
    }
    if (action != nil)
    {
        [self runAction:action];
    }
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime
           andListOfGameObjects:(CCArray*)listOfGameObjects
{
    //Checks if the RadarDish is already dead. If it is, this method is short-circuited and returned. If the RadarDish is dead, there is nothing to update.
    if (characterState == kStateDead)
        return;                                                  
    
    //Gets the Viking character object from the RadarDish parent. All of Space Viking’s objects are children of the scene SpriteBatchNode, referred to here as the parent.
    //By obtaining a reference to the Viking object, the RadarDish can determine if the Viking is nearby and attacking the RadarDish.
    vikingCharacter =
    (GameCharacter*)[[self parent]
                     getChildByTag:kVikingSpriteTagValue];                        
    
    //Gets the Viking character’s adjusted bounding box.
    CGRect vikingBoundingBox =
    [vikingCharacter adjustedBoundingBox];
    
    //Gets the Viking character’s state
    CharacterStates vikingState = [vikingCharacter
                                   characterState];               
    
    // Calculate if the Viking is attacking and nearby
    if ((vikingState == kStateAttacking) &&
        (CGRectIntersectsRect([self adjustedBoundingBox],
                              vikingBoundingBox)))
    {
        //Determines if the Viking is nearby and attacking. If the adjusted bounding boxes for the Viking and the RadarDish overlap, and the Viking is in his attack phase, the RadarDish can be certain that the Viking is attacking it. The call to changeState:kStateTakingDamage will alter the RadarDish animation to reflect the attack and reduce the RadarDish character’s health
        if (characterState != kStateTakingDamage)
        {
            // If RadarDish is NOT already taking Damage
            [self changeState:kStateTakingDamage];
            return;
        }
    }
    
    if (([self numberOfRunningActions] == 0) &&
        (characterState != kStateDead))
    {
        CCLOG(@"Going to Idle");
        
        //Resets the transmission animation on the RadarDish. If the RadarDish is not currently playing an animation, and it is not dead, it is reset to idle so that the transmission animation can restart.
        [self changeState:kStateIdle];                           
        return;
    }
}

-(void)initAnimations
{
    [self setTiltingAnim:
     [self loadPlistForAnimationWithName:@"tiltingAnim"
                            andClassName:NSStringFromClass([self class])]];
    
    [self setTransmittingAnim:
     [self loadPlistForAnimationWithName:@"transmittingAnim"
                            andClassName:NSStringFromClass([self class])]];
    
    [self setTakingAHitAnim:
     [self loadPlistForAnimationWithName:@"takingAHitAnim"
                            andClassName:NSStringFromClass([self class])]];
    
    [self setBlowingUpAnim:
     [self loadPlistForAnimationWithName:@"blowingUpAnim"
                            andClassName:NSStringFromClass([self class])]];
}

-(id) initWithSpriteFrameName:(NSString *)spriteFrameName
{
    if(self=[super initWithSpriteFrameName:spriteFrameName])
    {
        CCLOG(@"### RadarDish initialized");
        
        //Calls the initAnimations method, which sets up all of the animations for the RadarDish. The frame’s coordinates and textures were already loaded and cached by Cocos2D when the texture atlas files (scene1atlas.png and scene1atlas.plist) were loaded by the GameplayLayer class.
        [self initAnimations];
        
        //Sets the initial health of the RadarDish to a value of 100.
        characterHealth = 100.0f;
        
        //Sets the RadarDish to be a Game Object of type kEnemyTypeRadarDish.
        gameObjectType = kEnemyTypeRadarDish;
        
        //Initializes the state of the RadarDish to spawning.
        [self changeState:kStateSpawning];                   
    }
    return self;
}

@end
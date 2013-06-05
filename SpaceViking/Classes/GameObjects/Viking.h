//
//  Viking.h
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/4/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCharacter.h"
#import "SneakyButton.h"
#import "SneakyJoystick.h"

typedef enum
{
    kLeftHook,
    kRightHook
} LastPunchType;

@interface Viking : GameCharacter
{
    LastPunchType myLastPunch;
    BOOL isCarryingMallet;
    CCSpriteFrame *standingFrame;
    
    // Standing, breathing, and walking
    CCAnimation *breathingAnim;
    CCAnimation *breathingMalletAnim;
    CCAnimation *walkingAnim;
    CCAnimation *walkingMalletAnim;
    
    // Crouching, standing up, and Jumping
    CCAnimation *crouchingAnim;
    CCAnimation *crouchingMalletAnim;
    CCAnimation *standingUpAnim;
    CCAnimation *standingUpMalletAnim;
    CCAnimation *jumpingAnim;
    CCAnimation *jumpingMalletAnim;
    CCAnimation *afterJumpingAnim;
    CCAnimation *afterJumpingMalletAnim;
    
    // Punching
    CCAnimation *rightPunchAnim;
    CCAnimation *leftPunchAnim;
    CCAnimation *malletPunchAnim;
    
    // Taking Damage and Death
    CCAnimation *phaserShockAnim;
    CCAnimation *deathAnim;
    
    __unsafe_unretained SneakyJoystick *joystick;
    __unsafe_unretained SneakyButton *jumpButton ;
    __unsafe_unretained SneakyButton *attackButton;
    
    float millisecondsStayingIdle;
}

// Standing, Breathing, Walking
@property (nonatomic, strong) CCAnimation *breathingAnim;
@property (nonatomic, strong) CCAnimation *breathingMalletAnim;
@property (nonatomic, strong) CCAnimation *walkingAnim;
@property (nonatomic, strong) CCAnimation *walkingMalletAnim;

// Crouching, Standing Up, Jumping
@property (nonatomic, strong) CCAnimation *crouchingAnim;
@property (nonatomic, strong) CCAnimation *crouchingMalletAnim;
@property (nonatomic, strong) CCAnimation *standingUpAnim;
@property (nonatomic, strong) CCAnimation *standingUpMalletAnim;
@property (nonatomic, strong) CCAnimation *jumpingAnim;
@property (nonatomic, strong) CCAnimation *jumpingMalletAnim;
@property (nonatomic, strong) CCAnimation *afterJumpingAnim;
@property (nonatomic, strong) CCAnimation *afterJumpingMalletAnim;

// Punching
@property (nonatomic, strong) CCAnimation *rightPunchAnim;
@property (nonatomic, strong) CCAnimation *leftPunchAnim;
@property (nonatomic, strong) CCAnimation *malletPunchAnim;

// Taking Damage and Death
@property (nonatomic, strong) CCAnimation *phaserShockAnim;
@property (nonatomic, strong) CCAnimation *deathAnim;

@property (nonatomic, assign) SneakyJoystick *joystick;
@property (nonatomic, assign) SneakyButton *jumpButton;
@property (nonatomic, assign) SneakyButton *attackButton;

@end
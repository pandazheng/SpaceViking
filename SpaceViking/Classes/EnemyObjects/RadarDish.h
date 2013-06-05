//
//  RadarDish.h
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/4/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCharacter.h"

@interface RadarDish : GameCharacter
{
    CCAnimation *tiltingAnim;
    CCAnimation *transmittingAnim;
    CCAnimation *takingAHitAnim;
    CCAnimation *blowingUpAnim;
    GameCharacter *vikingCharacter;
}

@property (nonatomic, strong) CCAnimation *tiltingAnim;
@property (nonatomic, strong) CCAnimation *transmittingAnim;
@property (nonatomic, strong) CCAnimation *takingAHitAnim;
@property (nonatomic, strong) CCAnimation *blowingUpAnim;

@end
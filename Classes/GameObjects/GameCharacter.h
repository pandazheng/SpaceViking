//
//  GameCharacter.h
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/4/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface GameCharacter : GameObject
{
    int characterHealth;
    CharacterStates characterState;
}

-(void)checkAndClampSpritePosition;
-(int)getWeaponDamage;

@property (readwrite) int characterHealth;
@property (readwrite) CharacterStates characterState;

@end
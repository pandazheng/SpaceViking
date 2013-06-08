//
//  PhaserBullet.h
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/5/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCharacter.h"

@interface PhaserBullet : GameCharacter
{
    CCAnimation *firingAnim;
    CCAnimation *travelingAnim;
    
    PhaserDirection myDirection;    
}

@property PhaserDirection myDirection;
@property (nonatomic,retain) CCAnimation *firingAnim;
@property (nonatomic,retain) CCAnimation *travelingAnim;

@end
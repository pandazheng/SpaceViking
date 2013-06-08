//
//  SpaceCargoShip.h
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/5/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface SpaceCargoShip : GameObject
{
    BOOL hasDroppedMallet;
    __unsafe_unretained id <GameplayLayerDelegate> delegate;
}

@property (nonatomic,assign) id <GameplayLayerDelegate> delegate;

@end
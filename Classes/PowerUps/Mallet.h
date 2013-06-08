//
//  Mallet.h
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/5/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface Mallet : GameObject
{
    CCAnimation *malletAnim;
}

@property (nonatomic, strong) CCAnimation *malletAnim;

@end
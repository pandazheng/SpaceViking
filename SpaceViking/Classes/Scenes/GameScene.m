//
//  GameplayScene.m
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/2/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(id)init
{
    self = [super init];
    
    if (self != nil)
    {
        // Background Layer - Instantiates the backgroundLayer object. The node method call is just a shortcut for the alloc and init methods combined.
        BackgroundLayer *backgroundLayer = [BackgroundLayer node];
        
        //Adds the backgroundLayer to the scene with a z value of zero.
        [self addChild:backgroundLayer z:0];                       
        
        // Gameplay Layer - Instantiates the gameplayLayer object.
        GameplayLayer *gameplayLayer = [GameplayLayer node];      
        
        //Adds the gameplayLayer object to the scene with a z value of 5. Since the z value of the gameplayLayer is higher than the z value of backgroundLayer, it will be composited in front of the backgroundLayer.
        [self addChild:gameplayLayer z:5];                        
    }
    return self;
}

@end

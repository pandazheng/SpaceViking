//
//  GameCharacter.m
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/4/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import "GameCharacter.h"

@implementation GameCharacter
@synthesize characterHealth;
@synthesize characterState;

-(int)getWeaponDamage
{
    // Default to zero damage
    CCLOG(@"getWeaponDamage should be overridden");
    return 0;
}

-(void)checkAndClampSpritePosition
{
    CGPoint currentSpritePosition = [self position];
    
    //Remember that Cocos2D uses a point system to help position objects on the normal iPhone display (480 × 320 pixels) and the retina display (960 × 640 pixels). In the nonretina display a point equals a pixel, but in the retina display a point equals two pixels.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // Clamp for the iPad
        if (currentSpritePosition.x < 30.0f)
        {
            [self setPosition:ccp(30.0f, currentSpritePosition.y)];
        }
        else if (currentSpritePosition.x > 1000.0f)
        {
            [self setPosition:ccp(1000.0f, currentSpritePosition.y)];
        }
    }
    else
    {
        // Clamp for iPhone, iPhone 4, or iPod touch
        if (currentSpritePosition.x < 24.0f)
        {
            [self setPosition:ccp(24.0f, currentSpritePosition.y)];
        }
        else if (currentSpritePosition.x > 456.0f)
        {
            [self setPosition:ccp(456.0f, currentSpritePosition.y)];
        }
    }
}

@end
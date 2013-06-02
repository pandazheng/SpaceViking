//
//  GameplayLayer.m
//  SpaceViking
//
//  Created by MrHappyAsthma on 6/2/13.
//  Copyright (c) 2013 MrHappyAsthma. All rights reserved.
//

#import "GameplayLayer.h"

@implementation GameplayLayer

-(void)initJoystickAndButtons
{
    //Gets the screenSize from the Cocos2D Director. The screenSize is used to calculate the positioning of the joystick and buttons.
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    //Sets up the touch dimensions for the joystick and buttons. The joystick touch dimensions are a rectangle of size 128 × 128 pixels. The jump and attack buttons dimensions are a rectangle of size 64 × 64 pixels.
    CGRect joystickBaseDimensions =
    CGRectMake(0, 0, 128.0f, 128.0f);                      
    CGRect jumpButtonDimensions =
    CGRectMake(0, 0, 64.0f, 64.0f);
    CGRect attackButtonDimensions =
    CGRectMake(0, 0, 64.0f, 64.0f);
    
    //Creates the three CGPoint variables that are used to position the joystick and buttons.
    CGPoint joystickBasePosition;                                 
    CGPoint jumpButtonPosition;
    CGPoint attackButtonPosition;
    
    //This if/else block uses a calculation for the values so that if the iPad dimensions change, the joystick and buttons will still be in their proper place.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // The device is an iPad running iPhone 3.2 or later.
        CCLOG(@"Positioning Joystick and Buttons for iPad");
        joystickBasePosition = ccp(screenSize.width*0.0625f,
                                   screenSize.height*0.052f);
        
        jumpButtonPosition = ccp(screenSize.width*0.946f,
                                 screenSize.height*0.052f);
        
        attackButtonPosition = ccp(screenSize.width*0.947f,
                                   screenSize.height*0.169f);
    }
    else
    {
        // The device is an iPhone or iPod touch.
        CCLOG(@"Positioning Joystick and Buttons for iPhone");
        joystickBasePosition = ccp(screenSize.width*0.07f,
                                   screenSize.height*0.11f);
        
        jumpButtonPosition = ccp(screenSize.width*0.93f,
                                 screenSize.height*0.11f);
        
        attackButtonPosition = ccp(screenSize.width*0.93f,
                                   screenSize.height*0.35f);
    }
    
    //Allocates and initializes a joystick base. The joystick base will contain the actual joystick and the sprites used to show the static joystick directional pad (DPAD) and the moveable thumb portion of the joystick.
    SneakyJoystickSkinnedBase *joystickBase =
    [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    
    //Sets the position of the joystick base to the value corresponding to either iPad or iPhone dimensions.
    joystickBase.position = joystickBasePosition;
    
    //Sets the background image of the joystick to the dpadDown.png image. In Space Viking this is a Viking rune–styled directional pad.
    joystickBase.backgroundSprite =
    [CCSprite spriteWithFile:@"dpadDown.png"];
    
    //Sets the thumb portion of the joystick to the joystickDown.png image. This is the image players will move around with their thumbs or fingers.
    joystickBase.thumbSprite =
    [CCSprite spriteWithFile:@"joystickDown.png"];
    
    //Sets the joystick touch area to be a rectangle of 128 × 128 pixels, based on the value of joystickBaseDimensions variable.
    joystickBase.joystick = [[SneakyJoystick alloc]
                             initWithRect:joystickBaseDimensions];
    
    //Assigns the joystick component of the joystick base to the GameplayLayer leftJoystick instance variable.
    leftJoystick = [joystickBase.joystick retain];
    
    //Adds the joystick base to the GameplayLayer instance, making it visible on the lower-left portion of the screen.
    [self addChild:joystickBase];                                 
    
    //Allocates and initializes the jump button base.
    SneakyButtonSkinnedBase *jumpButtonBase =
    [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    
    //Sets the base position onscreen.
    jumpButtonBase.position = jumpButtonPosition;
    
    //Sets the up position of the jump button base to the jumpUp.png image. This is the state of the button if it is not being pressed.
    jumpButtonBase.defaultSprite =
    [CCSprite spriteWithFile:@"jumpUp.png"];
    
    //Sets the activated position of the jump button base to the jumpDown.png image. This is the state of the button if it is toggled to on or down.
    jumpButtonBase.activatedSprite =
    [CCSprite spriteWithFile:@"jumpDown.png"];                    
    
    //Sets the down position of the jump button base. This is the state of the button when the player presses it. Cocos2D textures are cached, so having the same image for the down and activated states of this button loads the jumpDown.png image only once in memory.
    jumpButtonBase.pressSprite =
    [CCSprite spriteWithFile:@"jumpDown.png"];                    
    
    //Sets the touch area of the button to a rectangle of 64 × 64 pixels.
    jumpButtonBase.button = [[SneakyButton alloc]
                             initWithRect:jumpButtonDimensions];
    
    //Assigns the button component of the jump button base to the GameplayLayer jumpButton instance variable.
    jumpButton = [jumpButtonBase.button retain];                
    
    //Sets this button to not act as a toggle. If a button has isToggleable set to YES, pressing it alternates the button state from ON to OFF. If the button has isToggleable set to NO, it turns OFF as soon as the player lifts his or her finger from it.
    jumpButton.isToggleable = NO;                                 
    
    //Adds the jump button base to the GameplayLayer instance, making it visible on the lower-right portion of the screen.
    [self addChild:jumpButtonBase];                               
    
    //Similar process as above, but for the attack and jump buttons
    SneakyButtonSkinnedBase *attackButtonBase =
    
    [[[SneakyButtonSkinnedBase alloc] init] autorelease];             
    attackButtonBase.position = attackButtonPosition;
    
    attackButtonBase.defaultSprite = [CCSprite
                                      spriteWithFile:@"handUp.png"];
    
    attackButtonBase.activatedSprite = [CCSprite
                                        spriteWithFile:@"handDown.png"];
    
    attackButtonBase.pressSprite = [CCSprite
                                    spriteWithFile:@"handDown.png"];
    
    attackButtonBase.button = [[SneakyButton alloc]
                               initWithRect:attackButtonDimensions];
    
    attackButton = [attackButtonBase.button retain];
    
    attackButton.isToggleable = NO;
    
    [self addChild:attackButtonBase];                             
}

-(void)applyJoystick:(SneakyJoystick *)aJoystick toNode:(CCNode
                                                         *)tempNode forTimeDelta:(float)deltaTime
{
    //Gets the screen size from the Cocos2D Director. On the iPad, this returns 1024 × 768 pixels.
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    //Gets the velocity from the joystick object and multiplies it by 1024, which is used here because it is the size of the iPad screen. The velocity can be multiplied by different factors to make Ole the Viking move faster or slower in relation to the movement of the joystick.
    CGPoint scaledVelocity = ccpMult(aJoystick.velocity, screenSize.width); 
    
    //Creates a new position based on the current tempNode position, the joystick velocity, and how much time has elapsed between the last time this method was called and now.
    CGPoint newPosition =
    ccp(tempNode.position.x + scaledVelocity.x * deltaTime,
        tempNode.position.y + scaledVelocity.y * deltaTime);       
    
    //Sets the tempNode position to the newly calculated position. Here tempNode is really a reference to vikingSprite, so this call is placing Ole the Viking at a new position.
    [tempNode setPosition:newPosition];                            
    
    //Checks if the jump button is pressed, and if so, prints a message to the Console.
    if (jumpButton.active == YES)
    {
        CCLOG(@"Jump button is pressed.");
    }
    
    //Checks if the attack button is pressed, and if so, prints a message to the Console.
    if (attackButton.active == YES)
    {
        CCLOG(@"Attack button is pressed.");                       
    }
}

#pragma mark -
#pragma mark Update Method
-(void) update:(ccTime)deltaTime
{
    [self applyJoystick:leftJoystick toNode:vikingSprite
           forTimeDelta:deltaTime];
}

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        //Gets the screen size from the Cocos2D Director. On the iPad, this returns 1024 × 768 pixels.
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        //Informs Cocos2D that the gameplayLayer will receive touch events.
        self.touchEnabled = YES;
        
        //Allocates and initializes the vikingSprite instance variable with the image sv_anim_1.png
        vikingSprite = [CCSprite spriteWithFile:@"viking1.png"];
        
        //Sets the position of the vikingSprite onscreen. The screenSize.width/2 parameter takes the current screen width (1024 pixels on the iPad) and divides it by two. This places the Viking 512 pixels to the right of the screen, dead center on the X-axis. The Y-axis is being set to 17% of the screen height from the bottom. (Takes a float value: Ex. 1.0f)
        [vikingSprite setPosition:
         CGPointMake(screenSize.width/2,
                     screenSize.height*0.17f)];               
        
        //Adds the vikingSprite to the GameplayLayer. Having the vikingSprite as a child of the layer enables it to be rendered on the screen by Cocos2D
        [self addChild:vikingSprite];
        
        //Calls the initJoystickAndButtons method
        [self initJoystickAndButtons];
        
        //A call to the Cocos2D scheduler to call the update method every time this layer is set to be rendered on the screen.
        [self scheduleUpdate];
       
        //Scales down the vikingSprite if Space Viking is not running on the iPad, resizing it to fit the screen resolution. In your games and in later chapters, you will want to use this check to load the appropriate iPhone/iPod touch artwork. In order to keep things simple, this example just scales down the Viking image.
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
        {
            // If NOT on the iPad, scale down Ole
            // In your games, use this to load art sized for the device
            [vikingSprite setScaleX:screenSize.width/1024.0f];
            [vikingSprite setScaleY:screenSize.height/768.0f];
        }
    }
    return self;
}

@end
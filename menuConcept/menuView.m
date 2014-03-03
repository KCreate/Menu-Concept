//
//  menuView.m
//  menuConcept
//
//  Created by Leonard Schuetz on 03.03.14.
//  Copyright (c) 2014 Leonard Schuetz. All rights reserved.
//

#import "menuView.h"
#import "ViewController.h"

@implementation menuView
@synthesize isOpen, currentIndex, consoleOutput, delegate
;

- (id)initWithDefaultsWithDevice:(NSString *)userDevice {
    
    if ([userDevice isEqualToString:@"iPhone5"]) {
        self = [super initWithFrame:CGRectMake(35, 410,250,150)];
        if (self) {
            //[self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.1]];
        }
    } else if ([userDevice isEqualToString:@"iPhone4"]) {
        self = [super initWithFrame:CGRectMake(35, 320,250,150)];
        if (self) {
            //[self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.1]];
        }
    }
    
    [self moreInit];
    [self buttonLocationInit];
    [self buttonMethodInit];
    [self buttonCheckingInit];
    
    return self;
}

#pragma mark initStage1

-(void)moreInit {
    //Creating a couple button to use. Defined in the menuViewButton class
    button1 = [[UIButton alloc] initWithFrame:button1_rect];
    button2 = [[UIButton alloc] initWithFrame:button2_rect];
    button3 = [[UIButton alloc] initWithFrame:button3_rect];
    button4 = [[UIButton alloc] initWithFrame:button4_rect];
    
    //Adding the previusly initialized pointers to our view
    [self addSubview:menuViewNib];
    [self addSubview:button2];
    [self addSubview:button3];
    [self addSubview:button4];
    [self addSubview:button1];
    
    //Initializing the button_rects
    button1_rect = CGRectMake(100, 100, 50, 50);
    button2_rect = CGRectMake( 40,  30, 50, 50);
    button3_rect = CGRectMake(100,  10, 50, 50);
    button4_rect = CGRectMake(160,  30, 50, 50);
    
    //Position the buttons
    [button1 setFrame:button1_rect]; //Under
    [button2 setFrame:button2_rect]; //Upper left
    [button3 setFrame:button3_rect]; //Upper middle
    [button4 setFrame:button4_rect]; //Upper right
    
    //Put the colors on the buttons
    [button1 setBackgroundColor:[UIColor lightGrayColor]];
    [button2 setBackgroundColor:[UIColor colorWithRed:0.5 green:0 blue:0 alpha:1]];
    [button3 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0.5 alpha:1]];
    [button4 setBackgroundColor:[UIColor yellowColor]];
    
    //Set tags for the buttons to identificate them in further methods
    [button1 setTag:0];
    [button2 setTag:1];
    [button3 setTag:2];
    [button4 setTag:3];
    
    if (consoleOutput) {
        NSLog(@"Passed initStage1");
    }
}

#pragma mark initStage2

-(void)buttonLocationInit {
    //Position the buttons at the button1 location
    button1.frame = button1_rect;
    button2.frame = button2_rect;
    button3.frame = button3_rect;
    button4.frame = button4_rect;
    
    //Hide the buttons so the user can click the main button
    [button2 setHidden:YES];
    [button3 setHidden:YES];
    [button4 setHidden:YES];
    
    if (consoleOutput) {
        NSLog(@"Passed initStage2");
    }
}

#pragma mark initStage3

-(void)buttonMethodInit {
    [button1 addTarget:self
                action:@selector(openMenu)
      forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self
                action:@selector(closeMenu:)
      forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self
                action:@selector(closeMenu:)
      forControlEvents:UIControlEventTouchUpInside];
    [button4 addTarget:self
                action:@selector(closeMenu:)
      forControlEvents:UIControlEventTouchUpInside];
    
    if (consoleOutput) {
        NSLog(@"Passed initStage3");
    }
}

#pragma mark initStage4

-(void)buttonCheckingInit {
    _isOpen = NO;
    _currentIndex = 0;
    _buttonsAreHidden = NO;
    consoleOutput = NO;
    
    _openDuration = 0.5;
    _closeDuration = 0.3;
    
    [self openMenu]; [self openMenu];
    
    if (consoleOutput) {
        NSLog(@"Passed initStage4");
    }
}

#pragma mark menuView methods

-(void)openMenu {
    if (!_isOpen) {
        //Menu is closed
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_openDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationWillStartSelector:@selector(hideExtButtons)];
        
        //Frame Animation
        [button2 setFrame:button2_rect];
        [button3 setFrame:button3_rect];
        [button4 setFrame:button4_rect];
        
        //Alpha Animation
        [button2 setAlpha:1];
        [button3 setAlpha:1];
        [button4 setAlpha:1];
        
        [UIView commitAnimations];
        
        _isOpen = YES;
    } else {
        //Menu is open
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_closeDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(hideExtButtons)];
        
        //Frame Animation
        [button2 setFrame:button1_rect];
        [button3 setFrame:button1_rect];
        [button4 setFrame:button1_rect];
        
        //Alpha Animation
        [button2 setAlpha:0];
        [button3 setAlpha:0];
        [button4 setAlpha:0];
        
        [UIView commitAnimations];
        
        _isOpen = NO;
    }
    
    if (consoleOutput) {
        NSLog(@"isOpen: %i", _isOpen);
    }
}

-(void)closeMenu:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            //Comes from button2
            _currentIndex = sender.tag - 1;
            break;
        case 2:
            //Comes from button3
            _currentIndex = sender.tag - 1;
            break;
        case 3:
            //Comes from button4
            _currentIndex = sender.tag - 1;
            break;
        default:
            break;
    }
    
    [delegate menuViewNewIndex:_currentIndex]; //Delegate method to see when a new index got selected
    
    if (consoleOutput) {
        NSLog(@"currentIndex: %li", _currentIndex);
    }
    
    [self openMenu];
}

-(void)hideExtButtons {
    if (!_buttonsAreHidden) {
        [button2 setHidden:YES];
        [button3 setHidden:YES];
        [button4 setHidden:YES];
        _buttonsAreHidden = YES;
    } else if (_buttonsAreHidden) {
        [button2 setHidden:NO];
        [button3 setHidden:NO];
        [button4 setHidden:NO];
        _buttonsAreHidden = NO;
    }
    
    if (consoleOutput) {
        NSLog(@"isHidden: %i", _buttonsAreHidden);
    }
}

-(void)toggleMenu {
    [self openMenu];
}

-(void)setOpenDuration:(float)duration {
    _openDuration = duration;
}

-(void)setCloseDuration:(float)duration {
    _closeDuration = duration;
}

-(void)setImageForButton1:(UIImage *)image forState:(UIControlState)controlState {
    [button1 setImage:image forState:controlState];
    [button1 setBackgroundColor:[UIColor clearColor]];
}

-(void)setImageForButton2:(UIImage *)image forState:(UIControlState)controlState {
    [button2 setImage:image forState:controlState];
    [button1 setBackgroundColor:[UIColor clearColor]];
}

-(void)setImageForButton3:(UIImage *)image forState:(UIControlState)controlState {
    [button3 setImage:image forState:controlState];
    [button1 setBackgroundColor:[UIColor clearColor]];
}

-(void)setImageForButton4:(UIImage *)image forState:(UIControlState)controlState {
    [button4 setImage:image forState:controlState];
    [button1 setBackgroundColor:[UIColor clearColor]];
}

@end
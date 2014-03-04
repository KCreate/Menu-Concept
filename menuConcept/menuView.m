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
@synthesize isOpen, currentIndex, delegate
;

- (id)initWithCenter:(CGPoint)center {
    
    self = [super initWithFrame:CGRectMake(35,410,200,150)];
    [self setCenter:center];
    [self initialization];
    
    return self;
}

#pragma mark initStage1

-(void)initialization {
    //Creating a couple button to use. Defined in the menuViewButton class
    button1 = [[UIButton alloc] initWithFrame:button1_rect];
    button2 = [[UIButton alloc] initWithFrame:button2_rect];
    button3 = [[UIButton alloc] initWithFrame:button3_rect];
    button4 = [[UIButton alloc] initWithFrame:button4_rect];
    
    //Adding the previusly initialized pointers to our view
    [self addSubview:button2];
    [self addSubview:button3];
    [self addSubview:button4];
    [self addSubview:button1];
    
    //Initializing the button_rects
    button1_rect = CGRectMake(75,100,50,50);
    button2_rect = CGRectMake(0,30,50,50);
    button3_rect = CGRectMake(75,0,50,50);
    button4_rect = CGRectMake(150,30,50,50);
    
    //Position the buttons
    [button1 setFrame:button1_rect]; //Under
    [button2 setFrame:button1_rect]; //Upper left
    [button3 setFrame:button1_rect]; //Upper middle
    [button4 setFrame:button1_rect]; //Upper right
    
    //Put the colors on the buttons
    [button1 setBackgroundColor:[UIColor grayColor]];
    [button2 setBackgroundColor:[UIColor redColor]];
    [button3 setBackgroundColor:[UIColor redColor]];
    [button4 setBackgroundColor:[UIColor redColor]];
    
    //Set tags for the buttons to identificate them in further methods
    [button1 setTag:0];
    [button2 setTag:1];
    [button3 setTag:2];
    [button4 setTag:3];
    
    //Setting the methods for the buttons
    [button1 addTarget:self
                action:@selector(toggleMenu)
      forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self
                action:@selector(updateCurrentIndex:)
      forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self
                action:@selector(updateCurrentIndex:)
      forControlEvents:UIControlEventTouchUpInside];
    [button4 addTarget:self
                action:@selector(updateCurrentIndex:)
      forControlEvents:UIControlEventTouchUpInside];
    
    //Setting some default values
    _isOpen = NO;
    _currentIndex = 0;
    _openDuration = 0;
    _closeDuration = 0;
    
    _openDuration = 0.2;
    _closeDuration = 0.2;
}

#pragma mark menuView methods

-(void)toggleMenu {
    if (!_isOpen) {
        //Menu is closed
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_openDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationWillStartSelector:@selector(menuViewWillOpen)];
        [UIView setAnimationDidStopSelector:@selector(menuViewDidOpen)];
        
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
        [UIView setAnimationWillStartSelector:@selector(menuViewWillClose)];
        [UIView setAnimationDidStopSelector:@selector(menuViewDidClose)];
        
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
    
    if ([self.delegate respondsToSelector:@selector(MVDmenuIsOpen:)]) {
        [delegate MVDmenuIsOpen:isOpen];
    }
}

-(void)updateCurrentIndex:(UIButton *)sender {
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
    
    if ([self.delegate respondsToSelector:@selector(MVDcurrentIndexWasUpdated:)]) {
        [delegate MVDcurrentIndexWasUpdated:sender.tag - 1];
    }
    
    [self toggleMenu]; //Close the menu programmatically
}

-(void)hideExtButtons {
    if (!_isOpen) {
        [self hideButtons];
    } else  {
        [self showButtons];
    }
}

-(void)hideButtons {
    [button2 setHidden:YES];
    [button3 setHidden:YES];
    [button4 setHidden:YES];
}

-(void)showButtons {
    [button2 setHidden:NO];
    [button3 setHidden:NO];
    [button4 setHidden:NO];
}

-(void)menuViewWillOpen {
    
    if ([self.delegate respondsToSelector:@selector(MVDmenuViewWillOpen)]) {
            [delegate MVDmenuViewWillOpen];
    }
    
    [self hideExtButtons];
}

-(void)menuViewWillClose {
    if ([self.delegate respondsToSelector:@selector(MVDmenuViewWillClose)]) {
        [delegate MVDmenuViewWillClose];
    }
}

-(void)menuViewDidOpen {
    if ([self.delegate respondsToSelector:@selector(MVDmenuViewDidOpen)]) {
        [delegate MVDmenuViewDidOpen];
    }
}

-(void)menuViewDidClose {
    if ([self.delegate respondsToSelector:@selector(MVDmenuViewDidClose)]) {
        [delegate MVDmenuViewDidClose];
    }
    
    [self hideExtButtons];
}

-(void)setOpenDuration:(float)duration {
    _openDuration = duration;
}

-(void)setCloseDuration:(float)duration {
    _closeDuration = duration;
}

-(void)setImage:(UIImage *)image forButton:(long)button forState:(UIControlState)controlState {
    switch (button) {
        case 0:
            [button1 setImage:image forState:controlState];
            break;
        case 1:
            [button2 setImage:image forState:controlState];
            break;
        case 2:
            [button3 setImage:image forState:controlState];
            break;
        case 3:
            [button4 setImage:image forState:controlState];
            break;
        default:
            break;
    }
}

-(void)setCurrentIndex:(long)index {
    _currentIndex = index;
}

-(void)setDelegate:(id)id {
    delegate = id;
}

@end
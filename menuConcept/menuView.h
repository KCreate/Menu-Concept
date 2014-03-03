//
//  menuView.h
//  menuConcept
//
//  Created by Leonard Schuetz on 03.03.14.
//  Copyright (c) 2014 Leonard Schuetz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class menuView;
@protocol menuViewDelegate
-(void)menuViewNewIndex:(long int)currentIndex;

@end

@interface menuView : UIView {
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    
    CGRect button1_rect;
    CGRect button2_rect;
    CGRect button3_rect;
    CGRect button4_rect;
    
    UIView *menuViewNib;
    
    //Class Variables
    BOOL _isOpen;
    BOOL _buttonsAreHidden;
    long int _currentIndex;
    
    float _openDuration;
    float _closeDuration;
}

-(id)initWithDefaultsWithDevice:(NSString *)userDevice;
-(void)toggleMenu;
-(void)setOpenDuration:(float)duration;
-(void)setCloseDuration:(float)duration;

-(void)setImageForButton1:(UIImage *)image forState:(UIControlState)controlState;
-(void)setImageForButton2:(UIImage *)image forState:(UIControlState)controlState;
-(void)setImageForButton3:(UIImage *)image forState:(UIControlState)controlState;
-(void)setImageForButton4:(UIImage *)image forState:(UIControlState)controlState;

@property (nonatomic, assign) id  delegate;
@property (nonatomic, readonly) long int currentIndex;
@property (nonatomic, readonly) BOOL isOpen;
@property (nonatomic, readwrite) BOOL consoleOutput;

@end

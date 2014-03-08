//
//  menuView.h
//  menuConcept
//
//  Created by Leonard Schuetz on 03.03.14.
//  Copyright (c) 2014 Leonard Schuetz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class menuView;
@protocol menuViewDelegate

@required
-(void)MVDcurrentIndexWasUpdated:(long int)currentIndex;

@optional
-(void)MVDmenuIsOpen:(BOOL)isOpen;
-(void)MVDmenuViewWillOpen;
-(void)MVDmenuViewDidOpen;
-(void)MVDmenuViewWillClose;
-(void)MVDmenuViewDidClose;

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
    
    //Class Variables
    BOOL _isOpen;
    long int _currentIndex;
    float openDuration;
    float closeDuration;
    SystemSoundID audioEffect;
}

//Private functions
-(id)initWithCenter:(CGPoint)center;
-(void)toggleMenuWithButton:(UIButton *)sender SE:(BOOL)flag;

//Public functions
-(void)setImage:(UIImage *)image forButton:(long int)button forState:(UIControlState)controlState;
-(void)setCurrentIndex:(long int)index;
-(void)setDelegate:(id)id;
-(void)setMinAlpha:(float)value;
-(void)setMaxAlpha:(float)value;
-(void)setCornerRadius:(float)radius;

//Properties the user can set
@property (nonatomic, assign) id  delegate;
@property (nonatomic, readonly) long int currentIndex;
@property (nonatomic, readonly) BOOL isOpen;
@property (nonatomic, readwrite) float minAlpha;
@property (nonatomic, readwrite) float maxAlpha;
@property (nonatomic, readwrite) float cornerRadius;
@property (nonatomic, readwrite) CGSize buttonScale;

@end


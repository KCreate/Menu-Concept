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

-(id)initWithCenter:(CGPoint)center;

//Public functions
-(void)toggleMenu;
-(void)setImage:(UIImage *)image forButton:(long int)button forState:(UIControlState)controlState;
-(void)setCurrentIndex:(long int)index;
-(void)setDelegate:(id)id;
-(void)setMinAlpha:(float)value;
-(void)setMaxAlpha:(float)value;
-(void)setCornerRadius:(float)radius;
-(void)setShadowForButtonAtIndex:(int)buttonIndex
      shadowOffset:(CGSize)size
       shadowColor:(UIColor*)shadowColor
     shadowOpacity:(float)shadowOpacity;
-(void)setDrawButtonBorder:(BOOL)flag;
-(void)setWantsMask:(BOOL)flag;
-(void)setBackgroundEnabled:(BOOL)flag;
-(void)setBackgroundColor:(UIColor *)color forButtonAtIndex:(long int)index;
-(void)resetAndReload;
-(void)reload;

//Properties the user can get
@property (nonatomic, assign) id  delegate;
@property (nonatomic, readwrite) long int currentIndex;
@property (nonatomic, readonly) BOOL isOpen;
@property (nonatomic, readwrite) BOOL backgroundEnabled;
@property (nonatomic, readwrite) BOOL wantsMask;
@property (nonatomic, readwrite) float minAlpha;
@property (nonatomic, readwrite) float maxAlpha;
@property (nonatomic, readwrite) float cornerRadius;
@property (nonatomic, readwrite) BOOL drawButtonBorder;

@end


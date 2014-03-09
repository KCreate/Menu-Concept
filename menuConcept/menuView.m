//
//  menuView.m
//  menuConcept
//
//  Created by Leonard Schuetz on 03.03.14.
//  Copyright (c) 2014 Leonard Schuetz. All rights reserved.
//

#import "menuView.h"
#import "ViewController.h"

@interface menuView()

-(void)toggleMenuWithButton:(UIButton *)sender SE:(BOOL)flag;
-(void)applySelectedSignToButtonWithIndex:(long int)index;

@end

@implementation menuView
@synthesize isOpen, currentIndex, delegate, minAlpha, maxAlpha, cornerRadius, wantsMask, backgroundEnabled, drawButtonBorder;
@synthesize button1, button2, button3, button4, button1_rect, button2_rect, button3_rect, button4_rect;

- (id)initWithCenter:(CGPoint)center {
    
    self = [super initWithFrame:CGRectMake(35,410,200,150)];
    [self setCenter:center];
    [self initialization];
    
    return self;
}

#pragma mark initStage1

-(void)initialization {
    //Setting some default values
    _isOpen = NO;
    _currentIndex = 0;
    openDuration = 0.5;
    closeDuration = 0.5;
    minAlpha = 0;
    maxAlpha = 1;
    cornerRadius = 25;
    wantsMask = NO;
    backgroundEnabled = YES;
    drawButtonBorder = YES;
    
    //Creating a couple button to use. Defined in the menuViewButton class
    button1 = [[UIButton alloc] initWithFrame:button1_rect];
    button2 = [[UIButton alloc] initWithFrame:button2_rect];
    button3 = [[UIButton alloc] initWithFrame:button3_rect];
    button4 = [[UIButton alloc] initWithFrame:button4_rect];
    
    //Adding the previusly initialized buttons to our view
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
    
    //Set alpha values
    [button2 setAlpha:0];
    [button3 setAlpha:0];
    [button4 setAlpha:0];
    
    //Put the colors on the buttons
    [button1 setBackgroundColor:[UIColor grayColor]];
    [button2 setBackgroundColor:[UIColor redColor]];
    [button3 setBackgroundColor:[UIColor redColor]];
    [button4 setBackgroundColor:[UIColor redColor]];
    
    //Round the corner of the buttons
    [button1.layer setCornerRadius:cornerRadius];
    [button2.layer setCornerRadius:cornerRadius];
    [button3.layer setCornerRadius:cornerRadius];
    [button4.layer setCornerRadius:cornerRadius];
    
    //Set tags for the buttons to identificate them in further methods
    [button1 setTag:0];
    [button2 setTag:1];
    [button3 setTag:2];
    [button4 setTag:3];
    
    //Setting methods for UIControlEventTouchUpInside
    [button1 addTarget:self
                action:@selector(toggleMenuWithButton:SE:)
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
    
    //Setting methods for UIControlEventTouchDown
    [button1 addTarget:self
                action:@selector(scalingEffect:)
      forControlEvents:UIControlEventTouchDown];
    [button2 addTarget:self
                action:@selector(scalingEffect:)
      forControlEvents:UIControlEventTouchDown];
    [button3 addTarget:self
                action:@selector(scalingEffect:)
      forControlEvents:UIControlEventTouchDown];
    [button4 addTarget:self
                action:@selector(scalingEffect:)
      forControlEvents:UIControlEventTouchDown];
    
    //Setting methods for UIControlEventTouchDownCancel
    [button1 addTarget:self
                action:@selector(scalingEffectDown:)
      forControlEvents:UIControlEventTouchDragExit];
    [button2 addTarget:self
                action:@selector(scalingEffectDown:)
      forControlEvents:UIControlEventTouchDragExit];
    [button3 addTarget:self
                action:@selector(scalingEffectDown:)
      forControlEvents:UIControlEventTouchDragExit];
    [button4 addTarget:self
                action:@selector(scalingEffectDown:)
      forControlEvents:UIControlEventTouchDragExit];
}

#pragma mark menuView methods

-(void)toggleMenuWithButton:(UIButton *)sender SE:(BOOL)flag {
    //Set the corner radius
    [self reload];
    
    if (!_isOpen) {
        //Menu is closed
        [UIView animateWithDuration:openDuration
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:40
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void) {
                             [self menuViewWillOpen];
                             
                             //Frame Animation
                             [button2 setFrame:button2_rect];
                             
                             //Alpha Animation
                             [button2 setAlpha:maxAlpha];
                         }
                         completion:^(BOOL finished) {
                         }];
        [UIView animateWithDuration:openDuration
                              delay:0.1
             usingSpringWithDamping:0.8
              initialSpringVelocity:40
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void) {
                             //Frame Animation
                             [button3 setFrame:button3_rect];
                             
                             //Alpha Animation
                             [button3 setAlpha:maxAlpha];
                         }
                         completion:^(BOOL finished) {
                         }];
        [UIView animateWithDuration:openDuration
                              delay:0.2
             usingSpringWithDamping:0.8
              initialSpringVelocity:40
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void) {
                             //Frame Animation
                             [button4 setFrame:button4_rect];
                             [button1 setFrame:button1_rect];
                             
                             //Alpha Animation
                             [button4 setAlpha:maxAlpha];
                         }
                         completion:^(BOOL finished) {
                             [self menuViewDidOpen];
                             _isOpen = YES;
                         }];
    } else {
        //Menu is open
        [UIView animateWithDuration:closeDuration
                              delay:0
             usingSpringWithDamping:1
              initialSpringVelocity:40
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void) {
                             [self menuViewWillClose];
                             
                             //Frame Animation
                             [button2 setFrame:button1_rect];
                             
                             //Alpha Animation
                             [button2 setAlpha:minAlpha];
                         }
                         completion:^(BOOL finished) {
                         }];
        [UIView animateWithDuration:closeDuration
                              delay:0.1
             usingSpringWithDamping:1
              initialSpringVelocity:40
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void) {
                             //Frame Animation
                             [button3 setFrame:button1_rect];
                             
                             //Alpha Animation
                             [button3 setAlpha:minAlpha];
                         }
                         completion:^(BOOL finished) {
                         }];
        [UIView animateWithDuration:closeDuration
                              delay:0.2
             usingSpringWithDamping:1
              initialSpringVelocity:40
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void) {
                             //Frame Animation
                             [button4 setFrame:button1_rect];
                             [button1 setFrame:button1_rect];
                             
                             //Alpha Animation
                             [button4 setAlpha:minAlpha];
                         }
                         completion:^(BOOL finished) {
                             [self menuViewDidClose];
                             _isOpen = NO;
                         }];
    }
    
    if ([delegate respondsToSelector:@selector(MVDmenuIsOpen:)]) {
        [delegate MVDmenuIsOpen:isOpen];
    }
        [self scalingEffectDown:sender];
}

-(void)updateCurrentIndex:(UIButton *)sender {
    if (sender != Nil) {
        currentIndex = sender.tag -1; NSLog(@"%li", currentIndex);
        [self toggleMenuWithButton:sender SE:NO];
        if ([delegate respondsToSelector:@selector(MVDcurrentIndexWasUpdated:)]) {
            [delegate MVDcurrentIndexWasUpdated:currentIndex];
        }
        if (drawButtonBorder) {
            [self applySelectedSignToButtonWithIndex:sender.tag];
        }
    }
}

-(void)hideExtButtons {
    if (!_isOpen) {
        [self showButtons];
    } else {
        [self hideButtons];
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
}

-(void)setOpenDuration:(float)duration {
    openDuration = duration;
}

-(void)setCloseDuration:(float)duration {
    closeDuration = duration;
}

-(void)setImage:(UIImage *)image forButton:(long int)button forState:(UIControlState)controlState {
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

-(void)setMinAlpha:(float)value {
    minAlpha = value;
}

-(void)setMaxAlpha:(float)value {
    maxAlpha = value;
}

-(void)setCornerRadius:(float)radius {
    //Set the corner radius
    cornerRadius = radius;
    [button1.layer setCornerRadius:radius];
    [button2.layer setCornerRadius:radius];
    [button3.layer setCornerRadius:radius];
    [button4.layer setCornerRadius:radius];
}

-(void)scalingEffect:(UIButton *)sender {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                        animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(1, 1, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.3, 1.3, 1.3);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                     [NSValue valueWithCATransform3D:scale1],
                     [NSValue valueWithCATransform3D:scale2],
                     nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:0.5],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .2;
    
    [sender.layer addAnimation:animation forKey:nil];
}

-(void)scalingEffectDown:(UIButton *)sender {
    //Scale down effect
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(1.3, 1.3, 1.3);
    CATransform3D scale2 = CATransform3DMakeScale(1, 1, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .2;
    
    [sender.layer addAnimation:animation forKey:nil];
}

- (void)playSoundNamed:(NSString *)fName withExt:(NSString *) ext{
    NSString *path = [[NSBundle mainBundle] pathForResource : fName ofType :ext];
    if ([[NSFileManager defaultManager] fileExistsAtPath : path]) {
        NSURL *pathURL = [NSURL fileURLWithPath: path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
    }
    else {
        NSLog(@"error, file not found: %@", path);
    }
}

-(void)setShadowForButtonAtIndex:(int)buttonIndex
             shadowOffset:(CGSize)size
              shadowColor:(UIColor*)shadowColor
            shadowOpacity:(float)shadowOpacity
{
    //Get which buttons should be styled
    switch (buttonIndex) {
        case 0:
            //Main Button
            [button1.layer setShadowOffset:size];
            [button1.layer setShadowColor:shadowColor.CGColor];
            [button1.layer setShadowOpacity:shadowOpacity];
            break;
        case 1:
            //Second Button
            [button2.layer setShadowOffset:size];
            [button2.layer setShadowColor:shadowColor.CGColor];
            [button2.layer setShadowOpacity:shadowOpacity];
            break;
        case 2:
            //Third Button
            [button3.layer setShadowOffset:size];
            [button3.layer setShadowColor:shadowColor.CGColor];
            [button3.layer setShadowOpacity:shadowOpacity];
            break;
        case 3:
            //Fourt Button
            [button4.layer setShadowOffset:size];
            [button4.layer setShadowColor:shadowColor.CGColor];
            [button4.layer setShadowOpacity:shadowOpacity];
            break;
        default:
            break;
    }
}

-(void)setBackgroundEnabled:(BOOL)flag {
    backgroundEnabled = flag;
    [self reload];
}

-(void)setBackgroundColor:(UIColor *)color forButtonAtIndex:(long int)index {
    switch (index) {
        case 0:
            //Main Button
            [button1 setBackgroundColor:color];
            break;
        case 1:
            //Second button
            [button2 setBackgroundColor:color];
            break;
        case 2:
            //Third Button
            [button3 setBackgroundColor:color];
            break;
        case 3:
            //Fourt button
            [button4 setBackgroundColor:color];
            break;
        default:
            break;
    }
    
    [self reload];
}

- (void)resetAndReload {
    [self initialization];
}

-(void)reload {
    [button1.layer setCornerRadius:cornerRadius];
    [button2.layer setCornerRadius:cornerRadius];
    [button3.layer setCornerRadius:cornerRadius];
    [button4.layer setCornerRadius:cornerRadius];
    
    if (!backgroundEnabled) {
        [button1 setBackgroundColor:[UIColor clearColor]];
        [button2 setBackgroundColor:[UIColor clearColor]];
        [button3 setBackgroundColor:[UIColor clearColor]];
        [button4 setBackgroundColor:[UIColor clearColor]];
    }
    
    if (!drawButtonBorder) {
        button2.layer.borderWidth = 0;
        button2.layer.borderColor = [UIColor clearColor].CGColor;
        button3.layer.borderWidth = 0;
        button3.layer.borderColor = [UIColor clearColor].CGColor;
        button4.layer.borderWidth = 0;
        button4.layer.borderColor = [UIColor clearColor].CGColor;
    }
    
    if (wantsMask) {
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        CGRect maskRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
        maskLayer.path = path;
        CGPathRelease(path);
        self.layer.mask = maskLayer;
    } else {
        self.layer.mask = nil;
    }
}

-(void)setWantsMask:(BOOL)flag {
    wantsMask = flag;
    [self reload];
}

-(void)toggleMenu {
    [self toggleMenuWithButton:nil SE:NO];
}

- (void)applySelectedSignToButtonWithIndex:(long int)index {
    button2.layer.borderWidth = 0;
    button2.layer.borderColor = [UIColor clearColor].CGColor;
    button3.layer.borderWidth = 0;
    button3.layer.borderColor = [UIColor clearColor].CGColor;
    button4.layer.borderWidth = 0;
    button4.layer.borderColor = [UIColor clearColor].CGColor;
    
    switch (index) {
        case 1:
            button2.layer.borderWidth = 2;
            button2.layer.borderColor = [UIColor blackColor].CGColor;
            break;
        case 2:
            button3.layer.borderWidth = 2;
            button3.layer.borderColor = [UIColor blackColor].CGColor;
            break;
        case 3:
            button4.layer.borderWidth = 2;
            button4.layer.borderColor = [UIColor blackColor].CGColor;
            break;
        default:
            break;
    }
}

-(void)setDrawButtonBorder:(BOOL)flag {
    drawButtonBorder = flag;
}

@end
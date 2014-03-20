//
//  MSViewController.h
//  MysticSquare2
//
//  Created by Micah Gemmell on 2/7/14.
//  Copyright (c) 2014 Micah Gemmell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UIButton *button12;
@property (weak, nonatomic) IBOutlet UIButton *button13;
@property (weak, nonatomic) IBOutlet UIButton *button14;
@property (weak, nonatomic) IBOutlet UIButton *button15;
@property (weak, nonatomic) IBOutlet UIButton *button_blank;
@property (weak, nonatomic) IBOutlet UIButton *winButton;

@property (nonatomic) NSArray *buttons;
@property (nonatomic) UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic) UISwipeGestureRecognizer *swipeRight;
@property (nonatomic) UISwipeGestureRecognizer *swipeDown;
@property (nonatomic) UISwipeGestureRecognizer *swipeUp;

@property (weak, nonatomic) IBOutlet UIButton *shuffle;
@property (weak, nonatomic) IBOutlet UIButton *reset;

@property (weak, nonatomic) IBOutlet UISlider *intensity_slider;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UITextField *sliderValueText;


@end

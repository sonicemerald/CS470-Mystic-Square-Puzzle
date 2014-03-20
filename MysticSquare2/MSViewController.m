//
//  MSViewController.m
//  MysticSquare2
//
//  Created by Micah Gemmell on 2/7/14.
//  Copyright (c) 2014 Micah Gemmell. All rights reserved.
//

// This is a working game of Mystic Square. However, the MSLogic file only determines if a game has been won or not. The "maintain game state" criteria was a little confusing, and by the time I found out what was meant by that, the amount of time I had to work on it did not allow for completion. However, I included some of the functions that I started to implement for the MSLogic file. I can see now that having the isLegalMove code in the MSLogic file would make my solution nicer.


#import "MSViewController.h"
#import "MSLogic.h"

@interface MSViewController ()
@property (nonatomic) MSLogic *MSLogic;
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;
@property (nonatomic) NSInteger blank_x;
@property (nonatomic) NSInteger blank_y;
@property (nonatomic) NSMutableArray *originalArray;
@property (nonatomic) NSInteger value;
@property (nonatomic) NSInteger num_shuffle;
@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic) bool didShuffle;
-(bool) swapLeft;
-(bool) swapRight;
-(bool) swapUp;
-(bool) swapDown;
@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.buttons = [[NSArray alloc] initWithObjects:self.button1,self.button2, self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, self.button9, self.button10, self.button11, self.button12, self.button13, self.button14, self.button15, self.button_blank, nil];
    
    //Shuffle
    [self.shuffle addTarget:self action:@selector(didTapShuffle:) forControlEvents:UIControlEventTouchUpInside];

    //Reset
    [self.reset addTarget:self action:@selector(didTapReset:) forControlEvents:UIControlEventTouchUpInside];
    
    //UISlider
    [self.intensity_slider addTarget:self action:@selector(didSlide:) forControlEvents: UIControlEventValueChanged];
    [self.intensity_slider setMinimumValue:0];
    [self.intensity_slider setMaximumValue:50];
//  [self.intensity_slider setMaximumTrackTintColor:[UIColor grayColor]];
    [self.intensity_slider setMinimumTrackTintColor:[UIColor orangeColor]];
    [self.intensity_slider setThumbTintColor:[UIColor blackColor]]; //doesn't seem to work?
    [self.sliderValueText setText:@"0"];
    
    //Swiping Gestures
    //Left
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    //Right
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    //Up
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeUp:)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];

    //Down
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown:)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
    [self.view addGestureRecognizer:swipeDown];
    [self.view addGestureRecognizer:swipeUp];

    NSInteger i = 0;
    self.originalArray = [[NSMutableArray alloc] init];
    for(UIButton *b in self.buttons){
        [b setBackgroundColor:[UIColor whiteColor]];
        [b setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        NSValue *bg = [NSValue valueWithCGPoint:[b center]];
        [b setTag:i++];
        [self.originalArray addObject:bg];
    }
    [self.button_blank setBackgroundColor:[UIColor grayColor]];
    [self.button_blank setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.reset setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.reset setBackgroundColor:[UIColor whiteColor]];
    [self.shuffle setBackgroundColor:[UIColor whiteColor]];
    [self.shuffle setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    
    [self setWidth:(int)self.button_blank.frame.size.width];
    [self setHeight:(int)self.button_blank.frame.size.height];
    self.MSLogic = [[MSLogic alloc] init];
    
    self.winButton.hidden = TRUE;
    self.didShuffle = FALSE;
    
}

-(void)didSwipeLeft:(UISwipeGestureRecognizer *) sender
{
    NSLog(@"Swiped left");
    [self swapLeft];
    
    //second draft code attempt.
//    NSInteger index = [self.MSLogic IsLegalMove:[self view] WithArray:[self buttons] andBlank:[self button_blank] Direction:self.left];
//    NSLog(@"found match for swapLeft");
//    UIButton *toSwap = [self.buttons objectAtIndex:index];
//    CGPoint bc = [toSwap center];
//    [UIView animateWithDuration:1 animations:^{
//        [toSwap setCenter:[self.button_blank center]];
//        [self.button_blank setCenter:bc];
//    } completion:^(BOOL finished){
//        if(self.didShuffle == FALSE){
//            if([self.MSLogic didWin:self.buttons comparedTo:self.originalArray])
//                self.winButton.hidden = FALSE; }
//        NSLog(@"swapLeft complete");
//        NSLog(@"%ld", (long)[self.button_blank.superview center].x);
//        NSLog(@"%ld", (long)[toSwap.superview center].x);
//        NSLog(@"%ld", (long)[toSwap tag]);
//        
//    }];
    
}

-(void)didSwipeRight:(UISwipeGestureRecognizer *) sender
{
    [self swapRight];
    NSLog(@"swiped right");
}

-(void)didSwipeUp:(UISwipeGestureRecognizer *) sender
{
    NSLog(@"swiped up");
    [self swapUp];
}

-(void)didSwipeDown:(UISwipeGestureRecognizer *) sender
{
    NSLog(@"swiped down");
    [self swapDown];
}

-(bool)swapLeft{
    [self setBlank_y:[self.button_blank.superview convertPoint:[self.button_blank center] toView:self.view].y];
    [self setBlank_x:[self.button_blank.superview convertPoint:[self.button_blank center] toView:self.view].x];
    for(UIButton *b in self.buttons){
        //Getting the x and y values of each button, and comparing it with the blank button.
        NSInteger by = [b.superview convertPoint:[b center] toView:[self view]].y;
        NSInteger bx = [b.superview convertPoint:[b center] toView:[self view]].x;
        
        if(bx-[self width]-10 == [self blank_x] && by == [self blank_y]){
            NSLog(@"found match for swapLeft");
            CGPoint bc = [b center];
            [UIView animateWithDuration:1 animations:^{
                [b setCenter:[self.button_blank center]];
                [self.button_blank setCenter:bc];
            } completion:^(BOOL finished){
                if(self.didShuffle == FALSE){
                if([self.MSLogic didWin:self.buttons comparedTo:self.originalArray])
                    self.winButton.hidden = FALSE; }
                NSLog(@"swapLeft complete");
            }]; return TRUE;
        }
    }
    return FALSE;
}
-(bool)swapRight{
    [self setBlank_y:[self.button_blank.superview convertPoint:[self.button_blank center] toView:self.view].y];
    [self setBlank_x:[self.button_blank.superview convertPoint:[self.button_blank center] toView:self.view].x];
    for(UIButton *b in self.buttons){
        NSInteger by = [b.superview convertPoint:[b center] toView:self.view].y;
        NSInteger bx = [b.superview convertPoint:[b center] toView:self.view].x;
        
        if(bx+[self width]+10 == [self blank_x] && by == [self blank_y]){
            if([self blank_x]-(2*[self width]) < 0){break;}
            NSLog(@"found match for swapRight");
            CGPoint bc = [b center];
            [UIView animateWithDuration:1 animations:^{
                [b setCenter:[self.button_blank center]];
                [self.button_blank setCenter:bc];
            } completion:^(BOOL finished){
                if(self.didShuffle == FALSE){
                if([self.MSLogic didWin:self.buttons comparedTo:self.originalArray])
                    self.winButton.hidden = FALSE;}
                NSLog(@"SwapRight complete");
            }]; return TRUE;
            
        }
    }
    return FALSE;
}
-(bool)swapUp{
    [self setBlank_y:[self.button_blank.superview convertPoint:[self.button_blank center] toView:self.view].y];
    [self setBlank_x:[self.button_blank.superview convertPoint:[self.button_blank center] toView:self.view].x];
    for(UIButton *b in self.buttons){
        NSInteger by = [b.superview convertPoint:[b center] toView:self.view].y;
        NSInteger bx = [b.superview convertPoint:[b center] toView:self.view].x;
        
        //NSLog(@"(%ld, %ld)", (long)bx, (long)by);
        
        
        if(by-[self height]-10 == [self blank_y] && bx == [self blank_x]){
            //if([self blank_x]-(2*height) < 0){break;}
            NSLog(@"found match for swapUp");
            CGPoint bc = [b center];
            [UIView animateWithDuration:1 animations:^{
                [b setCenter:[self.button_blank center]];
                [self.button_blank setCenter:bc];
            } completion:^(BOOL finished){
                if(self.didShuffle == FALSE){
                    if([self.MSLogic didWin:self.buttons comparedTo:self.originalArray])
                    self.winButton.hidden = FALSE; }
                NSLog(@"SwapUp complete");
            }]; return TRUE;
            
        }
    }
    return FALSE;
}
-(bool)swapDown{
    [self setBlank_y:[self.button_blank.superview convertPoint:[self.button_blank center] toView:self.view].y];
    [self setBlank_x:[self.button_blank.superview convertPoint:[self.button_blank center] toView:self.view].x];
    for(UIButton *b in self.buttons){
        NSInteger by = [b.superview convertPoint:[b center] toView:self.view].y;
        NSInteger bx = [b.superview convertPoint:[b center] toView:self.view].x;
        
        //NSLog(@"(%ld, %ld)", (long)bx, (long)by);
        
        
        if(by+[self height]+10 == [self blank_y] && bx == [self blank_x]){
            //if([self blank_x]-(2*height) < 0){break;}
            NSLog(@"found match for swapDown");
            CGPoint bc = [b center];
            [UIView animateWithDuration:1 animations:^{
                [b setCenter:[self.button_blank center]];
                [self.button_blank setCenter:bc];
            } completion:^(BOOL finished){
                if(self.didShuffle == FALSE){
                if([self.MSLogic didWin:self.buttons comparedTo:self.originalArray])
                    self.winButton.hidden = FALSE;
                }
                NSLog(@"SwapDown complete");
            }]; return TRUE;
        }
    }
    return FALSE;
}


-(void)didTapShuffle:(UITapGestureRecognizer *) sender
{
    self.didShuffle = TRUE;
    self.num_shuffle = self.value;
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(switchLoop) userInfo:nil repeats:YES];
    NSLog(@"shuffle tapped");
}

-(void)switchLoop
{
    if( self.num_shuffle == 0 ) {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
        self.didShuffle = FALSE;
        return;
    }
    self.winButton.hidden = TRUE;
    switch (arc4random_uniform(4)) {
        case 0:
            if([self swapUp])
                self.num_shuffle--;
            break;
        case 1:
            if([self swapDown])
                self.num_shuffle--;
            break;
        case 2:
            if([self swapLeft])
                self.num_shuffle--;
            break;
        case 3:
            if([self swapRight])
                self.num_shuffle--;
            break;
        default:
            break;
    }
}

-(void)didTapReset:(UITapGestureRecognizer *) sender
{
    for(UIButton *b in self.buttons){
            [UIView animateWithDuration:1.5 animations:^{
                [b setCenter:[[self.originalArray objectAtIndex:[b tag]] CGPointValue]];
            }];
    }
    self.winButton.hidden = TRUE;
    
    NSLog(@"reset tapped");
}


-(void)didSlide:(UITapGestureRecognizer *) sender
{
    self.value = [self.intensity_slider value];
    [self.sliderValueText setText:[NSString stringWithFormat: @"%d", (int)[self.intensity_slider value]]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

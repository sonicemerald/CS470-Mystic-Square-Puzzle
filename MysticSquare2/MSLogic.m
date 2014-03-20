//
//  MSLogic.m
//  MysticSquare2
//
//  Created by Micah Gemmell on 2/11/14.
//  Copyright (c) 2014 Micah Gemmell. All rights reserved.
//

#import "MSLogic.h"

@interface MSLogic()

@end

@implementation MSLogic

-(bool) didWin:(NSArray *) array comparedTo:(NSArray *)original {
        for(UIButton *b in array){
            if([b center].x != [[original objectAtIndex:[b tag]] CGPointValue].x
                || [b center].y != [[original objectAtIndex:[b tag]] CGPointValue].y){
                return FALSE;
            }
        }
    return TRUE;
}

//Here is my attempt at making the model act a bit more like how you described in class on thursday, but I could not spend enough time on this to get it completely working. I'm not going to include the little variables that I made in the viewController (ie assign each move a number... etc). but in my viewcontroller I will include the animation code I was able to sort of get to work in this second draft.



//-(NSInteger) IsLegalMove:(UIView *)view WithArray:(NSArray *)array andBlank:(UIButton *)blank Direction:(NSInteger)move{
//    
//    NSInteger width = blank.frame.size.width;
//    NSInteger height = blank.frame.size.height;
//    NSInteger blank_x = [blank.superview convertPoint:[blank center] toView:view].x;
//    NSInteger blank_y = [blank.superview convertPoint:[blank center] toView:view].y;
//    
//    for(UIButton *b in array){
//        //Getting the x and y values of each button, and comparing it with the blank button.
//        NSInteger by = [b.superview convertPoint:[b center] toView:view].y;
//        NSInteger bx = [b.superview convertPoint:[b center] toView:view].x;
//        
//        switch (move) {
//            case 0:
//                if(bx-width-10 == blank_x && by == blank_y){
//                    NSLog(@"found match for swapLeft");
//                    return [array indexOfObject:b]; }
//                break;
//            case 1:
//                if(by == blank_y && bx+width+10 == blank_x){
//                    //                    if(blank_x-(2*width) < 0){break;}
//                    return [array indexOfObject:b];
//                }
//                break;
//            case 2:
//                
//                break;
//            case 3:
//                break;
//                
//            default:
//                break;
//        }
//    }


@end

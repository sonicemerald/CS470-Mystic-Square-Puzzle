//
//  MSLogic.h
//  MysticSquare2
//
//  Created by Micah Gemmell on 2/11/14.
//  Copyright (c) 2014 Micah Gemmell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSLogic : NSObject
-(bool) didWin:(NSArray *) array comparedTo:(NSArray *) original;
@end

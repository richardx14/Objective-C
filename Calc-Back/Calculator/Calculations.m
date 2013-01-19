//
//  Calculations.m
//  Calculator
//
//  Created by James Nguyen on 1/15/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "Calculations.h"

@implementation Calculations

+ (double)Add:(double)A And:(double)B {
    return A + B;
}

+ (double)Subtract:(double)A And:(double)B {
    return A - B;
}

+ (double)Multiply:(double)A And:(double)B {
    return A * B;
}

+ (double)Divide:(double)A And:(double)B {
    return A / B;
}

+ (double)Raise:(double)A Power:(double)B {
    if(B == 0) {
        return 1;
    } else {
        return (A * [self Raise:A Power:B-1]);
    }
}

+ (double) Pi:(double)A {
    return A;
}

@end

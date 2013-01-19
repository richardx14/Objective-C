//
//  CalculatorBrain.m
//  Calculator
//
//  Created by James Nguyen on 1/14/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "CalculatorBrain.h"
#import "Calculations.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack; // makes the instance variables for the pointer, never allocates anything

// Getter for operandStack
- (NSMutableArray *)operandStack {
    if(_operandStack == nil)
        _operandStack = [[NSMutableArray alloc] init]; // Lazy instantiation
    return _operandStack;
}

// Setter for operandStack 
- (void)setOperandStack:(NSMutableArray *)operandStack {
    _operandStack = operandStack;
}

// Adds a number into the stack for evaluation later.
- (void)pushOperand:(double)operand {
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject != nil) {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}

// Take a look at the top of the stack but don't remove it.
- (double)peekOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation {
    double result = 0;
    // calculate result
    if ([operation isEqualToString:@"+"]) {
        result = [Calculations Add:[self popOperand] And:[self popOperand]];
    } else if ([@"*" isEqualToString:operation]) {
        result = [Calculations Multiply:[self popOperand] And:[self popOperand]];
    } else if ([operation isEqualToString:@"/"]) {
        result = [Calculations Divide:[self popOperand] And:[self popOperand]];
    } else if ([operation isEqualToString:@"-"]) {
        result = [Calculations Subtract:[self popOperand] And:[self popOperand]];
    } else if ([operation isEqualToString:@"Pi"]) {
        // First push 3.14 into the stack then return it.
        [self pushOperand:3.14];
        result = [Calculations Pi:[self peekOperand]];
    } else if ([operation isEqualToString:@"Sin"]) {
        result = [Calculations Sin_:[self popOperand]];
    } else if ([operation isEqualToString:@"Cos"]) {
        result = [Calculations Cos_:[self popOperand]];
    } else if ([operation isEqualToString:@"Sqrt"]) {
        result = [Calculations Sqrt_:[self popOperand]];
    }
    return result;
}

- (void)removeAll {
    while(self.operandStack.count) {
        [self.operandStack removeLastObject];
    }
}

- (BOOL)isEmpty {
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject == nil) {
        return TRUE;
    } else {
        return FALSE;
    }
}

@end















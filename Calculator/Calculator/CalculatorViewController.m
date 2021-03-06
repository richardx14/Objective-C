//
//  CalculatorViewController.m
//  Calculator
//
//  Created by James Nguyen on 1/14/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL userPressedDecimalKey;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize inputs = _inputs;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userPressedDecimalKey;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if(!_brain)
        _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

/* Numbers buttons that also takes care of the decimal. */
- (IBAction)digitPressed:(UIButton *)sender {
    if([sender.currentTitle isEqualToString:@"."] && self.userPressedDecimalKey == YES)
        return;
    else if([sender.currentTitle isEqualToString:@"."])
        self.userPressedDecimalKey = YES;
    
    NSString *digit = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    // Write to the inputs label.
    self.inputs.text = [self.inputs.text stringByAppendingString:digit];
}

/* When an operation is pressed, it sends what operation specified to the brain,
 the brain returns a result based on the string. It also updates the display and inputs labels. */
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber)
       [self enterPressed];
    // If pressing Pi, add the previous operand to the stack.
    if([sender.currentTitle isEqualToString:@"Pi"])
        [self.brain pushOperand:[self.display.text doubleValue]];
    double result = [self.brain performOperation:sender.currentTitle];
    
    NSString * resultString = [NSString stringWithFormat:@"%g", result];
    // Update inputs and display label.
    self.inputs.text = [self.inputs.text stringByAppendingString:sender.currentTitle];
    self.inputs.text = [self.inputs.text stringByAppendingString:@" "];
    self.display.text = resultString;
}

/* When Enter is pressed, it pushes an operand onto a stack from the brain and
 updates the labels on the screen. */
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userPressedDecimalKey = NO;
    self.inputs.text = [self.inputs.text stringByAppendingString:@" "];
}


- (IBAction)clearAll:(UIButton *)sender {
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userPressedDecimalKey = NO;
    // Clear both labels and clear the stack in the brain.
    self.display.text = @"0";
    self.inputs.text = @"";
    [self.brain removeAll];
}



@end


















//
//  ViewController.m
//  BillSplitter
//
//  Created by Renato Camilio on 1/26/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *totalAmountField;
@property (weak, nonatomic) IBOutlet UISlider *peopleSplittingBillSlider;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountPerPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleSplittingBillLabel;

- (void)calculateSplitAmount;
- (void)updateTotalAmountPerPersonLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.totalAmountField.text = @"0.00";
    
    [self.peopleSplittingBillSlider addTarget:self action:@selector(calculateSplitAmount) forControlEvents:UIControlEventTouchUpInside];
    [self.peopleSplittingBillSlider addTarget:self action:@selector(updateTotalAmountPerPersonLabel) forControlEvents:UIControlEventValueChanged];
    self.totalAmountField.delegate = self;
    
    [self calculateSplitAmount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// calculate the total split amount when user is done with text field input as well
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self calculateSplitAmount];
    
    return NO;
}

- (void)updateTotalAmountPerPersonLabel {
    self.peopleSplittingBillSlider.value = roundf(self.peopleSplittingBillSlider.value);
    self.peopleSplittingBillLabel.text = [NSString stringWithFormat:@"%.0f people splitting", self.peopleSplittingBillSlider.value];
}

- (IBAction)calculateSplitAmount {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.generatesDecimalNumbers = YES;
    
    NSNumber *totalAmount = [numberFormatter numberFromString:self.totalAmountField.text];
    float amountPerPerson = [totalAmount floatValue] / self.peopleSplittingBillSlider.value;
    
    self.totalAmountPerPersonLabel.text = [NSString stringWithFormat:@"Amount per person: $%.2f", amountPerPerson];
}

@end

//
//  ProfileViewController.m
//  Utime
//
//  Created by AdrianHsu on 2015/5/17.
//  Copyright (c) 2015年 AdrianHsu. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "MissionItem.h"

@interface ProfileViewController () <UITextFieldDelegate>

@property (nonatomic) CFTimeInterval countDownDuration;
@property (nonatomic) BOOL canShowDatePicker;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.timeButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.canShowDatePicker = NO;
}

- (UIView *)inputAccessoryView{
    
    if (![self isFirstResponder]) {
        return nil;
    }
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [toolbar setItems:@[cancel, space, done]];
    
    return toolbar;
}

- (UIView *)inputView{
    
    if (![self isFirstResponder]) {
        return nil;
    }
    
    return self.datePicker;
}

- (BOOL)canBecomeFirstResponder{
    
    
    //NSLog(@"textField is first responder:%d",self.missonTextField.isFirstResponder);
    //NSLog(@"self.isFirstResponder:%d",self.isFirstResponder);
    if (self.missonTextField.isFirstResponder) {
        return NO;
    }
    
    return self.canShowDatePicker;
}

- (BOOL)canResignFirstResponder{
    
    self.canShowDatePicker = NO;
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

- (void) keyboardWillAppear:(NSNotification *) note{
    
    if (self.isFirstResponder) {
        return;
    }
    
    //NSLog(@"userInfo:%@",note.userInfo);
    NSValue *endFrameValue = note.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect endFrame = [endFrameValue CGRectValue];
    
    CGFloat currentViewMaxY = CGRectGetMaxY(self.view.bounds);
    CGFloat keyboardMaxY = CGRectGetMidY(endFrame);
    
    CGRect textFieldViewFrame = self.missonTextField.frame;
    CGFloat textFieldOffset = currentViewMaxY - CGRectGetMaxY(textFieldViewFrame);
    
    CGFloat offset = keyboardMaxY - currentViewMaxY - textFieldOffset;

//    CGRect newTargetFrame = CGRectOffset(self.view.frame, 0, offset);
//    self.view.frame = newTargetFrame;
    
    self.view.transform = CGAffineTransformMakeTranslation(0, offset);
    
}

-(void) keyboardWillHide: (NSNotification* ) note{
    
    if (self.isFirstResponder) {
        return;
    }

    self.view.transform = CGAffineTransformIdentity;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) done:(id)sender{
    self.countDownDuration = [self.datePicker countDownDuration];
    [self resignFirstResponder];
    
}

- (void) cancel:(id)sender{
    [self resignFirstResponder];
    
}

- (IBAction)setTime:(id)sender {
    self.canShowDatePicker = YES;
    [self becomeFirstResponder];
}

- (IBAction)startCountown:(id)sender {
    
  
    NSString *name = self.missonTextField.text;
    
    
    if ([name isEqualToString:@""]) {
        /*UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:@"You haven't set anything" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];*/
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        MissionItem* missionItem = [NSEntityDescription insertNewObjectForEntityForName:@"MissionItem" inManagedObjectContext:context];
        missionItem.mission = @"FOCUS MODE";
        [appDelegate saveContext];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:@"Set as FOCUS MODE." preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        MissionItem* missionItem = [NSEntityDescription insertNewObjectForEntityForName:@"MissionItem" inManagedObjectContext:context];
        missionItem.mission = name;
        [appDelegate saveContext];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:@"START!" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}

- (IBAction)setMission:(id)sender {
}
@end

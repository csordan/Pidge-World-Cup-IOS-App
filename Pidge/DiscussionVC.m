//
//  DiscussionVC.m
//  NewsCup
//
//  Created by Mac on 22/06/18.
//  Copyright © 2018 Vaipan. All rights reserved.
//

#import "DiscussionVC.h"
#import "SCLAlertView.h"

@interface DiscussionVC ()

@property (nonatomic,strong) NSMutableArray *array_questions;
@property (nonatomic) int correct;
@property (nonatomic) int current;

@property (nonatomic,weak) IBOutlet UILabel *lbl_question;
@property (nonatomic,weak) IBOutlet UIButton *btn_ans1;
@property (nonatomic,weak) IBOutlet UIButton *btn_ans2;
@property (nonatomic,weak) IBOutlet UIButton *btn_ans3;

@property (nonatomic,weak) IBOutlet UILabel *lbl_score;
@property (nonatomic,strong) IBOutlet UIView *view_score;

@end

@implementation DiscussionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _array_questions = [[NSMutableArray alloc] init];
    [self load_Questions];
    _correct = 0;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self start_quize];
}

- (void)load_Questions{
    NSMutableDictionary *que1 = [[NSMutableDictionary alloc] init];
    [que1 setObject:@"How many teams took part in the 2018 world cup?" forKey:@"q"];
    [que1 setObject:@"32" forKey:@"a"];
    [que1 setObject:@"32" forKey:@"a1"];
    [que1 setObject:@"16" forKey:@"a2"];
    [que1 setObject:@"36" forKey:@"a3"];
    
    NSMutableDictionary *que2 = [[NSMutableDictionary alloc] init];
    [que2 setObject:@"How many cities were the FIFA Cup matches held in for the 2018 Cup?" forKey:@"q"];
    [que2 setObject:@"11" forKey:@"a"];
    [que2 setObject:@"15" forKey:@"a1"];
    [que2 setObject:@"12" forKey:@"a2"];
    [que2 setObject:@"11" forKey:@"a3"];
    
    NSMutableDictionary *que3 = [[NSMutableDictionary alloc] init];
    [que3 setObject:@"What city were the finals held in 2018?" forKey:@"q"];
    [que3 setObject:@"Moscow" forKey:@"a"];
    [que3 setObject:@"Saint Petersburg" forKey:@"a1"];
    [que3 setObject:@"Moscow" forKey:@"a2"];
    [que3 setObject:@"Sochi" forKey:@"a3"];
    
    NSMutableDictionary *que4 = [[NSMutableDictionary alloc] init];
    [que4 setObject:@"How many times has Russia hosted the event?" forKey:@"q"];
    [que4 setObject:@"One" forKey:@"a"];
    [que4 setObject:@"Two" forKey:@"a1"];
    [que4 setObject:@"Three" forKey:@"a2"];
    [que4 setObject:@"One" forKey:@"a3"];
    
    [_array_questions addObject:que1];
    [_array_questions addObject:que2];
    [_array_questions addObject:que3];
    [_array_questions addObject:que4];
}

- (void)start_quize {
    
    if (_current >= _array_questions.count) {
        
        [_lbl_score setText:[NSString stringWithFormat:@"You got %d/%lu correct",_correct,(unsigned long)_array_questions.count]];
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        alert.iconTintColor = [UIColor colorWithRed:250.0f/255.0f green:241.0f/255.0f blue:202.0f/255.0f alpha:1.0];
        
        [alert addCustomView:_view_score];
        //Using Block
        [alert addButton:@"Close" actionBlock:^(void) {
            NSLog(@"Second button tapped");
            self.current = 0;
            self.correct = 0;
            [self start_quize];
        }];
        [alert showNotice:self title:nil subTitle:nil closeButtonTitle:nil duration:0.0f];

        return;
    }
    
    NSDictionary *que = [_array_questions objectAtIndex:_current];
    
    [_lbl_question setText:[que valueForKey:@"q"]];
    [_lbl_question sizeToFit];
    _lbl_question.layer.masksToBounds = YES;
    _lbl_question.layer.cornerRadius = 8.0;
    
    [_btn_ans1 setTitle:[NSString stringWithFormat:@"a) %@",[que valueForKey:@"a1"]] forState:UIControlStateNormal];
    [_btn_ans2 setTitle:[NSString stringWithFormat:@"b) %@",[que valueForKey:@"a2"]] forState:UIControlStateNormal];
    [_btn_ans3 setTitle:[NSString stringWithFormat:@"c) %@",[que valueForKey:@"a3"]] forState:UIControlStateNormal];
    
    [_btn_ans1 setBackgroundColor:[UIColor clearColor]];
    [_btn_ans2 setBackgroundColor:[UIColor clearColor]];
    [_btn_ans3 setBackgroundColor:[UIColor clearColor]];
}

- (IBAction)answerTapped:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    
    NSDictionary *que = [_array_questions objectAtIndex:_current];
    
    NSString *ans = [btn.titleLabel.text substringFromIndex:3];
    
    if ([ans isEqualToString:[que valueForKey:@"a"]]) {
        NSLog(@"Correct");
        _correct++;
    }else{
        [btn setBackgroundColor:[UIColor redColor]];
    }
    
    if ([[_btn_ans1.titleLabel.text substringFromIndex:3] isEqualToString:[que valueForKey:@"a"]]) {
        [_btn_ans1 setBackgroundColor:[UIColor greenColor]];
    }
    if ([[_btn_ans2.titleLabel.text substringFromIndex:3] isEqualToString:[que valueForKey:@"a"]]) {
        [_btn_ans2 setBackgroundColor:[UIColor greenColor]];
    }
    if ([[_btn_ans3.titleLabel.text substringFromIndex:3] isEqualToString:[que valueForKey:@"a"]]) {
        [_btn_ans3 setBackgroundColor:[UIColor greenColor]];
    }
    
    _current++;
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self start_quize];
    });
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

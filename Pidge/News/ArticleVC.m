//
//  ArticleVC.m
//  Pidge
//
//  Created by Jabez Wesley on 7/30/18.
//  Copyright © 2018 Vaipan. All rights reserved.
//

#import "ArticleVC.h"

@interface ArticleVC ()
@end

@implementation ArticleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"we here");
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(goBack:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    NSInteger buttonHeight = 0;
    button.frame = CGRectMake(0, 0, self.view.frame.size.width,buttonHeight);
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, buttonHeight, self.view.frame.size.width,self.view.frame.size.height-buttonHeight)];
    [webview loadRequest:_request];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [webview addGestureRecognizer:swipe];
    
    [self.view addSubview:button];
    [self.view addSubview:webview];
}

- (void)goBack:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"tryna go back");
    NSArray *myControllers = self.parentNavigationController.viewControllers;
    int previous = myControllers.count - 2;
    UIViewController *previousController = [myControllers objectAtIndex:previous];
    [self.parentNavigationController popToViewController:previousController animated:YES];
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

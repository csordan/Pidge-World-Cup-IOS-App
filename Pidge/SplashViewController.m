//
//  SplashViewController.m
//  NewsCup
//
//  Created by Mac on 22/06/18.
//  Copyright © 2018 Vaipan. All rights reserved.
//

#import "SplashViewController.h"

#import "LCTabBarController.h"
#import "NewsVC.h"
#import "FavoriteTabVC.h"
//#import "MatchesVC.h"
#import "DiscussionVC.h"
#import "SettingsVC.h"
#import <AVFoundation/AVFoundation.h>


static const float PLAYER_VOLUME = 1.0;

@interface SplashViewController ()

@property (nonatomic,strong) NewsVC *news;
@property (nonatomic,strong) FavoriteTabVC *favorite;
//@property (nonatomic,strong) MatchesVC *matches;
@property (nonatomic,strong) DiscussionVC *discussion;
@property (nonatomic,strong) SettingsVC *settings;

@property (nonatomic) AVPlayer *player;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _news = [[NewsVC alloc] initWithNibName:@"NewsVC" bundle:nil];
    //_matches = [[MatchesVC alloc] initWithNibName:@"MatchesVC" bundle:nil];
    _favorite = [[FavoriteTabVC alloc] initWithNibName:@"FavoriteTabVC" bundle:nil];
    _discussion = [[DiscussionVC alloc] initWithNibName:@"DiscussionVC" bundle:nil];
    _settings = [[SettingsVC alloc] initWithNibName:@"SettingsVC" bundle:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   // [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setupTabbar) userInfo:nil repeats:NO];
    [self createVideoPlayer];
}

- (void)createVideoPlayer {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"splash_video" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player.volume = PLAYER_VOLUME;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = UIViewContentModeScaleToFill;
    playerLayer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:playerLayer];
    
    [self.player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

#pragma mark - observer of player

// 视频循环播放
- (void)moviePlayDidEnd:(NSNotification*)notification{
    
    AVPlayerItem *item = [notification object];
    //[item seekToTime:kCMTimeZero];
    //[self.player play];
   // [self setupTabbar];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(setupTabbar) userInfo:nil repeats:NO];
}


- (void)setupTabbar{
    
    _news.title = @"NEWS";
    _news.tabBarItem.image = [UIImage imageNamed:@"NEWS.png"];
    _news.tabBarItem.selectedImage = [UIImage imageNamed:@"NEWS_SELECTED.png"];
    
    //_matches.title = @"MATCHES";
    //_matches.tabBarItem.image = [UIImage imageNamed:@"MATCHES.png"];
    _favorite.title = @"FAVORITES";
    _favorite.tabBarItem.image = [UIImage imageNamed:@"FAVORITE.png"];
    _favorite.tabBarItem.selectedImage = [UIImage imageNamed:@"FAVORITE_SELECTED.png"];
    
    _discussion.title = @"TRIVIA";
    _discussion.tabBarItem.image = [UIImage imageNamed:@"DISCUSSION.png"];
    _discussion.tabBarItem.selectedImage = [UIImage imageNamed:@"DISCUSSION_SELECTED.png"];
    
    _settings.title = @"SETTINGS";
    _settings.tabBarItem.image = [UIImage imageNamed:@"SETTINGS.png"];
    _settings.tabBarItem.selectedImage = [UIImage imageNamed:@"SETTINGS_SELECTED.png"];
    
    UINavigationController *nav_news = [[UINavigationController alloc] initWithRootViewController:_news];
    [nav_news setNavigationBarHidden:YES];
    UINavigationController *nav_matches = [[UINavigationController alloc] initWithRootViewController:_favorite];
    [nav_matches setNavigationBarHidden:YES];
    UINavigationController *nav_discussion = [[UINavigationController alloc] initWithRootViewController:_discussion];
    [nav_discussion setNavigationBarHidden:YES];
    UINavigationController *nav_settings = [[UINavigationController alloc] initWithRootViewController:_settings];
    [nav_settings setNavigationBarHidden:YES];
    
    /**************************************** Key Code ****************************************/
    LCTabBarController *tabBarC = [[LCTabBarController alloc] init];
    
    tabBarC.itemTitleFont          = [UIFont systemFontOfSize:8.0f];
    tabBarC.itemTitleColor         = [UIColor darkGrayColor];
    tabBarC.selectedItemTitleColor = [UIColor colorWithRed:74.0f/255.0f green:48.0f/255.0f blue:75.0f/255.0f alpha:1.0];
    tabBarC.itemImageRatio         = 0.8f;
    //tabBarC.badgeTitleFont         = [UIFont boldSystemFontOfSize:12.0f];
    tabBarC.badgeTitleFont         = [UIFont fontWithName:@"Alcubierre" size:15.0];//[UIFont systemFontOfSize:15.0];
    
    tabBarC.viewControllers = @[nav_news, nav_matches, nav_discussion, nav_settings];
    [self.navigationController pushViewController:tabBarC animated:YES];
    
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

//
//  NewsVC.m
//  NewsCup
//
//  Created by Mac on 22/06/18.
//  Copyright © 2018 Vaipan. All rights reserved.
//

#import "NewsVC.h"
#import "CAPSPageMenu.h"
#import "NewsTabVC.h"
#import "ScoreTabVC.h"
#import "FavoriteTabVC.h"
#import "MatchesVC.h"

@interface NewsVC ()


@property (nonatomic,strong) NewsTabVC *newstab;
@property (nonatomic,strong) ScoreTabVC *scoretab;
@property (nonatomic,strong) MatchesVC *matchesTab;

@property (nonatomic,strong) FavoriteTabVC *favoritetab;
@property (nonatomic,strong) CAPSPageMenu *pagemenu;
@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _newstab = [[NewsTabVC alloc] initWithNibName:@"NewsTabVC" bundle:nil];
    _scoretab = [[ScoreTabVC alloc] initWithNibName:@"ScoreTabVC" bundle:nil];
    _matchesTab = [[MatchesVC alloc] initWithNibName:@"MatchesVC" bundle:nil];
    _favoritetab = [[FavoriteTabVC alloc] initWithNibName:@"FavoriteTabVC" bundle:nil];
    //self.tabBarItem.title = @"NEWS";
    
    [self createSwipe];
}

-(void)createSwipe{
    NSMutableArray *controllerArray = [NSMutableArray array];
    
    _newstab.title = @"NEWS";
    _scoretab.title = @"SCORES";
    _matchesTab.title = @"MATCHES";
    _newstab.parentNavigationController = self.navigationController;
    
    UINavigationController *match = [[UINavigationController alloc] initWithRootViewController:_matchesTab];
    
    [controllerArray addObject:_scoretab];
    [controllerArray addObject:_newstab];
    [controllerArray addObject:match];
    
    NSDictionary *parameters = @{CAPSPageMenuOptionMenuItemSeparatorWidth: @(1.3),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(NO),
                                 CAPSPageMenuOptionMenuItemSeparatorPercentageHeight: @(0.1)
                                 };
    
    // Initialize page menu with controller array, frame, and optional parameters
    _pagemenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 20.0, self.view.frame.size.width, self.view.frame.size.height) options:nil];
    _pagemenu.scrollMenuBackgroundColor = [UIColor greenColor];
    _pagemenu.bottomMenuHairlineColor = [UIColor greenColor];
    _pagemenu.menuItemFont = [UIFont systemFontOfSize:50.0f];
   
    //_pagemenu.menuItemWidth = 30.0f;
    // Lastly add page menu as subview of base view controller view
    // or use pageMenu controller in you view hierachy as desired
    [self.view addSubview:_pagemenu.view];
     [_pagemenu moveToPage:1];
    
    
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

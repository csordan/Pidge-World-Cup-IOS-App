//
//  MatchesVC.m
//  NewsCup
//
//  Created by Mac on 22/06/18.
//  Copyright © 2018 Vaipan. All rights reserved.
//

#import "MatchesVC.h"
#import "MatchDetailsVC.h"

@interface MatchesVC () <UIScrollViewDelegate>
@property (nonatomic,strong) IBOutlet UIScrollView *scrollBase;
@property (nonatomic,strong) IBOutlet UIView *baseView;

@property (nonatomic,strong) MatchDetailsVC *matchDetails;
@property (nonatomic,strong) NSMutableArray *array_teams;

@end

@implementation MatchesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //[_scrollBase setContentSize:CGSizeMake(500, 100)];
    //[_scrollBase setDelegate:self];
    
    _scrollBase.contentSize = _baseView.frame.size;
    _scrollBase.delegate = self;
    _scrollBase.minimumZoomScale = 0.7;
    _scrollBase.maximumZoomScale = 100.0;
    _scrollBase.zoomScale = 0.7;
    
    _matchDetails = [[MatchDetailsVC alloc] initWithNibName:@"MatchDetailsVC" bundle:nil];
    
    _array_teams = [[NSMutableArray alloc] init];
    
    NSDictionary *teams = [self JSONFromFile];
    for ( NSDictionary *team in teams) {
        [_array_teams addObject:team];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.scrollBase.bounds),
                                      CGRectGetMidY(self.scrollBase.bounds));
    [self view:self.baseView setCenter:centerPoint];
}

- (IBAction)teamSelected :(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"(team contains %@)",btn.titleLabel.text];
    NSArray *filteredContacts = [_array_teams filteredArrayUsingPredicate:filter];
    if (filteredContacts.count >0) {
        _matchDetails.team = [filteredContacts objectAtIndex:0];
        
        [self.navigationController pushViewController:_matchDetails animated:YES];
    }
    
    
}

- (void)view:(UIView*)view setCenter:(CGPoint)centerPoint
{
    CGRect vf = view.frame;
    CGPoint co = self.scrollBase.contentOffset;
    
    CGFloat x = centerPoint.x - vf.size.width / 2.0;
    CGFloat y = centerPoint.y - vf.size.height / 2.0;
    
    if(x < 0)
    {
        co.x = -x;
        vf.origin.x = 0.0;
    }
    else
    {
        vf.origin.x = x;
    }
    if(y < 0)
    {
        co.y = -y;
        vf.origin.y = 0.0;
    }
    else
    {
        vf.origin.y = y;
    }
    
    view.frame = vf;
    self.scrollBase.contentOffset = co;
}

- (void)makeRoundedBG{
    for (UIButton *btn in _baseView.subviews) {
        if (btn.tag==1) {
            btn.layer.cornerRadius = 10;//btn.frame.size.height/2;;
            btn.clipsToBounds = YES;
            btn.layer.borderWidth=2.0;
            btn.layer.borderColor=[[UIColor orangeColor] CGColor];
        }
    }
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"1");
    
    return _baseView;
}

- (void)get_servers{
    NSDictionary *dict = [self JSONFromFile];
    NSLog(@"%@", dict);
}

- (NSDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"teams" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
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

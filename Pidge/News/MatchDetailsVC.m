//
//  MatchDetailsVC.m
//  Pidge
//
//  Created by Vaipan on 18/07/18.
//  Copyright © 2018 Vaipan. All rights reserved.
//

#import "MatchDetailsVC.h"
#import "PlayerCustomCell.h"
#import "PlayerProfile.h"

@interface MatchDetailsVC ()

@property (nonatomic,weak) IBOutlet UIImageView *img_teamPic;
@property (nonatomic,strong) IBOutlet UILabel *lbl_teamDetails;
@property (nonatomic,weak) IBOutlet UITableView *tbl_players;

@property (nonatomic,strong) NSMutableArray *players;
@property (nonatomic,strong) NSMutableArray *array_url;

@end

@implementation MatchDetailsVC
@synthesize team;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _players = [[NSMutableArray alloc] init];
    _array_url = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self setDetails:team];
}

- (NSInteger) addToUrlArray:(NSString *) url{
    [_array_url addObject:url];
    return _array_url.count-1;
}

//{
//    "id": 0,
//    "player_name": "David Silva",
//    "player_picture": "David Silva.jpg"
//},
- (void)setDetails :(NSDictionary *)_team{
    
    self.title = [_team valueForKey:@"team"];
    UIImage *teamImage = [UIImage imageNamed:[_team valueForKey:@"team_picture"]];
    if (!teamImage) {
        teamImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [_team valueForKey:@"code"]]];
    }
    [_img_teamPic setImage:teamImage];
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://ec2-54-174-176-235.compute-1.amazonaws.com:5000/team/%@", [_team valueForKey:@"code"]];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    [_lbl_teamDetails setText:[json valueForKey:@"description"]];
    [_lbl_teamDetails sizeToFit];
    _lbl_teamDetails.numberOfLines = 0;
    NSMutableArray *players = [[NSMutableArray alloc] init];
    for(id player in [json objectForKey:@"players"]){
        NSMutableDictionary *thisPlayer = [[NSMutableDictionary alloc] init];
        //[thisPlayer setValue:players.count forKey:@"id"];
        [thisPlayer setValue:[player objectForKey:@"name"] forKey:@"playername"];
        NSString* pictureString;
        //[pictureString stringByReplacingOccurrencesOfString:[player objectForKey:@"name"] withString:@""];
        pictureString = [player objectForKey:@"name"];
        pictureString = [NSString stringWithFormat:@"%@.jpg",pictureString];
        [thisPlayer setValue:pictureString forKey:@"playerpicture"];
        [players addObject:thisPlayer];
    }
    _players = players;
    [self.tbl_players reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _players.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlayerCustomCell";
    
    // Similar to UITableViewCell, but
    PlayerCustomCell *cell = (PlayerCustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlayerCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSMutableDictionary *player = [_players objectAtIndex:indexPath.row];
    [cell.lbl_playerName setText:[player valueForKey:@"playername"]];
    [cell.img_PlayerPic setImage:[UIImage imageNamed:[player valueForKey:@"playerpicture"]]];
    
    cell.img_PlayerPic.layer.cornerRadius = cell.img_PlayerPic.frame.size.height/2;;
    cell.img_PlayerPic.clipsToBounds = YES;
    cell.img_PlayerPic.layer.borderWidth=2.0;
    cell.img_PlayerPic.layer.borderColor= [[UIColor colorWithRed:74.0f/255.0f green:48.0f/255.0f blue:75.0f/255.0f alpha:1.0] CGColor];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    
    cell.tag = [self addToUrlArray:[player valueForKey:@"playername"]];
    //NSLog([news valueForKey:@"url"]);
    
    [cell addGestureRecognizer:singleFingerTap];
    
    return cell;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"handling tag %d",recognizer.view.tag);
    NSLog([_array_url objectAtIndex:recognizer.view.tag]);
    PlayerProfile *pvc = [[PlayerProfile alloc] init];
    pvc.playername = [_array_url objectAtIndex:recognizer.view.tag];
    //avc.parentNavigationController = self.parentNavigationController;
    [self.navigationController pushViewController:pvc animated:YES];
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

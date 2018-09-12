//
//  EnglandVC.m
//  Pidge
//
//  Created by jficula on 7/29/18.
//  Copyright © 2018 Vaipan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PlayerProfile.h"
#import "statCell.h"


@interface PlayerProfile ()

@property (nonatomic,weak) IBOutlet UIImageView *img_playerPic;
@property (nonatomic,strong) IBOutlet UILabel *lbl_playerDetails;
@property (nonatomic,weak) IBOutlet UITableView *tbl_stats;

@property (nonatomic,strong) NSMutableArray *players;

@end

@implementation PlayerProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _players = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self setDetails];
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
    static NSString *CellIdentifier = @"statCell";
    
    // Similar to UITableViewCell, but
    statCell *cell = (statCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"statCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSMutableDictionary *player = [_players objectAtIndex:indexPath.row];
    [cell.lbl_stat setText:[player valueForKey:@"playerstat"]];
    return cell;
}

- (NSString *) getPlayerURL{
    NSString *formattedName = [[_playername lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [NSString stringWithFormat:@"http://ec2-54-174-176-235.compute-1.amazonaws.com:5000/player/%@", formattedName];
}

- (void)setDetails{
    self.title = _playername;
    NSString *urlString = [self getPlayerURL];
    NSLog(urlString);
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    UIImage *pic = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", _playername]];
    
    [_img_playerPic setImage:pic];
    
    [_lbl_playerDetails setText:[json objectForKey:@"bio"]];
    //[_lbl_playerDetails setText:@"Captain Harry Kane is England’s undoubted talisman, leader and key player. The prolific Tottenham Hotspur man is a forward who can score all types of goals: with both feet, his head, from distance or from inside the six yard box – he has consistently found the net for club and country since bursting into the Spurs first team in the 2014-15 campaign, winning the English Premier League Golden Boot in 2015-16 and 2016-17. To say then that England are reliant on Kane is a vast understatement. He played a pivotal role on the road to the 2018 FIFA World Cup Russia™, scoring winning goals against Slovenia and Lithuania and a late equaliser against Scotland – those three goals alone accounting for seven qualifying points. Kane will be looking to carry that influence into the finals themselves, and step up to the next level of superstardom by shining at a World Cup."];
   // [_lbl_playerDetails sizeToFit];
    _lbl_playerDetails.numberOfLines = 0;
    
   // [_lbl_playerDetails sizeToFit];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ScoreCustomCell.h
//  NewsCup
//
//  Created by Mac on 25/06/18.
//  Copyright © 2018 Vaipan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreCustomCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *lbldate;
@property (nonatomic,weak) IBOutlet UIImageView *imgPlayerTeam;
@property (nonatomic,weak) IBOutlet UILabel *lbl_player_score;
@property (nonatomic,weak) IBOutlet UILabel *lbl_player_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_player_prediction;



@property (nonatomic,weak) IBOutlet UIImageView *imgOpponenetTeam;
@property (nonatomic,weak) IBOutlet UILabel *lbl_opponent_score;
@property (nonatomic,weak) IBOutlet UILabel *lbl_opponent_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_opponent_prediction;


@end

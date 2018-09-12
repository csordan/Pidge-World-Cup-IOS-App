//
//  ScoreTabVC.m
//  NewsCup
//
//  22/06/18.
//  Chris Sordan
//

#import "ScoreTabVC.h"
#import "ScoreCustomCell.h"
#import <QuartzCore/QuartzCore.h>
#import "WebServiceHandler_Vishal.h"
#import "MBProgressHUD.h"

@interface ScoreTabVC ()

@property (nonatomic,weak) IBOutlet UITableView *tbl_scores;
@property (nonatomic,strong) NSMutableArray *array_scores;

@end

@implementation ScoreTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _array_scores = [[NSMutableArray alloc] init];
    //[self loadScores];
    [self getScores];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getScores];
}

- (void)getScores{
    [_array_scores removeAllObjects];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WebServiceHandler_Vishal sharedSingleton] call_webApi_Get:@"http://ec2-54-174-176-235.compute-1.amazonaws.com:5000/scores" :^(NSDictionary *result){
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableArray *liveScores = [result objectForKey:@"in progress"];
        //NSMutableArray *futureScores = [json objectForKey:@"future"];
        NSMutableArray *completedScores = [result objectForKey:@"completed"];
        
        for (id score in liveScores){
            NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
            NSString *home_team_code = [[score objectForKey:@"home_team"] objectForKey:@"code"];
            NSString *away_team_code = [[score objectForKey:@"away_team"] objectForKey:@"code"];
            [item setObject:home_team_code forKey:@"team_name"];
            [item setObject:away_team_code forKey:@"opp_team_name"];
            [item setObject:[NSString stringWithFormat:@"%@.png", home_team_code] forKey:@"flag"];
            [item setObject:[[NSString alloc] initWithFormat:@"%@", [[score objectForKey:@"home_team"] objectForKey:@"goals"]] forKey:@"team_score"];
            [item setObject:[[NSString alloc] initWithFormat:@"%@", [[score objectForKey:@"away_team"] objectForKey:@"goals"]] forKey:@"opp_team_score"];
            [item setObject:[NSString stringWithFormat:@"%@.png", away_team_code] forKey:@"opp_flag"];
            [item setObject:@"25-06-2018 4:30 PM GMT+5" forKey:@"date"];
            [item setObject:[[score objectForKey:@"home_team"] objectForKey:@"prediction"] forKey:@"team_prediction"];
            [item setObject:[[score objectForKey:@"away_team"] objectForKey:@"prediction"] forKey:@"opp_team_prediction"];
            [self.array_scores addObject:item];
        }
        for (id score in completedScores){
            NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
            NSString *home_team_code = [[score objectForKey:@"home_team"] objectForKey:@"code"];
            NSString *away_team_code = [[score objectForKey:@"away_team"] objectForKey:@"code"];
            [item setObject:home_team_code forKey:@"team_name"];
            [item setObject:away_team_code forKey:@"opp_team_name"];
            [item setObject:[NSString stringWithFormat:@"%@.png", home_team_code] forKey:@"flag"];
            [item setObject:[[NSString alloc] initWithFormat:@"%@", [[score objectForKey:@"home_team"] objectForKey:@"goals"]] forKey:@"team_score"];
            [item setObject:[[NSString alloc] initWithFormat:@"%@", [[score objectForKey:@"away_team"] objectForKey:@"goals"]] forKey:@"opp_team_score"];
            [item setObject:[NSString stringWithFormat:@"%@.png", away_team_code] forKey:@"opp_flag"];
            [item setObject:@"25-06-2018 4:30 PM GMT+5" forKey:@"date"];
            [item setObject:[[score objectForKey:@"home_team"] objectForKey:@"prediction"] forKey:@"team_prediction"];
            [item setObject:[[score objectForKey:@"away_team"] objectForKey:@"prediction"] forKey:@"opp_team_prediction"];
            [self.array_scores addObject:item];
        }
        
        [self.tbl_scores reloadData];
        
    } :^(NSError *error){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)loadScores {
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"http://ec2-54-174-176-235.compute-1.amazonaws.com:5000/scores"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_scores count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScoreCustomCell";
    
    // Similar to UITableViewCell, but
    ScoreCustomCell *cell = (ScoreCustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ScoreCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // Just want to test, so I hardcode the data
    NSDictionary *item = [_array_scores objectAtIndex:indexPath.row];
    
    [cell.lbldate setText:[item valueForKey:@"date"]];
    
    [cell.imgPlayerTeam setImage:[UIImage imageNamed:[item valueForKey:@"flag"]]];
    [cell.lbl_player_name setText:[item valueForKey:@"team_name"]];
    [cell.lbl_player_score setText:[item valueForKey:@"team_score"]];
    [cell.lbl_player_prediction setText:[item valueForKey:@"team_prediction"]];
    
    [cell.imgOpponenetTeam setImage:[UIImage imageNamed:[item valueForKey:@"opp_flag"]]];
    [cell.lbl_opponent_name setText:[item valueForKey:@"opp_team_name"]];
    [cell.lbl_opponent_score setText:[item valueForKey:@"opp_team_score"]];
    [cell.lbl_opponent_prediction setText:[item valueForKey:@"opp_team_prediction"]];
    
    cell.imgOpponenetTeam.layer.cornerRadius = cell.imgOpponenetTeam.frame.size.height/2;;
    cell.imgOpponenetTeam.clipsToBounds = YES;
    cell.imgOpponenetTeam.layer.borderWidth=2.0;
    cell.imgOpponenetTeam.layer.borderColor= [[UIColor colorWithRed:74.0f/255.0f green:48.0f/255.0f blue:75.0f/255.0f alpha:1.0] CGColor];
    
    cell.imgPlayerTeam.layer.cornerRadius = cell.imgPlayerTeam.frame.size.height/2;
    cell.imgPlayerTeam.clipsToBounds = YES;
    cell.imgPlayerTeam.layer.borderWidth=2.0;
    cell.imgPlayerTeam.layer.borderColor= [[UIColor colorWithRed:74.0f/255.0f green:48.0f/255.0f blue:75.0f/255.0f alpha:1.0] CGColor];
    return cell;
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

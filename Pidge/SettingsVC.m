//
//  SettingsVC.m
//  Pidge
//
//  Created by Chris Sordan
//

#import "SettingsVC.h"
#import "PrivacyPolicyVC.h"
#import "NotificationsVC.h"


@interface SettingsVC ()
@property (nonatomic,strong) NSMutableArray *arraySettings;
@property (nonatomic,weak) IBOutlet UITableView *tblSettings;
@property (nonatomic,strong) PrivacyPolicyVC *privacyVC;
@property (nonatomic,strong) NotificationsVC *notificationVC;

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _privacyVC = [[PrivacyPolicyVC alloc] initWithNibName:@"PrivacyPolicyVC" bundle:nil];
    _notificationVC = [[NotificationsVC alloc] initWithNibName:@"NotificationsVC" bundle:nil];
    
    // Do any additional setup after loading the view from its nib.
    _arraySettings = [[NSMutableArray alloc] init];
    [_arraySettings addObject:@"Privacy Policy"];
    [_arraySettings addObject:@"Support"];
    [_arraySettings addObject:@"Language"];
    [_arraySettings addObject:@"Notification Settings"];
    [_arraySettings addObject:@"Sign Up"];
    [_arraySettings addObject:@"Reset Password"];
    [_tblSettings reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arraySettings.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [_tblSettings dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.textLabel.text =  [_arraySettings objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont fontWithName:@"Avenir Next Medium" size:14]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //NSLog(@"title of cell %@", [_content objectAtIndex:indexPath.row]);
    if (indexPath.row ==0) {
        [self.navigationController pushViewController:_privacyVC animated:YES];
    } if (indexPath.row ==3) {
        [self.navigationController pushViewController:_notificationVC animated:YES];
    }
    [self.navigationController setNavigationBarHidden:NO];
    
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

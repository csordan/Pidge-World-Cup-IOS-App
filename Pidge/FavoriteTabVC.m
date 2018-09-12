//
//  FavoriteTabVC.m
//  NewsCup
//
//  Created by Mac on 22/06/18.
//  Copyright © 2018 Vaipan. All rights reserved.
//

#import "FavoriteTabVC.h"
#import "FavoriteCustomCell.h"
#import "PlayerProfile.h"

@interface FavoriteTabVC ()
@property (nonatomic,strong) NSMutableArray *array_players;
@property (nonatomic,weak) IBOutlet UICollectionView *collection;
@property (nonatomic,strong) PlayerProfile *playerProfile;
@property (nonatomic,strong) NSMutableArray *array_url;

@end

@implementation FavoriteTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.collection registerClass:[FavoriteCustomCell class] forCellWithReuseIdentifier:@"FavoriteCustomCell"];
    
    UINib *cellNib = [UINib nibWithNibName:@"FavoriteCustomCell" bundle:nil];
    [self.collection registerNib:cellNib forCellWithReuseIdentifier:@"FavoriteCustomCell"];
    
    _playerProfile = [[PlayerProfile alloc] initWithNibName:@"PlayerProfile" bundle:nil];
    
    _array_players = [[NSMutableArray alloc] init];
    _array_url = [[NSMutableArray alloc] init];
    [self load_players];
}


- (void)load_players{
    NSMutableDictionary *player1 = [[NSMutableDictionary alloc] init];
    [player1 setObject:@"Karim Benzema" forKey:@"name"];
    [player1 setObject:@"Karim Benzema.jpg" forKey:@"image"];
    
    NSMutableDictionary *player2 = [[NSMutableDictionary alloc] init];
    [player2 setObject:@"Cesc Fabregas" forKey:@"name"];
    [player2 setObject:@"Cesc Fabregas.jpg" forKey:@"image"];
    
    NSMutableDictionary *player3 = [[NSMutableDictionary alloc] init];
    [player3 setObject:@"Lionel Messi" forKey:@"name"];
    [player3 setObject:@"Lionel Messi.jpg" forKey:@"image"];
    
    NSMutableDictionary *player4 = [[NSMutableDictionary alloc] init];
    [player4 setObject:@"Mohamed Salah" forKey:@"name"];
    [player4 setObject:@"Mohamed Salah.jpg" forKey:@"image"];
    
    NSMutableDictionary *player5 = [[NSMutableDictionary alloc] init];
    [player5 setObject:@"David Silva" forKey:@"name"];
    [player5 setObject:@"David Silva.jpg" forKey:@"image"];
    
    NSMutableDictionary *player6 = [[NSMutableDictionary alloc] init];
    [player6 setObject:@"Franck Ribery" forKey:@"name"];
    [player6 setObject:@"Franck Ribery.jpg" forKey:@"image"];
    
    NSMutableDictionary *player7 = [[NSMutableDictionary alloc] init];
    [player7 setObject:@"Mats Hummels" forKey:@"name"];
    [player7 setObject:@"Mats Hummels.jpg" forKey:@"image"];
    
    NSMutableDictionary *player8 = [[NSMutableDictionary alloc] init];
    [player8 setObject:@"Jordi Alba" forKey:@"name"];
    [player8 setObject:@"Jordi Alba.jpg" forKey:@"image"];
    
    NSMutableDictionary *player9 = [[NSMutableDictionary alloc] init];
    [player9 setObject:@"Manuel Neuer" forKey:@"name"];
    [player9 setObject:@"Manuel Neuer.jpg" forKey:@"image"];
    
    NSMutableDictionary *player10 = [[NSMutableDictionary alloc] init];
    [player10 setObject:@"Marcelo Vieira" forKey:@"name"];
    [player10 setObject:@"Marcelo Vieira.jpg" forKey:@"image"];
    
    NSMutableDictionary *player11 = [[NSMutableDictionary alloc] init];
    [player11 setObject:@"Harry Kane" forKey:@"name"];
    [player11 setObject:@"Harry Kane.jpg" forKey:@"image"];
    
    NSMutableDictionary *player12 = [[NSMutableDictionary alloc] init];
    [player12 setObject:@"Mesut Ozil" forKey:@"name"];
    [player12 setObject:@"Mesut Ozil.jpg" forKey:@"image"];
    
    NSMutableDictionary *player13 = [[NSMutableDictionary alloc] init];
    [player13 setObject:@"Sergio Ramos" forKey:@"name"];
    [player13 setObject:@"Sergio Ramos.jpg" forKey:@"image"];
    
    NSMutableDictionary *player14 = [[NSMutableDictionary alloc] init];
    [player14 setObject:@"Sergio Busquets" forKey:@"name"];
    [player14 setObject:@"Sergio Busquets.jpg" forKey:@"image"];
    
    NSMutableDictionary *player15 = [[NSMutableDictionary alloc] init];
    [player15 setObject:@"Luka Modric" forKey:@"name"];
    [player15 setObject:@"Luka Modric.jpg" forKey:@"image"];
    
    NSMutableDictionary *player16 = [[NSMutableDictionary alloc] init];
    [player16 setObject:@"Dani Alves" forKey:@"name"];
    [player16 setObject:@"Dani Alves.jpg" forKey:@"image"];
    
    NSMutableDictionary *player17 = [[NSMutableDictionary alloc] init];
    [player17 setObject:@"Raheem Sterling" forKey:@"name"];
    [player17 setObject:@"Raheem Sterling.jpg" forKey:@"image"];
    
    NSMutableDictionary *player18 = [[NSMutableDictionary alloc] init];
    [player18 setObject:@"Gareth Bale" forKey:@"name"];
    [player18 setObject:@"Gareth Bale.jpg" forKey:@"image"];
    
    NSMutableDictionary *player19 = [[NSMutableDictionary alloc] init];
    [player19 setObject:@"Zlatan Ibrahimovic" forKey:@"name"];
    [player19 setObject:@"Zlatan Ibrahimovic.jpg" forKey:@"image"];
    
    NSMutableDictionary *player20 = [[NSMutableDictionary alloc] init];
    [player20 setObject:@"Willian" forKey:@"name"];
    [player20 setObject:@"Willian.jpg" forKey:@"image"];
    
    NSMutableDictionary *player21 = [[NSMutableDictionary alloc] init];
    [player21 setObject:@"Vincent Kompany" forKey:@"name"];
    [player21 setObject:@"Vincent Kompany.jpg" forKey:@"image"];
    
    [_array_players addObject:player1];
    [_array_players addObject:player2];
    [_array_players addObject:player3];
    [_array_players addObject:player4];
    [_array_players addObject:player5];
    [_array_players addObject:player6];
    [_array_players addObject:player7];
    [_array_players addObject:player8];
    [_array_players addObject:player9];
    [_array_players addObject:player10];
    [_array_players addObject:player11];
    [_array_players addObject:player12];
    [_array_players addObject:player13];
    [_array_players addObject:player14];
    [_array_players addObject:player15];
    [_array_players addObject:player16];
    [_array_players addObject:player17];
    [_array_players addObject:player18];
    [_array_players addObject:player19];
    [_array_players addObject:player20];
    [_array_players addObject:player21];
    
    [_collection reloadData];
}
- (NSInteger) addToUrlArray:(NSString *) url{
    [_array_url addObject:url];
    return _array_url.count-1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array_players.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"FavoriteCustomCell";
    static BOOL nibMyCellloaded = NO;
    if(!nibMyCellloaded)
    {
        UINib *nib = [UINib nibWithNibName:@"FavoriteCustomCell" bundle: nil];
        [cv registerNib:nib forCellWithReuseIdentifier:identifier];
        nibMyCellloaded = YES;
    }
    FavoriteCustomCell *cell = (FavoriteCustomCell*)[cv dequeueReusableCellWithReuseIdentifier:@"FavoriteCustomCell" forIndexPath:indexPath];
    
    NSDictionary *player = [_array_players objectAtIndex:indexPath.row];
    [cell.player_name setText:[player valueForKey:@"name"]];
    [cell.player_image setImage:[UIImage imageNamed:[player valueForKey:@"image"]]];
    
    cell.player_image.layer.cornerRadius = cell.player_image.frame.size.height/2;;
    cell.player_image.clipsToBounds = YES;
    cell.player_image.layer.borderWidth=2.0;
    cell.player_image.layer.borderColor = [[UIColor colorWithRed:74.0f/255.0f green:48.0f/255.0f blue:75.0f/255.0f alpha:1.0] CGColor];

cell.tag = [self addToUrlArray:[player valueForKey:@"name"]];
    
    
UITapGestureRecognizer *singleFingerTap =
[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
[cell  addGestureRecognizer:singleFingerTap];

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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 150);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playerSelected :(id)sender{
    [self.navigationController pushViewController:_playerProfile animated:YES];
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

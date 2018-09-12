//
//  NewsTabVC.m
//  NewsCup
//
//  22/06/18.
//  Copyright © 2018 Chris Sordan
//

#import "NewsTabVC.h"
#import "ArticleVC.h"
#import "WebServiceHandler_Vishal.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"

@interface NewsTabVC ()

@property (nonatomic,weak) IBOutlet UIScrollView *scrollBase;
@property (nonatomic,strong) NSMutableArray *array_news;
@property (nonatomic,strong) NSMutableArray *array_url;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

@implementation NewsTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _array_news = [[NSMutableArray alloc] init];
    _array_url = [[NSMutableArray alloc] init];
    
     //[self load_news];
    [self cleanup];
    [self getNews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self cleanup];
    [self getNews];
}

- (void)getNews{
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[WebServiceHandler_Vishal sharedSingleton] call_webApi_Get:@"http://ec2-54-174-176-235.compute-1.amazonaws.com:5000/news" :^(NSDictionary *result){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableArray *articles = [[NSMutableArray alloc]init];
        articles= [result objectForKey:@"articles"];
        NSInteger count = articles.count;
        while(count%4 > 1){//want to have 4,5 or 8,9 articles. Would want to cut the 10th article
            count--;
        }
        for(int i=0;i<count;i++){
            NSDictionary *article = [articles objectAtIndex:i];
            NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
            [item setObject:[[[article objectForKey:@"images"] objectAtIndex:0] objectForKey:@"image700Url"] forKey:@"image"];
            [item setObject:[article objectForKey:@"title"] forKey:@"title"];
            [item setObject:[article objectForKey:@"summary"] forKey:@"description"];
            [item setObject:@"25th June 2018 " forKey:@"date"];
            [item setObject:[article objectForKey:@"webLink"] forKey:@"url"];
            [self.array_news addObject:item];
        }
        [self create_scroll];
        
    } :^(NSError *error){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@",error);
    }];
}

- (NSInteger) addToUrlArray:(NSString *) url{
    [_array_url addObject:url];
    return _array_url.count-1;
}
- (void)create_scroll{
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    int x=0;
    int y=0;
    
    int count=1;
    
    for (int i=0; i <_array_news.count ; i++){
        
        NSDictionary *news = [_array_news objectAtIndex:i];
        
        UIImageView *img = [[UIImageView alloc] init];
        
        __block UIActivityIndicatorView *activityIndicator;
        [img sd_setImageWithURL:[NSURL URLWithString: [news valueForKey:@"image"]]
                      placeholderImage:[UIImage imageNamed:@"noimage.png"]
                               options:SDWebImageProgressiveDownload
                              progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                  if (!activityIndicator) {
                                      [img addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                      activityIndicator.center = img.center;//cell.img_Picture.center;
                                      [activityIndicator setColor:[UIColor colorWithRed:74.0f/255.0f green:48.0f/255.0f blue:75.0f/255.0f alpha:1.0]];
                                      [activityIndicator startAnimating];
                                  }
                              }
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 [activityIndicator removeFromSuperview];
                                 activityIndicator = nil;
                             }];
        
        //NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [news valueForKey:@"image"]]];
        //[img setImage:[UIImage imageWithData: imageData]];
        img.userInteractionEnabled = YES;
        img.contentMode = UIViewContentModeScaleAspectFill;
        [img setClipsToBounds:YES];
        
        if (count ==1) {
            [img setFrame:CGRectMake(x, y, self.view.frame.size.width, 200)];
            [img setBounds:CGRectMake(0, 0, self.view.frame.size.width, 200)];
            y= y+200;
            count++;
        }else if (count ==2){
            [img setFrame:CGRectMake(x, y, 150, 280)];
            [img setBounds:CGRectMake(0, 0, 150, 280)];
            x= x+150;
            count++;
        }else if (count ==3){
            [img setFrame:CGRectMake(x, y, 170, 140)];
            [img setBounds:CGRectMake(0, 0, 170, 140)];
            y= y + 140;
            count++;
        }else if (count ==4){
            [img setFrame:CGRectMake(x, y, 170, 140)];
            [img setBounds:CGRectMake(0, 0, 170, 140)];
            count=1;
            y= y + 140;
            x=0;
        }
        
        UILabel *title = [[UILabel alloc] init];
        [title setFrame:CGRectMake(img.frame.origin.x+5, img.frame.origin.y+img.frame.size.height-60, img.frame.size.width-5, 60)];
        [title setText:[news valueForKey:@"title"]];
        [title setTextColor:[UIColor whiteColor]];
        [title setNumberOfLines:4];
        [title setLineBreakMode:NSLineBreakByWordWrapping];
        [title setFont:[UIFont fontWithName:@"Avenir Next Medium" size:13]];
        
        UILabel *description = [[UILabel alloc] init];
        [description setFrame:CGRectMake(img.frame.origin.x, img.frame.origin.y+img.frame.size.height-30, img.frame.size.width, 30)];
        [description setText:[news valueForKey:@"description"]];
        [description setTextColor:[UIColor whiteColor]];
        [description setNumberOfLines:2];
        [description setLineBreakMode:NSLineBreakByWordWrapping];
        [description setFont:[UIFont fontWithName:@"Avenir Next Medium" size:10]];
        
        UIView *bg = [[UIView alloc] init];
        [bg setFrame:CGRectMake(img.frame.origin.x, img.frame.origin.y+img.frame.size.height-60, img.frame.size.width, 60)];
        bg.alpha = 0.5;
        [bg setBackgroundColor:[UIColor blackColor]];
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        img.tag = [self addToUrlArray:[news valueForKey:@"url"]];
        
        [img addGestureRecognizer:singleFingerTap];
        
        [_scrollBase addSubview:img];
        [_scrollBase addSubview:bg];
        [_scrollBase addSubview:title];
        //[_scrollBase addSubview:description];
    }
    
    [_scrollBase setContentSize:CGSizeMake(self.view.frame.size.width, scroll.contentSize.height+(_array_news.count*140))];
}

//
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    NSString *urlString = [_array_url objectAtIndex:recognizer.view.tag];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog([_array_url objectAtIndex:recognizer.view.tag]);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    ArticleVC *avc = [[ArticleVC alloc] init];
    avc.request = urlRequest;
    avc.parentNavigationController = self.parentNavigationController;
    [self.parentNavigationController pushViewController:avc animated:YES];
}

- (void)cleanup{
    [_array_url removeAllObjects];
    [_array_news removeAllObjects];
    
    for (id view in _scrollBase.subviews ) {
        [view removeFromSuperview];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[self cleanup];
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

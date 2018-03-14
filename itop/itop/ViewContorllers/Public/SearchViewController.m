//
//  SearchViewController.m
//  itop
//
//  Created by huangli on 2018/3/9.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>

@property(nonatomic,strong)UISearchBar * searchBar;
@property (strong, nonatomic) YZTagList *tagList;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}


-(void)setupSearchBar{


    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0,8,ScreenWidth-100,28)]; //分配titleView
    //    UIColor * color = self.navigationController.navigationBar.tintColor;
    [titleView setBackgroundColor:[UIColor whiteColor]];
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.frame = CGRectMake(0,0,ScreenWidth-100,28);
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.layer.cornerRadius = 14;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.placeholder = @"搜索感兴趣的H5/设计师/热点";
    [titleView addSubview:_searchBar];
    
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    
    if (searchField) {
        
        [searchField setBackgroundColor:RGB(250, 250, 250)];
        
        searchField.layer.cornerRadius = 14.0f;
        
        searchField.layer.borderColor = [UIColor clearColor].CGColor;
        
        searchField.layer.borderWidth = 1;
        
        searchField.layer.masksToBounds = YES;
        [searchField setValue:UIColorFromRGB(0x9b9fa8) forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    }
    //设置为titleView
    self.navigationItem.titleView = titleView;

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigafindHairlineImageView:YES];
}

-(void)initView{
    
    [super initView];
    [self setupSearchBar];
    [self loadSearchList];
    
}

-(void)initNavigationBarItems{
    
    [self setRightBarItemString:@"搜索" action:@selector(search)];
}

-(void)search{

    NSDictionary *dic = (NSDictionary *)[[Global sharedSingleton]getUserDefaultsWithKey:SEARCH_LIST];
    NSString *currentDate = [self getNowTimeTimestamp];
    NSMutableDictionary *mutable = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutable setObject:currentDate forKey:_searchBar.text];
    [[Global sharedSingleton]setUserDefaultsWithKey:SEARCH_LIST andValue:mutable];
    
    NSMutableArray *key = [NSMutableArray array];
    [key addObjectsFromArray:[mutable allKeys]];
    for (int i = 0; i<key.count; i++) {
        
        for (int j = 0; j<key.count-1; j++) {
            
            
            if ([mutable[key[j]] integerValue] < [mutable[key[j+1]] integerValue] ) {
                
                NSString *temp = key[j];
                key[j] = key[j+1];
                key[j+1] = temp;
            }
        }
    }
    [self addkeywordsViewWithkeywords:key];
    NSLog(@"%@",_searchBar.text);
}

-(void)loadSearchList{
    
    NSDictionary *dic = (NSDictionary *)[[Global sharedSingleton]getUserDefaultsWithKey:SEARCH_LIST];
    NSMutableArray *key = [NSMutableArray array];
    if (dic != nil) {
        
        [key addObjectsFromArray:[dic allKeys]];
        for (int i = 0; i<key.count; i++) {
            
            for (int j = 0; j<key.count-1; j++) {
                
                
                if ([dic[key[j]] integerValue] < [dic[key[j+1]] integerValue] ) {
                    
                    NSString *temp = key[j];
                    key[j] = key[j+1];
                    key[j+1] = temp;
                }
            }
        }
        //TODO
    }
    [self addkeywordsViewWithkeywords:key];

}


-(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}


-(void)addkeywordsViewWithkeywords:(NSArray *)keywords{
    
    // 高度可以设置为0，会自动跟随标题计算
    _tagList = [[YZTagList alloc] initWithFrame:CGRectMake(60, 46, ScreenWidth-120, 0)];
    _tagList.backgroundColor = [UIColor whiteColor];
    _tagList.tagCornerRadius = 3;
    _tagList.borderWidth = 0;
    _tagList.tagFont =  [UIFont systemFontOfSize:15] ;
    _tagList.tagBackgroundColor =  UIColorFromRGB(0xeeeeee);
    // 设置标签背景色
    _tagList.tagColor = [UIColor blackColor];
    [_tagList addSearchListTag: keywords action:@selector(searchListTag:)];
    [self.view addSubview:_tagList];
    _tagList.searchListTagBlock = ^ (NSString *tag){

        NSLog(@"%@",tag);
    };
}


@end

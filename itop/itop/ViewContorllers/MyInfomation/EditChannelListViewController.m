//
//  EditChannelListViewController.m
//  itop
//
//  Created by huangli on 2018/5/4.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "EditChannelListViewController.h"
#import "EditChannelListTCell.h"
#import "EditChannelListDataSource.h"


static NSString *const EditChannelListCellIdentifier = @"EditChannelList";

@interface EditChannelListViewController ()

@property (strong, nonatomic)EditChannelListDataSource *editChannelListDataSource;

@property (strong, nonatomic) IBOutlet UIView *fooderView;
@property (weak, nonatomic) IBOutlet UIButton *addChannelButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation EditChannelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initNavigationBarItems{
    
    self.title = @"编辑渠道";
}

-(void)initView{
    
    [super initView];
   
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ViewHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.top.mas_equalTo(self.view);
    }];
    [self steupTableView];
    
    self.tableView.tableFooterView = _fooderView;
    [self setupViews];
}

-(void)setupViews{
    
    _addChannelButton.frame = CGRectMake(100, 42, ScreenWidth-120, 30);
    _addChannelButton.layer.masksToBounds = YES;
    _addChannelButton.layer.cornerRadius = 5;
    [_addChannelButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_addChannelButton)];
    
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = _submitButton.frame.size.height/2;
    [_submitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton)];
    
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(EditChannelListTCell *cell , ChannelList *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item index:indexPath.row];
        cell.inputConfigureBlock = ^( EditChannelListTCell *cell1 ,UITextField * textField){

//            NSLog(@"%@",inputText);
            NSIndexPath *index = [self.tableView indexPathForCell:cell1];
            ChannelList *channel = [_editChannelListDataSource itemAtIndexPath:index];
            if (textField.tag == 1) {
                
                channel.name = textField.text;
            } else if(textField.tag == 2){
               
                channel.fans_count = textField.text;
            } else {
                
                channel.index_url = textField.text;
            }
            
        };
        
    };
    self.editChannelListDataSource = [[EditChannelListDataSource alloc]initWithItems:self.dataArray cellIdentifier:EditChannelListCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.editChannelListDataSource
                        cellIdentifier:EditChannelListCellIdentifier
                               nibName:@"EditChannelListTCell"];
    
    self.tableView.dataSource = self.editChannelListDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"EditChannelListTCell"] forCellReuseIdentifier:EditChannelListCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 169;
}

- (IBAction)addChannel:(UIButton *)sender {
    
    if (self.dataArray.count < 3) {
        
        ChannelList *channel = [[ChannelList alloc]init];
        [self.dataArray addObject:channel];
        [self.tableView reloadData];
    } else {
        
        [self showToastWithMessage:@"最多添加3条"];
    }
}

- (IBAction)submit:(UIButton *)sender {
  
    for (ChannelList *channel in self.dataArray) {
        
        if ([Global stringIsNullWithString:channel.name] ||[Global stringIsNullWithString:channel.fans_count] || [Global stringIsNullWithString:channel.index_url]) {
            
            [self showToastWithMessage:@"请完善渠道信息"];
            
            return ;
        }
    }

    if (_editChannelListBlock) {
        _editChannelListBlock(self.dataArray);
        [self back];
    }
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

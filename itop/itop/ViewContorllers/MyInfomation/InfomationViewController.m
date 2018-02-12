//
//  InfomationViewController.m
//  itop
//
//  Created by huangli on 2018/2/7.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "InfomationViewController.h"
#import "InfomationDataSource.h"
#import "InfomationStore.h"
#import "InfomationTableViewCell.h"
#import "AlertView.h"

static NSString *const InfomationCellIdentifier = @"LeaveDetail";

@interface InfomationViewController ()<UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong)InfomationDataSource *infomationDataSource;
@property (nonatomic, strong)UIPickerView *pickView;
@property (nonatomic, strong)NSMutableArray *provinceArray; // 省份
@property (nonatomic, strong)NSMutableArray *cityArray;//城市
@property (nonatomic, strong)NSMutableArray *ageArray; //年龄
@property (nonatomic, strong)NSArray *sexArray; //性别
@property (nonatomic, strong)Province *province; //选择省份
@property (nonatomic, strong)Province *city; //选择的城市
@property (nonatomic, strong)NSString *selectSex; //选择的性别
@property (nonatomic, strong)NSString *selectAge; //选择的年龄
@property (nonatomic, strong)Infomation *editorItem; //选择弹窗的itme
@property (nonatomic, strong)UITextField *inputNameTF; //选择类型
@property (nonatomic, assign)PickViewType pickViewType; //选择类型

@end

@implementation InfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city-picker.data" ofType:@"json"]];
    NSDictionary *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",dataArray);
    NSDictionary *dic = dataArray[@"86"];
    NSMutableArray *tempProvinceArray = [NSMutableArray array];
    [tempProvinceArray addObjectsFromArray:(NSArray *)dic[@"A-G"]];
    [tempProvinceArray addObjectsFromArray:(NSArray *)dic[@"H-K"]];
    [tempProvinceArray addObjectsFromArray:(NSArray *)dic[@"L-S"]];
    [tempProvinceArray addObjectsFromArray:(NSArray *)dic[@"T-Z"]];
    
     _provinceArray = [NSMutableArray array];
    _cityArray = [NSMutableArray array];
    for (NSDictionary *dic in tempProvinceArray) {
        
        Province *province = [[Province alloc]initWithDictionary:dic error:nil];
        NSDictionary *cityDic = dataArray[province.code];
        NSMutableArray *tmpeCityArray = [NSMutableArray array];
        NSArray *key = [cityDic allKeys];
        for (NSString *cityCode in key) {
            
            Province *city = [[Province alloc]init];
            city.code = cityCode;
            city.address = cityDic[cityCode];
            [tmpeCityArray addObject:city];
        }
        province.cityArray = tmpeCityArray;
        [_provinceArray addObject:province];
    }
    Province *province = _provinceArray[0];
    [_cityArray addObjectsFromArray:province.cityArray];
}

-(void)initNavigationBarItems{
    
    self.title = @"个人信息";
    [self setRightBarItemString:@"确认" action:@selector(submitInfomation)];
    self.navigationItem.rightBarButtonItem.tintColor = RGB(232, 98, 159);
}

-(void)initView{
    
    NSLog(@"%f",self.view.frame.size.height);
    [super initView];
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ViewHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.top.mas_equalTo(self.view);
    }];
    [self steupTableView];
}

-(void)initData{
    
    [[UserManager shareUserManager] userInfomation];
    [UserManager shareUserManager].userInfoSuccess = ^(id obj){
       
        InfomationModel *info = [[InfomationModel alloc]initWithDictionary:obj
                                                                     error:nil];
        self.dataArray = [[InfomationStore shearInfomationStore]configurationMenuWithInfo:info];
        [self setupSelectItmeWith:info];
        [self steupTableView];
        NSLog(@"%@",obj);
    };

    _sexArray = @[@"男",@"女"];
    self.ageArray = [NSMutableArray array];
    for (int i = 0; i<101; i ++) {
        
        [_ageArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
}

-(void)setupSelectItmeWith:(InfomationModel *)info{
    
    if (![Global stringIsNullWithString:info.user_info.province]) {
        
        for (Province *province in _provinceArray) {
            
            if ([province.address isEqualToString:info.user_info.province]) {
                _province = province;
                [self.cityArray removeAllObjects];
                [self.cityArray addObjectsFromArray:province.cityArray];
            }
        }
    }
    
    if (![Global stringIsNullWithString:info.user_info.city]) {
        
        for (Province *city in _cityArray) {
            
            if ([city.address isEqualToString:info.user_info.city]) {
                _city = city;
            }
        }
        
    }
    if (![Global stringIsNullWithString:info.user_info.sex]) {
        
//        NSInteger index = [info.user_info.sex integerValue];
        _selectSex = [[InfomationStore shearInfomationStore]sexWithIndex:info.user_info.sex] ;
    }
    
    if (![Global stringIsNullWithString:info.user_info.age]) {
        
        _selectAge = info.user_info.age;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hiddenNavigationController:NO];
    [self hiddenNavigafindHairlineImageView:YES];
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark 重新加载数据时将有数据的itme赋给已选择的temp
-(void)initPickViewWith:(PickViewType)pickView{
    
    if (_pickViewType == PickViewTypeSex) {
      
         self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 60)];
        
    } else {
         self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 120)];
    }
   
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    self.pickView.showsSelectionIndicator = YES;
    [self.pickView reloadAllComponents];
    Infomation *info = self.dataArray[pickView];
    NSInteger index ;
    if (info != nil) {
        
        switch (pickView) {
            case PickViewTypeAge:
                
                index = [self.ageArray indexOfObject:info.content];
                [self.pickView selectRow:index inComponent:0 animated:NO];
                break;
            case PickViewTypeSex:
                
                index = [[InfomationStore shearInfomationStore] indexWithSex:info.content];
                if (index > 0) {
                    
                    index = index-1;
                }
                [self.pickView selectRow:index inComponent:0 animated:NO];
                break;
            case PickViewTypeProvince:
                
                [self positioningwithindex:info];
                break;
                
            default:
                break;
        }
    }
}

#pragma mark 选择数据时将有数据的itme赋给已选择的temp
-(void)positioningwithindex:(Infomation *)info{
    
    NSArray *arr = [info.content componentsSeparatedByString:@","];
    NSInteger index = 0 ;
    NSInteger inde2 = 0 ;
    for (Province *province in self.provinceArray ) {
        
        if ([province.address isEqualToString:arr[0]]) {
            
            index = [self.provinceArray indexOfObject:province];
            [self.cityArray removeAllObjects];
            [self.cityArray addObjectsFromArray:province.cityArray];
        }
    }
    [self.pickView selectRow:index inComponent:0 animated:NO];

    if (arr.count > 1) {
        
        for (Province *province in self.cityArray ) {
            
            if ([province.address isEqualToString:arr[1]]) {
                
                inde2 = [self.cityArray indexOfObject:province];
            }
        }
        [self.pickView selectRow:inde2 inComponent:1 animated:NO];
    }
}

-(void)initInputNameTFWithPlaceholder:(NSString *)placeholder{
    
    self.inputNameTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth-160, 30)];
    self.inputNameTF.placeholder = placeholder;
    _inputNameTF.textAlignment = UITextAlignmentCenter;
    _inputNameTF.font = [UIFont systemFontOfSize:15];
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(InfomationTableViewCell *cell , Infomation *item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item row:indexPath.row ];
        
    };
    self.infomationDataSource = [[InfomationDataSource alloc]initWithItems:self.dataArray cellIdentifier:InfomationCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.infomationDataSource
                        cellIdentifier:InfomationCellIdentifier
                               nibName:@"InfomationTableViewCell"];
    
    self.tableView.dataSource = self.infomationDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"InfomationTableViewCell"] forCellReuseIdentifier:InfomationCellIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 71;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];

    if (indexPath.row > 1) {
        
        _editorItem = [_infomationDataSource itemAtIndexPath:indexPath];
        [self showAlertViewWithItem:indexPath.row];
    }
}

-(void)showAlertViewWithItem:(NSInteger)row{
    
    _pickViewType = row;
    UIView *view = [[UIView alloc] init];
    NSString *string ;
    if (_pickViewType <= PickViewTypeName) {
        
        string  = [NSString stringWithFormat:@"请输入%@",_editorItem.title];
        [self initInputNameTFWithPlaceholder:string];
        view.frame = self.inputNameTF.frame;
        [view addSubview:self.inputNameTF];
    }else {
        [self initPickViewWith:row];
        view.frame = self.pickView.frame;
        [view addSubview:self.pickView];
        string  = [NSString stringWithFormat:@"请选择%@",_editorItem.title];
    }
    
    AlertView *alertView = [[AlertView alloc]initWithTitle:string
                                                   message:view
                                                   sureBtn:@"确定"
                                                 cancleBtn:@"取消"
                                              pickViewType:row];
    alertView.resultIndex = ^(NSInteger index ,PickViewType picViewType){
        
        if (index == 2) {
            
             [self updataInfomationWithUpdataItem:picViewType];
//            NSLog(@"取消选项");
        }
    };
    [alertView showXLAlertView];
}

#pragma mark 数据源 Method numberOfComponentsInPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return _pickViewType == PickViewTypeProvince ? 2 : 1;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lbl = (UILabel *)view;
    
    if (lbl == nil) {
        
        lbl = [[UILabel alloc]init];
        //在这里设置字体相关属性
        lbl.adjustsFontSizeToFitWidth = YES;
        lbl.font = [UIFont systemFontOfSize:15];
        lbl.textColor = [UIColor blackColor];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setBackgroundColor:[UIColor clearColor]];
    }
    //重新加载lbl的文字内容
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return lbl;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0){ //省
        if (_pickViewType == PickViewTypeProvince) {
            
            return self.provinceArray.count;
        } else if (_pickViewType == PickViewTypeSex){
            return self.sexArray.count;
        } else{
            return self.ageArray.count;
        }
    }else{
        //市
        return _cityArray.count;
    }
}

#pragma mark delegate 显示信息的方法

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component==0){
    
        if (_pickViewType == PickViewTypeProvince) {
            
            Province *province = self.provinceArray[row];
            _province = province;
            return province.address;
            
        } else if (_pickViewType == PickViewTypeSex){
            
            _selectSex = [[InfomationStore shearInfomationStore]sexArray][row+1];
            return [[InfomationStore shearInfomationStore]sexArray][row+1];
            
        } else{
            _selectAge = self.ageArray[row];
            return self.ageArray[row];
        }
        //选择的省份
        
    }else{
        
        Province *city = self.cityArray[row];
        _city = city;
        return city.address;//省份对应的市区
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==0){
    
        if (_pickViewType == PickViewTypeProvince) {
            _province = self.provinceArray[row];
            [self.cityArray removeAllObjects];
            [self.cityArray addObjectsFromArray:_province.cityArray];
            [self.pickView reloadComponent:1];
            
        } else if (_pickViewType == PickViewTypeSex){
            
           _selectSex = [[InfomationStore shearInfomationStore]sexArray][row+1];
            
        } else{
            
            _selectAge = self.ageArray[row];
        }

    }else{
        _city = self.cityArray[row];

    }
}

-(void)updataInfomationWithUpdataItem:(PickViewType )pickViewType{
    
    Infomation *info = self.dataArray[pickViewType];
    
    switch (pickViewType) {
        case PickViewTypeProvince:
            info.content = [NSString stringWithFormat:@"%@,%@",_province.address,_city.address];
            break;
        case PickViewTypeSex:
            info.content = [NSString stringWithFormat:@"%@",_selectSex];
            break;
        case PickViewTypeName :
            
            info.content = [NSString stringWithFormat:@"%@",_inputNameTF.text];
            break;
        case PickViewTypeNickName:
            
            info.content = [NSString stringWithFormat:@"%@",_inputNameTF.text];
            break;
        case PickViewTypeAge:
            info.content = [NSString stringWithFormat:@"%@",_selectAge];
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}

-(void)submitInfomation{
 
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (Infomation *info in self.dataArray) {
        
        if ([Global stringIsNullWithString:info.content] && [info.title isEqualToString:@"年龄"]) {
            
            [[Global sharedSingleton]showToastInTop:self.view withMessage:@"年龄不能为空"];
            return;
            
        }else {
            
            if ([info.title isEqualToString:@"性别"]) {
                
                [dic setObject:@([[InfomationStore shearInfomationStore]indexWithSex:_selectSex]) forKey:info.sendKey];
            } else if([info.title isEqualToString:@"所在城市"]) {
                
                [dic setObject:_province.address forKey:@"Province"];
                [dic setObject:_city.address forKey:@"City"];
            }else if(![info.title isEqualToString:@"头像"] && ![Global stringIsNullWithString:info.content]){
                
                [dic setObject:info.content forKey:info.sendKey];
            }
        }
    }

    [[UserManager shareUserManager]updataInfoWithKeyValue:dic];
    [UserManager shareUserManager].updataInfoSuccess = ^(id obj){

        [self AlertOperation];
    };
}

-(void)AlertOperation{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改个人信息成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续修改" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self back];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

@end

//
//  HotBusinessCircleController.m
//  itop
//
//  Created by huangli on 2018/3/22.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "HotBusinessCircleController.h"
#import "SearchTableViewCell.h"
#import "SearchLocationStore.h"
#import "SearchLocationDataSource.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "CompanySigningStore.h"

#define CLLocationDegrees 0.01f

static NSString *const SearchLocationCellIdentifier = @"SearchLocation";

@interface HotBusinessCircleController ()<UITextFieldDelegate,BMKSuggestionSearchDelegate,BMKMapViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,BMKLocationServiceDelegate>{
    
    BMKSuggestionSearchOption *option;
    BMKSuggestionSearch * searcher;
    BMKPointAnnotation *pointAnnotation;
    BMKLocationService* _locService;
}
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
//@property (strong, nonatomic) BMKLocationService* locService;;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *placeButton;
@property (weak, nonatomic) IBOutlet UIButton *provinceButton;
@property (weak, nonatomic) IBOutlet UIButton *spaceButton;
@property (nonatomic,strong)UITextField * searchBar;
@property(nonatomic,strong)SearchLocationDataSource * searchLocationDataSource;

@property (nonatomic, strong)UIPickerView *pickView;
@property (nonatomic, strong)NSArray *provinceArray; // 省份
@property (nonatomic, strong)NSArray *cityArray;//城市
@property (nonatomic, strong)NSArray *scopeArray; //范围
@property (nonatomic, strong)Province *province; //选择省份
@property (nonatomic, strong)Province *city; //选择的城市
@property (nonatomic, copy)NSString *selectScope; //选择的 范围

@property (assign, nonatomic) PickViewType pickViewType;
@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) SearchLocation *search; //搜索的地点
@property (strong, nonatomic) BMKCircle* circle; //选择的范围

@end

@implementation HotBusinessCircleController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.distanceFilter = 10;
    //设置定位精度
    _locService.desiredAccuracy = kCLLocationAccuracyBest;
    //开启定位服务
    [_locService startUserLocationService];
    _mapView.showsUserLocation = YES;

}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    searcher.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    
}

-(void)viewWillDisappear:(BOOL)animated {
   
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    searcher.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}


-(void)initView{
    
    [super initView];
    _placeButton.layer.borderWidth = 1;
    _placeButton.layer.masksToBounds = YES;
    _placeButton.layer.cornerRadius = 5;
    _placeButton.layer.borderColor = UIColorFromRGB(0xF3F5F8).CGColor;
    
    NSLog(@"%f",_placeButton.width);
    CGRect frame = CGRectMake(ScreenWidth-125-40, 0, 40, _placeButton.size.height);
    [_placeButton.layer addSublayer:[UIColor setLocalGradualChangingColor:frame fromColor:@"FFA5EC" toColor:@"B499F8"]];
    
    _provinceButton.layer.borderWidth = 1;
    _provinceButton.layer.masksToBounds = YES;
    _provinceButton.layer.cornerRadius = 5;
    _provinceButton.layer.borderColor = UIColorFromRGB(0xF3F5F8).CGColor;
    
    _spaceButton.layer.borderWidth = 1;
    _spaceButton.layer.masksToBounds = YES;
    _spaceButton.layer.cornerRadius = 5;
    _spaceButton.layer.borderColor = UIColorFromRGB(0xF3F5F8).CGColor;
    
    [_submitButton.layer addSublayer:DEFULT_BUTTON_CAGRADIENTLAYER(_submitButton)];
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = _submitButton.height/2;
    
    
    [self initTableViewWithFrame:TableViewFrame(0, 0, ScreenWidth, ViewHeigh)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.bottom.top.mas_equalTo(self.view);
    }];
    self.tableView.hidden  = YES;
    
}

-(void)initData{
    
    [super initData];
    _provinceArray = [[CompanySigningStore shearCompanySigningStore]provinceArray];
    Province *province = _provinceArray[0];
    _cityArray = province.cityArray;
    _scopeArray = [[SearchLocationStore shearaSearchLocationStore]scopeArray];
}

-(void)initNavigationBarItems{
    
    self.title = @"商圈设置";
}

-(void)showAlertViewWithItem:(UIButton*)button{
    
    _pickViewType = button.tag;
    UIView *view = [[UIView alloc] init];
    NSString *string ;
    
    [self initPickViewWith:button.tag];
    view.frame = self.pickView.frame;
    [view addSubview:self.pickView];
    string  = _pickViewType == PickViewTypeProvince ? @"请选择地区" : @"请选择范围";
    
     __weak typeof(self) weakSelf = self;
    AlertView *alertView = [[AlertView alloc]initWithTitle:string
                                                   message:view
                                                   sureBtn:@"确定"
                                                 cancleBtn:@"取消"
                                              pickViewType:button.tag
                                                superArray:nil
                                                  subArray:nil];
//    alertView.resultIndex = ^(NSInteger index ,PickViewType picViewType){
//
//
//        if (picViewType == PickViewTypeProvince) {
//
//            [_provinceButton setTitle:[NSString stringWithFormat:@"%@,%@",weakSelf.province.address,weakSelf.city.address] forState:UIControlStateNormal];
//        } else {
//
//            [_spaceButton setTitle:weakSelf.selectScope forState:UIControlStateNormal];
//            NSInteger index = [[SearchLocationStore shearaSearchLocationStore]scopeArrayWithObj:_selectScope];
//            NSString *scope = [[[SearchLocationStore shearaSearchLocationStore]scopeValueArray] objectAtIndex:index];
//
//            [self setSearchRegionTagScopeWithScope:[scope doubleValue]];
//        }
//    };
    
    [alertView showXLAlertView];
}


-(void)initPickViewWith:(PickViewType)pickViewType{
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, 120)];
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    self.pickView.showsSelectionIndicator = YES;
    [self.pickView reloadAllComponents];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (pickViewType == PickViewTypeProvince) {
        
        button = _provinceButton;
    } else {
        
        button = _spaceButton;
    }
    NSInteger index ;
    if (button.titleLabel.text != nil  && ![button.titleLabel.text isEqualToString:@"请选择地区"] && ![button.titleLabel.text isEqualToString:@"请选择范围"]) {
        
        switch (pickViewType) {
            case PickViewTypeProvince:
                
                [self positioningwithindex:button.titleLabel.text];
                break;
                
            case PickViewTypeScope:
                
                index = [[[SearchLocationStore shearaSearchLocationStore] scopeArray ] indexOfObject:button.titleLabel.text];
                [self.pickView selectRow:index inComponent:0 animated:NO];
                break;
            default:
                break;
        }
    }
}

#pragma mark 选择数据时将有数据的itme赋给已选择的temp
-(void)positioningwithindex:(NSString *)info{
    
    NSArray *arr = [info componentsSeparatedByString:@","];
    NSInteger index = 0 ;
    NSInteger inde2 = 0 ;
    for (Province *province in self.provinceArray ) {
        
        if ([province.address isEqualToString:arr[0]]) {
            
            index = [self.provinceArray indexOfObject:province];
            self.cityArray = province.cityArray;
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

#pragma mark 数据源 Method numberOfComponentsInPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return _pickViewType == PickViewTypeScope ? 1 : 2;
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
            
        } else{
            return self.scopeArray.count;
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
            if (row == 0) {
               
                _province = province;
            }
            return province.address;
            
        } else{
    
            if (row == 0) {
               
                 _selectScope = self.scopeArray[row];
            }
           
            return self.scopeArray[row];
        }
    }else{
        
        Province *city = self.cityArray[row];
        if (row == 0) {
            
            _city = city;

        }
        return city.address;//省份对应的市区
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==0){
        
        if (_pickViewType == PickViewTypeProvince) {
            _province = self.provinceArray[row];
            self.cityArray =_province.cityArray;
            [self.pickView reloadComponent:1];
            
        } else{
            self.selectScope = self.scopeArray[row];
            
        }
    }else{
        
        _city = self.cityArray[row];
        
    }
}

- (IBAction)selectType:(UIButton *)sender {
    
    if (sender.tag == 1) {
        
        if ([_provinceButton.titleLabel.text isEqualToString:@"请选择城市"]) {
            
            [self showToastWithMessage:@"请选择城市"];
            return;
        }
        
        [self setupSearchBarWithHidden:NO];
    }else if (sender.tag == 9){
        
        if ([_placeButton.titleLabel.text isEqualToString:@"请输入地点"]) {
            
            [self showToastWithMessage:@"请输入地点"];
            return;
        }
        
        [self showAlertViewWithItem:sender];

    }else {
        
        [self showAlertViewWithItem:sender];
    }
}

- (IBAction)submit:(UIButton *)sender {
    
//    [_locService startUserLocationService];
}

- (void)steupTableView{
    
    TableViewCellConfigureBlock congfigureCell = ^(SearchTableViewCell *cell ,  SearchLocation*item , NSIndexPath *indexPath){
        
        [cell setItmeOfModel:item searchKey:_searchBar.text];
        
    };
    self.searchLocationDataSource = [[SearchLocationDataSource alloc]initWithItems:self.dataArray cellIdentifier:SearchLocationCellIdentifier cellConfigureBlock:congfigureCell];
    
    [self steupTableViewWithDataSource:self.searchLocationDataSource
                        cellIdentifier:SearchLocationCellIdentifier
                               nibName:@"SearchTableViewCell"];
    
    self.tableView.dataSource = self.searchLocationDataSource;
    [self.tableView registerNib:[[UIManager sharedUIManager]nibWithNibName:@"SearchTableViewCell"] forCellReuseIdentifier:SearchLocationCellIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 71;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    self.tableView.hidden = YES;
    [self setupSearchBarWithHidden:YES];
    _search = [self.searchLocationDataSource itemAtIndexPath:indexPath];
    [_placeButton setTitle:_search.searchLocation forState:UIControlStateNormal];
    [self setSearchRegionTagScopeWithScope:1.0];
}

-(void)setupSearchBarWithHidden:(BOOL)animation{
    
    if (_titleView == nil) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0,2,ScreenWidth-80,40)]; //分配
        [_titleView setBackgroundColor:[UIColor whiteColor]];
        _searchBar = [[UITextField alloc] init];
        _searchBar.delegate = self;
        _searchBar.frame = CGRectMake(-10,0,ScreenWidth-80,40);
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.layer.cornerRadius = 5;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.placeholder = @"搜索位置";
        _searchBar.layer.borderWidth = 1;
        _searchBar.layer.borderColor = UIColorFromRGB(0xF3F5F8).CGColor;
        
         CGRect frame = CGRectMake( _searchBar.size.width-40, 0,40, _searchBar.size.height);
        [_searchBar.layer addSublayer:[UIColor setLocalGradualChangingColor:frame fromColor:@"FFA5EC" toColor:@"B499F8"]];
        
        _searchButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_searchBar.frame)-30, 0, 40, 40)];
        [_searchButton setImage:[UIImage imageNamed:@"home_icon_searchwhite"] forState:UIControlStateNormal];
        [_searchButton setTintColor:[UIColor clearColor]];
        _searchButton.backgroundColor = [UIColor clearColor];
        [_searchBar addSubview:_searchButton];
        [_titleView addSubview:_searchBar];
        self.navigationItem.titleView = _titleView;
        
        [_searchBar becomeFirstResponder];
    }
    
    _titleView.hidden = animation;
    self.tableView.hidden = animation;
    if (animation) {
        
        if (_titleLabel == nil) {
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 21)];
            _titleLabel.text = @"商圈设置";
            _titleLabel.textColor = UIColorFromRGB(0x434a5c);
        }
        self.navigationItem.titleView = _titleLabel;
        
    } else {
        
         self.navigationItem.titleView = _titleView;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.text.length == 1 && [string isEqualToString:@""]) {
        
        [self.dataArray removeAllObjects];
        [self steupTableView];
    } else {
        if (!searcher) {
            searcher = [BMKSuggestionSearch new];
            searcher.delegate = self;
        }
        option = [[BMKSuggestionSearchOption alloc] init];
        option.cityname = _city.address;
        option.keyword  = _searchBar.text;
        BOOL flag = [searcher suggestionSearch:option];
        if(flag)
        {
            NSLog(@"建议检索发送成功");
        }
        else
        {
            NSLog(@"建议检索发送失败");
        }
    }
    return YES;
}


#pragma mark - 在线建议查询代理
//实现Delegate处理回调结果
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {

        self.dataArray = [[SearchLocationStore shearaSearchLocationStore]
                          configurationSearchLocationMenuWithSearchSuggestionKey:result.keyList
                                                            searchSuggestionCity:result.cityList
                                                        searchSuggestionDistrict:result.districtList
                                                           laocationCoordinate2D:result.ptList];
        [self steupTableView];

    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

-(void)back{
    
    if (self.tableView.hidden == NO) {
        
        [self setupSearchBarWithHidden:YES];
        
    } else {
        
        [super back];
    }
}

- (void)didFailToLocateUserWithError:(NSError *)error{
    
    [self showToastWithError:error];
}

-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;
    CLLocationCoordinate2D loc = [userLocation.location coordinate];
    //放大地图到自身的经纬度位置。
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(loc, BMKCoordinateSpanMake(CLLocationDegrees,CLLocationDegrees));
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKCircle class]]){
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [UIColorFromRGB(0xFFA5EC)  colorWithAlphaComponent:0.5];
        circleView.strokeColor = [UIColorFromRGB(0xB499F8) colorWithAlphaComponent:0.5];
        circleView.lineWidth = 2.0;
        
        return circleView;
    }
    return nil;
}

-(void)setSearchRegionTagScopeWithScope:(double )scope{
    
    CLLocationCoordinate2D loc ;
    loc.latitude = _search.latitude;
    loc.longitude = _search.longitude;
    
    if (pointAnnotation == nil) {
        
        pointAnnotation = [[BMKPointAnnotation alloc]init];
        [_mapView addAnnotation:pointAnnotation];
    }
    pointAnnotation.coordinate = loc;  //每次不同的gps坐标
    //    pointAnnotation.title = @"test";
    //    pointAnnotation.subtitle = @"此Annotation可拖拽!";
    
    //放大地图到自身的经纬度位置。
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(loc, BMKCoordinateSpanMake(CLLocationDegrees*1,CLLocationDegrees*1));
    if (scope != 1) {
        
        viewRegion = BMKCoordinateRegionMake(loc, BMKCoordinateSpanMake(CLLocationDegrees*(scope/1000*2),CLLocationDegrees*(scope/1000*2)));
    }
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
   
    if (scope != 1.0) {
       
        if (_circle != nil) {
            
            [_mapView removeOverlay:_circle];
        }
        _circle = [BMKCircle circleWithCenterCoordinate:loc radius:scope];
        [_mapView addOverlay:_circle];
    }
}

@end

//
//  YJWeatherViewController.m
//  YJ-微博
//
//  Created by MACBOOK on 16/1/12.
//  Copyright © 2016年 MACBOOK. All rights reserved.
//

#import "YJWeatherViewController.h"
#import "AFNetworking.h"
#import "YJCityWeather.h"
#import "MJExtension.h"

#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame       (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))

#define YJWeatherInfoFont [UIFont systemFontOfSize:16]

@interface YJWeatherViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
//view
@property (strong, nonatomic) IBOutlet UIButton *locationBtn;
@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;
@property (strong, nonatomic) IBOutlet UIView *pickerBgView;
@property (strong, nonatomic) UIView *maskView;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *nowWeather;

//@property (strong, nonatomic) IBOutlet UIButton *provinceBtn;
//@property (strong, nonatomic) IBOutlet UIButton *cityBtn;
//@property (strong, nonatomic) IBOutlet UIButton *townBtn;
//data
//地址字典
@property (strong, nonatomic) NSDictionary *pickerDic;
//省份
@property (strong, nonatomic) NSArray *provinceArray;
//城市
@property (strong, nonatomic) NSArray *cityArray;
//县、区
@property (strong, nonatomic) NSArray *townArray;
//选中的地址
@property (strong, nonatomic) NSArray *selectedArray;

//天气信息
@property (nonatomic,strong) YJCityWeather  *weather;

@end

@implementation YJWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupNav];
    
    [self getpickerData];
    
    [self initView];
    
    [self loadWeather:@"苏州市"];
    
}

-(void)setupNav{
    
    //设置右边不可点击
    self.navigationItem.rightBarButtonItem=nil;
    
    self.navigationItem.title=@"天气";
    
}

//初始化选择器
-(void)getpickerData{
    //加载地址数据
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    
    self.pickerDic=[[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray=[self.pickerDic allKeys];
    //默认选中第一个
    self.selectedArray=[self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
   
    //选中省份后，选中城市
    if (self.selectedArray.count>0) {
        self.cityArray=[[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    //选中城市，选中县
    if (self.cityArray.count>0) {
        self.townArray=[[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
}

-(void)initView{
    self.maskView=[[UIView alloc] initWithFrame:kScreen_Frame];
    self.maskView.backgroundColor=[UIColor blackColor];
    self.maskView.alpha=0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    
    self.pickerBgView.width=kScreen_Width;
    self.myPicker.delegate=self;
    
    //设置显示天气为多行
    self.nowWeather.numberOfLines=0;
    
}

#pragma mark - 显示、隐藏选择器
-(IBAction)showMyPicker:(id)sender{
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    self.maskView.alpha=0;
    self.pickerBgView.y=self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha=0.3;
        self.pickerBgView.bottom=self.view.height;
    }];
    
  
    
}


-(void)hideMyPicker{
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha=0;
        self.pickerBgView.y=self.view.height;
    }completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
    
}

#pragma  mark - 确认选择和取消选择

- (IBAction)cancel:(id)sender {
    [self hideMyPicker];
}

- (IBAction)confirmSelect:(id)sender {
    NSString *province=[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
    NSString *city=[self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]];
    NSString *town=[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]];
    
    
    self.addressLbl.text=[NSString stringWithFormat:@"%@ %@ %@",province,city,town];
    
    [self hideMyPicker];
    
    //加载选中的城市天气
    [self loadWeather:city];
}

#pragma mark - 加载天气数据

//加载天气信息
-(void)loadWeather:(NSString *)cityName{

    //首次加载应该默认一个城市
    if ([self.addressLbl.text isEqualToString:@""]) {
        self.addressLbl.text=cityName;
    }
    
    
    NSString *url= @"http://api.map.baidu.com/telematics/v3/weather";
    
    AFHTTPRequestOperationManager *manage=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parms=[NSMutableDictionary dictionary];
    parms[@"location"]=cityName;
    parms[@"output"]=@"json";
    parms[@"ak"]=@"CoP1iYnyODbGaox41N3IhV7D";
    
    [manage GET:url parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果多个城市，会有多条放入数组
        NSArray *weather=[YJCityWeather objectArrayWithKeyValuesArray:responseObject[@"results"]];
        
        [self showWeatherInfo:[weather firstObject]];
        //YJLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YJLog(@"error----%@",error);
        
        
    }];
    
    
}



-(void)showWeatherInfo:(YJCityWeather *)weather{
   
    /*
     "date": "周三(今天, 实时：24℃)",
     "dayPictureUrl": "http://api.map.baidu.com/images/weather/day/duoyun.png",
     "nightPictureUrl": "http://api.map.baidu.com/images/weather/night/duoyun.png",
     "weather": "多云",
     "wind": "微风",
     "temperature": "23℃~ 15℃"
     */
    
    NSArray *array=weather.weather_data;
    NSDictionary *nowW=[array firstObject];
    
    NSMutableString *str=[NSMutableString string];
    [str appendString:[NSString stringWithFormat:@"日期: %@\n\n",nowW[@"date"]]];
    [str appendString:[NSString stringWithFormat:@"天气: %@\n\n",nowW[@"weather"]]];
    [str appendString:[NSString stringWithFormat:@"风: %@\n\n",nowW[@"wind"]]];
    [str appendString:[NSString stringWithFormat:@"温度: %@\n\n",nowW[@"temperature"]]];

    //如果设置autolayout，则再设置frame无效
    //CGSize textSize=[self sizeWithText:str font:YJWeatherInfoFont maxW:300];
    //self.nowWeather.frame=CGRectMake(self.addressLbl.x, CGRectGetMaxY(self.addressLbl.frame)+120, textSize.width, textSize.height);
    
    self.nowWeather.text=str;
    
  
    YJLog(@"%@",NSStringFromCGRect(self.nowWeather.frame));
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    CGSize size=CGSizeMake(maxW, MAXFLOAT);
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[NSFontAttributeName]=font;
    
    return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark - uipickercontroller delegate
//返回列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
    
}

//返回每列的数目
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return self.provinceArray.count;
    }else if (component==1){
        return self.cityArray.count;
    }
    else {
        return self.townArray.count;
    }
    
    
}

//返回每列行的数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [self.provinceArray objectAtIndex:row];
    }else if (component==1){
        return [self.cityArray objectAtIndex:row];
    }
    else {
        return [self.townArray objectAtIndex:row];
    }
    
}

//返回每列宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component==0) {
        return 110;
    }else if (component==1){
        return 100;
    }
    else {
        return 110;
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==0) {
        self.selectedArray=[self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count>0) {
            self.cityArray=[[self.selectedArray objectAtIndex:0] allKeys];
        }else{
            self.cityArray=nil;
        }
        
        if (self.cityArray.count>0) {
            self.townArray=[[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        }else {
            self.townArray=nil;
            
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component==1) {
        if (self.selectedArray.count>0 && self.cityArray.count>0) {
            self.townArray=[[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        }else{
            self.townArray=nil;
            
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}

@end

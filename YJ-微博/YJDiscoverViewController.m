//
//  YJDiscoverViewController.m
//  YJ-微博
//
//  Created by MACBOOK on 15/12/21.
//  Copyright © 2015年 MACBOOK. All rights reserved.
//

#import "YJDiscoverViewController.h"
#import "YJSearchBar.h"
#import "YJMemorandumTool.h"
#import "YJMemorandumCell.h"
#import "YJMemorandumEditView.h"
#import "YJMemorandumAddView.h"

@interface YJDiscoverViewController ()  <UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *mainTableView;     //主界面表格
}

@property (nonatomic,strong) NSMutableArray  *modalArry;

@end

@implementation YJDiscoverViewController

-(NSMutableArray *)modalArry{
    if(_modalArry==nil){
        self.modalArry=[[NSMutableArray alloc] init];
    }
    return  _modalArry;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    //设置搜索框
    //[self setupSearchBar];

    [self setupNav];
    mainTableView=[[UITableView alloc] init];
    mainTableView.frame=[UIScreen mainScreen].bounds;
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
    
    [self.view addSubview:mainTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    //加载数据
    [self initData];
    
    
}

//初始化加载备忘录
-(void)initData{
   
    
    [self.modalArry removeAllObjects];
    NSArray *modals=[YJMemorandumTool queryModel:nil];
    
    //数组倒叙，最新的在最上面
    NSArray *tempArry=[[modals reverseObjectEnumerator] allObjects];
    [self.modalArry addObjectsFromArray:tempArry];
  
    [mainTableView reloadData];
    YJLog(@"%@",mainTableView.dataSource);
    
}

-(void)setupSearchBar{
    
    UITextField *text=[YJSearchBar searchBar];
    text.width=300;
    text.height=30;
    
    self.navigationItem.titleView=text;
    
    
    
}

-(void)setupNav{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(addNote)];
    
    self.navigationItem.title=@"备忘录";
    
}

-(void)addNote{
    YJMemorandumAddView *editView=[[YJMemorandumAddView alloc] init];
    [self.navigationController pushViewController:editView animated:YES];
    
    
}





#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [tableView tabeViewDisplayWithMsg:@"您还没有写备忘录..." ifNecessaryForRowCount:self.modalArry.count];
    return self.modalArry.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"cell";
    YJMemorandumCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[YJMemorandumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    [cell setNoteData:self.modalArry[indexPath.row]];
    
    return  cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    YJMemorandum *model=self.modalArry[indexPath.row];
    YJMemorandumEditView *editView=[[YJMemorandumEditView alloc] init];
    editView.model=model;
    [self.navigationController pushViewController:editView animated:YES];
    
}

#pragma cell编辑模式--------删除备忘录
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [YJMemorandumTool deleteModel:self.modalArry[indexPath.row]];
    }
    //刷新
    [self initData];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25 * kHeightRatio + 34.5;
}



@end

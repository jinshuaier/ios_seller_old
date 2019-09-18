//
//  TCSystemViewController.m
//  顺道嘉商家版
//
//  Created by Macx on 16/8/31.
//  Copyright © 2016年 北京同创共享网络科技有限公司. All rights reserved.
//

#import "TCSystemViewController.h"
#import "TCReviseViewController.h"
@interface TCSystemViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *systemTabel;
}
@property (nonatomic, strong) UISegmentedControl *startSeg;
@property (nonatomic, strong) NSString *index; //是否开启
@end

@implementation TCSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息提醒设置";
    self.view.backgroundColor = backGgray;
    
    //创建tableView
    [self cretaeSystemTabel];
    // Do any additional setup after loading the view.
}
//tableView
-(void)cretaeSystemTabel
{
    systemTabel = [[UITableView alloc]init];
    systemTabel.frame = CGRectMake(0, 0, WIDHT, 96 *HEIGHTSCALE);
    systemTabel.delegate = self;
    systemTabel.dataSource = self;
    systemTabel.tableFooterView = [[UIView alloc]init];
    systemTabel.scrollEnabled = NO;
    [self.view addSubview:systemTabel];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*HEIGHTSCALE;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        TCReviseViewController * reviseVC = [[TCReviseViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:reviseVC animated:YES];
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //定义个静态字符串为了防止与其他类的tableivew重复
    
    static NSString *CellIdentifier =@"Cell";
    
    //定义cell的复用性当处理大量数据时减少内存开销
    
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(12*WIDHTSCALE, (50 - 16)/2 *HEIGHTSCALE, WIDHT/2, 16*HEIGHTSCALE);
    label.textColor = FontColor;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:16*HEIGHTSCALE];
    [cell.contentView addSubview:label];
    
    if(indexPath.row == 0){
        label.text = @"修改密码";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }else{
        label.text = @"关闭提示声音";
        
        //是否启用店员
        NSArray *arr = @[@"开", @"关"];
        _startSeg = [[UISegmentedControl alloc]initWithItems:arr];
        _startSeg.frame = CGRectMake((WIDHT - 140/2 *WIDHTSCALE - 12 *WIDHTSCALE), (cell.frame.size.height - 25*HEIGHTSCALE)/2, 140/2 * WIDHTSCALE , 25 *HEIGHTSCALE);
        [_startSeg setTintColor:Color];
        //设置监听事件
        [_startSeg addTarget:self action:@selector(startseg:) forControlEvents:UIControlEventValueChanged];
        //修改字体
        UIFont *font = [UIFont boldSystemFontOfSize:14.0f  *HEIGHTSCALE];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                               forKey:NSFontAttributeName];
        [_startSeg setTitleTextAttributes:attributes
                                 forState:UIControlStateNormal];
        
        _startSeg.selectedSegmentIndex = [[ NSUserDefaults standardUserDefaults ] boolForKey:@"lights" ] ;
        
        [cell.contentView addSubview:_startSeg];
    }
    
    
    return cell;
    

}
#pragma mark -- 分段选择器
-(void)startseg:(UISegmentedControl *)sender
{
    BOOL isOn = [ [ NSUserDefaults standardUserDefaults ] boolForKey:@"lights" ] ;
    isOn = !isOn ; // toggle ;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:_startSeg.selectedSegmentIndex forKey:@"lights"];
    _startSeg.selectedSegmentIndex = isOn ;
    
    NSInteger index = sender.selectedSegmentIndex;
    if(index == 0){
       
        NSUserDefaults *defults_sound = [NSUserDefaults standardUserDefaults];
        [defults_sound setObject:@"open" forKey:@"open"];
        
        
    }else{
       
         NSLog(@"关闭了前台声音");
    }
}

//最后下划线顶格
- (void)viewDidLayoutSubviews{
    if ([systemTabel respondsToSelector:@selector(setSeparatorInset:)]) {
        [systemTabel setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([systemTabel respondsToSelector:@selector(setLayoutMargins:)]) {
        [systemTabel setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 1){
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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

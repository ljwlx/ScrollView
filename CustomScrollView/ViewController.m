//
//  ViewController.m
//  CustomScrollView
//
//  Created by wei on 2019/3/28.
//  Copyright © 2019年 wei. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView*tableView;
    NSArray*dataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dataSource = @[@"1.jpg",@"2.jpg",@"3.jpg"];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width-100, self.view.frame.size.height-200) style:UITableViewStylePlain];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator   = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.pagingEnabled = YES;
    [self.view addSubview:tableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count*2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* _id = @"cell";
    UITableViewCell*cell  = [tableView dequeueReusableCellWithIdentifier:_id];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_id];
        UIImageView*imgv = [[UIImageView alloc] initWithFrame:tableView.bounds];
        imgv.contentMode = UIViewContentModeScaleToFill;
        imgv.clipsToBounds = YES;
        imgv.tag = 1;
        [cell.contentView addSubview:imgv];
    }
    UIImageView*imgv = [cell.contentView viewWithTag:1];
    imgv.image  =[UIImage imageNamed:dataSource[indexPath.row%dataSource.count]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.frame.size.height;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y<=0){
        [tableView setContentOffset:CGPointMake(0, dataSource.count*tableView.frame.size.height)];
    }else if (scrollView.contentOffset.y>=tableView.frame.size.height*(dataSource.count*2-1)){
        [tableView setContentOffset:CGPointMake(0, (dataSource.count-1)*tableView.frame.size.height)];
    }
}
-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
   // [scrollView setContentOffset:scrollView.contentOffset animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

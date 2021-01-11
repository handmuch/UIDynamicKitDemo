//
//  ViewController.m
//  UIDynamicKitDemo
//
//  Created by 郭建华 on 2020/9/29.
//

#import "ViewController.h"
#import "BallsPoolViewController.h"
#import "imessageTableViewController.h"
#import "DynamicPlaceholderViewController.h"
#import "UIImageView+switchMethod.h"

static NSString *kDynamicKitDemoCellIndentifier = @"kDynamicKitDemoCellIndentifier";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *demoTitleList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UIDynamicKitDemo";
    self.demoTitleList = @[@"ballsPool", @"imessage", @"dynamicPlaceholder"];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoTitleList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDynamicKitDemoCellIndentifier
                                                            forIndexPath:indexPath];
    cell.textLabel.text = [self.demoTitleList objectAtIndex:indexPath.item];
    return cell;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BallsPoolViewController *ballsPoolViewController = [[BallsPoolViewController alloc]init];
        [self.navigationController pushViewController:ballsPoolViewController animated:YES];
    }
    if (indexPath.row == 1) {
        imessageTableViewController *imessageViewController = [[imessageTableViewController alloc] init];
        [self.navigationController pushViewController:imessageViewController animated:YES];
    }
    if (indexPath.row == 2) {
        DynamicPlaceholderViewController *dynamicPlaceholder = [[DynamicPlaceholderViewController alloc] init];
        [self.navigationController pushViewController:dynamicPlaceholder animated:YES];
    }
}

#pragma mark - lazyInit

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kDynamicKitDemoCellIndentifier];
    }
    return _tableView;
}

@end

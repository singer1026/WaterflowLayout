//
//  ViewController.m
//  瀑布流
//
//  Created by Singer on 15/4/12.
//  Copyright (c) 2015年 Singer. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "Shop.h"
#import "ShopCell.h"
#import "UIImageView+WebCache.h"
#import "MyWaterflowLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MyWaterflowLayoutDelegate>
@property (weak, nonatomic)IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;
@end

@implementation ViewController

static NSString *const shopCellID = @"shopCell";


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.shops = [NSMutableArray array];
    NSArray *array = [Shop objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:array];
    
    MyWaterflowLayout *myWaterflowLayout = [[MyWaterflowLayout alloc]init];
    myWaterflowLayout.delegate = self;
    
//    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:myWaterflowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.collectionViewLayout = myWaterflowLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShopCell" bundle:nil] forCellWithReuseIdentifier:shopCellID];
   
    [self.view addSubview:_collectionView];
    
}

-(CGFloat)waterflowLayout:(MyWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    Shop *shop = self.shops[indexPath.item];
    return shop.h / shop.w * width;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _shops.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopCell *shopCell = [collectionView dequeueReusableCellWithReuseIdentifier:shopCellID forIndexPath:indexPath];
    Shop *shop = _shops[indexPath.item];
    [shopCell.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img]];
    shopCell.priceLabel.text = shop.price;
    return shopCell;
}
@end

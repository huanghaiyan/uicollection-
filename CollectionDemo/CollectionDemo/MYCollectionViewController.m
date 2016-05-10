//
//  MYCollectionViewController.m
//  CollectionDemo
//
//  Created by 黄海燕 on 16/5/7.
//  Copyright © 2016年 huanghy. All rights reserved.
//

#import "MYCollectionViewController.h"
#import "MYCollectionViewCell.h"
#import "MYHeaderView.h"
#import "MYFooterView.h"

#define kMargin 10
@interface MYCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CGFloat cellWidth;
    CGFloat screenWidth;
}
@end

@implementation MYCollectionViewController

static NSString *const reuseIdentifier = @"MYCell";
static NSString *const reuseIdentifierHeader = @"MYHeaderView";
static NSString *const reuseIdentifierFooter = @"MYFooterView";

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //获取屏幕的大小
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    cellWidth = (screenWidth -3*kMargin)*0.5;

    [self.collectionView registerNib:[UINib nibWithNibName:@"MYCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MYHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MYFooterView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter];
    
    //设置多选
    self.collectionView.allowsMultipleSelection = YES;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MYCollectionViewCell *cell = (MYCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blueColor];
    
    return cell;
}

#pragma mark -形状设置
//cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellWidth, cellWidth);
}

//整体边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kMargin,kMargin, kMargin, kMargin);
}

//横向边距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kMargin;
}

//cell行距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kMargin*2;
}

//设置header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(screenWidth, 50);
}
//设置footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    return CGSizeMake(screenWidth, 50);
}

#pragma mark - 补充视图数据源方法
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *supplementaryView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //这里是设置header的属性
        MYHeaderView *view = (MYHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        view.headerLabel.text = [NSString stringWithFormat:@"header:%d",indexPath.row];
        supplementaryView = view;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        //这里设置footer的属性
        MYFooterView *view = (MYFooterView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter forIndexPath:indexPath];
        view.footerLabel.text = [NSString stringWithFormat:@"footer:%d",indexPath.row];
        supplementaryView = view;

    }
    return supplementaryView;
}

#pragma mark -选中
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"%s",__func__);
    
}

#pragma mark-取消选中
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"%s",__func__);
}



@end

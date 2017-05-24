//
//  AlbumViewController.m
//  OCR-LKTest
//
//  Created by linkiing on 2017/4/6.
//  Copyright © 2017年 linkiing. All rights reserved.
//

#import "AlbumViewController.h"
#import "CollectionReusableView.h"
#import "CollectionViewCell.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString * const cellID = @"Cell";
static CGSize AssetGridThumbnailSize;

@interface AlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionview;

@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细";
    [_collectionview registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    [_collectionview registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellID];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGFloat scale = [UIScreen mainScreen].scale;
    AssetGridThumbnailSize = CGSizeMake(((SCREEN_WIDTH-24)/3) * scale, ((SCREEN_WIDTH-24)/3) * scale);
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_albumMatArray.count == 19) {
        if (section == 0){
            return 3;
        } else if (section == 1){
            return 3;
        } else if (section == 2){
            return 3;
        } else if (section == 3){
            return 4;
        } else {
            return 6;
        }
    } else {
        return 3;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *dictionary;
    if (indexPath.section == 0) {
        dictionary = [_albumMatArray objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1){
        dictionary = [_albumMatArray objectAtIndex:indexPath.row+3];
    } else if (indexPath.section == 2){
        dictionary = [_albumMatArray objectAtIndex:indexPath.row+6];
    } else if (indexPath.section == 3){
        dictionary = [_albumMatArray objectAtIndex:indexPath.row+9];
    } else if (indexPath.section == 4){
        if (_albumMatArray.count == 19){
            dictionary = [_albumMatArray objectAtIndex:indexPath.row+13];
        } else {
            dictionary = [_albumMatArray objectAtIndex:indexPath.row+12];
        }
    } 
    cell.albumTitleLabel.text = dictionary.allKeys.firstObject;
    cell.albumImageview.image = [dictionary valueForKey:dictionary.allKeys.firstObject];
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-24)/3, (SCREEN_WIDTH-24)/3);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(6, 6, 6, 6);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 6.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 6.0;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        headerView.sectionLabel.text = [NSString stringWithFormat:@"视图第(%ld)部分",(long)indexPath.section+1];
        return headerView;
    }
    return nil;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 30);
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dictionary;
    if (indexPath.section == 0) {
        dictionary = [_albumMatArray objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1){
        dictionary = [_albumMatArray objectAtIndex:indexPath.row+3];
    } else if (indexPath.section == 2){
        dictionary = [_albumMatArray objectAtIndex:indexPath.row+6];
    } else if (indexPath.section == 3){
        dictionary = [_albumMatArray objectAtIndex:indexPath.row+9];
    } else if (indexPath.section == 4){
        if (_albumMatArray.count == 19){
            dictionary = [_albumMatArray objectAtIndex:indexPath.row+13];
        } else {
            dictionary = [_albumMatArray objectAtIndex:indexPath.row+12];
        }
    }
    UIImage *image = [dictionary valueForKey:dictionary.allKeys.firstObject];
    UIImageWriteToSavedPhotosAlbum(image, self, NULL, NULL);
}

@end

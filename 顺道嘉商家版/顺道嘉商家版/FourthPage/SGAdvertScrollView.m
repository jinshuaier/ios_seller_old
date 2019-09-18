
#import "SGAdvertScrollView.h"

@interface SGAdvertScrollViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *im;
@end

@implementation SGAdvertScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview: self.contentLabel];
    }
    return self;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.frame = CGRectMake(8, 8, self.frame.size.width - 16, 54 - 8 - 8);
        _contentLabel.textColor =  [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contentLabel;
}

@end



#pragma mark - - - SGAdvertScrollView
@interface SGAdvertScrollView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *leftview;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *tempArr;
@end

@implementation SGAdvertScrollView

static NSUInteger  const SGMaxSections = 100;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.backgroundColor = [UIColor whiteColor];
    [self setupLeftImageView];
    [self setupCollectionView];
}

- (void)setupLeftImageView {
    _leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 88, 54)];
    _leftview.backgroundColor = [UIColor whiteColor];
    [self addSubview: _leftview];;
    self.imageView = [[UIImageView alloc] init];
    [_leftview addSubview:_imageView];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(88, 0, 2, 54)];
    line.backgroundColor = Grayline;
    [self addSubview: line];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(WIDHT - 20, 15, 11, 20)];
    im.image = [UIImage imageNamed:@"进入小图标（蓝）.png"];
    [self addSubview: im];
}

- (void)setupCollectionView {
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollsToTop = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    // 注册
    [_collectionView registerClass:[SGAdvertScrollViewCell class] forCellWithReuseIdentifier:@"tipsCell"];
    [self addSubview:_collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置图片尺寸
    _imageView.frame = CGRectMake(16, 7, 56, 40);
    _collectionView.frame = CGRectMake(_leftview.frame.origin.x + _leftview.frame.size.width + 2, _leftview.frame.origin.y, self.frame.size.width - _leftview.frame.origin.x - _leftview.frame.size.width - 1 - 20, 54);
    _flowLayout.itemSize = CGSizeMake(_collectionView.frame.size.width, _collectionView.frame.size.height);
    // 默认显示最中间的那组
    [self defaultSelectedScetion];
}

/// 默认选中的组
- (void)defaultSelectedScetion {
    if (self.tempArr.count == 0) return; // 为解决加载数据延迟问题
    // 默认显示最中间的那组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:SGMaxSections / 2] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

#pragma mark - - - UICollectionView 的 dataSource 方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return SGMaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tempArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SGAdvertScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tipsCell" forIndexPath:indexPath];
    cell.tipsLabel.text = @"消息提示";
    cell.contentLabel.text = _tempArr[indexPath.item][@"message"];
    return cell;
}

#pragma mark - - - UICollectionView 的 delegate 方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.advertScrollViewDelegate && [self.advertScrollViewDelegate respondsToSelector:@selector(advertScrollView:didSelectedItemAtIndex:)]) {
        [self.advertScrollViewDelegate advertScrollView:self didSelectedItemAtIndex:indexPath.item];
    }
}

#pragma mark - - - 创建定时器
- (void)addTimer {
    [self removeTimer];
    if (_tempArr.count > 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(beginUpdateUI) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

#pragma mark - - - 移除定时器
- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - - - 定时器执行方法 - 更新UI
- (void)beginUpdateUI {
    if (self.tempArr.count == 0) return; // 为解决加载网络图片延迟问题

    // 1、当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *resetCurrentIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:SGMaxSections / 2];
    [self.collectionView scrollToItemAtIndexPath:resetCurrentIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    // 2、计算出下一个需要展示的位置
    NSInteger nextItem = resetCurrentIndexPath.item + 1;
    NSInteger nextSection = resetCurrentIndexPath.section;
    if (nextItem == self.tempArr.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    // 3、通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

#pragma mark - - - setting
- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    self.tempArr = [NSArray arrayWithArray:titleArray];
    if (self.tempArr.count > 1) {
        [self addTimer];
    }
}


@end


//
//  AccountMangerViewController.m
//  Owl_iOS_Pro
//
//  Created by 王艳平 on 16/9/6.
//  Copyright © 2016年 Aang. All rights reserved.
//

#import "AccountMangerViewController.h"
#import "UIImage+YPExtension.h"
#import "AccountHomeViewController.h"
#import "AccountGoodsViewController.h"
#import "AccountAssessViewController.h"
#import "UIView+YPFrameExtension.h"
#import <AFNetworking.h>

#import "TZImagePickerController.h"
#import "TZImageManager.h"

@interface AccountMangerViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate,
UIAlertViewDelegate, TZImagePickerControllerDelegate>{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
}
@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UITapGestureRecognizer *iconTap;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)NSMutableArray *btnArray;
@property (nonatomic, strong)UIView *selectView;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIButton *preSelectBtn;
@property (nonatomic, strong)UIView *indicator;
@property (nonatomic, strong)UIImagePickerController *imagePickerVc;
@end

@implementation AccountMangerViewController
#pragma mark - lazy
- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBacgroundColor;
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
    [self createChildViewController];
    
    [self createTopView];
    
    [self createSelecteView];
    
    [self createScrollView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - createScrollView
- (void)createScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectView.frame) + 1, WIDTHS, HEIGHTS - CGRectGetMaxY(self.selectView.frame))];
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * WIDTHS, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //默认显示第一个view
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - createSelecteView
- (void)createSelecteView
{
    CGFloat buttonW = 95 * WIDTHMAKE;
    CGFloat buttonH = 42 * HEIGHTMAKE;
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake((WIDTHS - 3 * buttonW) / 2, CGRectGetMaxY(self.topView.frame), 3 * buttonW , 40 * HEIGHTMAKE)];
    [self.view addSubview:selectView];
    self.selectView = selectView;
    //创建按钮
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonW, 2 * HEIGHTMAKE, buttonW, buttonH);
        NSMutableDictionary *norAttr = [NSMutableDictionary dictionary];
        norAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15 * WIDTHMAKE];
        norAttr[NSForegroundColorAttributeName] = COLOR(138, 138, 138, 1.0);
        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:[self.childViewControllers[i] title] attributes:norAttr] forState:UIControlStateNormal];
        
        NSMutableDictionary *selAttr = [NSMutableDictionary dictionary];
        selAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15 * WIDTHMAKE];
        selAttr[NSForegroundColorAttributeName] = COLOR(8, 181, 212, 1.0);
        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:[self.childViewControllers[i] title] attributes:selAttr] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:button];
        [selectView addSubview:button];
    }
    
    //创建指示条
    UIView *indicator = [[UIView alloc] init];
    indicator.y = selectView.height - 2 * HEIGHTMAKE;
    indicator.height = 2 * HEIGHTMAKE;
    indicator.backgroundColor = COLOR(8, 181, 212, 1.0);
    [selectView addSubview:indicator];
    self.indicator = indicator;
    
    //默认点击第一个按钮
    UIButton *firstBtn = self.btnArray.firstObject;
    [firstBtn.titleLabel sizeToFit];
    [self btnClick:firstBtn];
}

#pragma mark - createTopView
- (void)createTopView
{
    self.view.backgroundColor = ViewBacgroundColor;
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHS, 160)];
    _topView.backgroundColor = COLOR(8, 181, 212, 1.0);
    [self.view addSubview:_topView];
    
    [self initTopView];
}

- (void)initTopView
{
    //创建头像
    _iconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick)];
    _iconTap.delegate = self;
    
    //设置头像
    _icon = [[UIImageView alloc] init];
    if ([[NSUserDefaults standardUserDefaults] valueForKeyPath:@"userID"]) {
        [_icon setImage:self.iconImage];
    } else {
        [_icon setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] valueForKeyPath:@"icon"]]]].circleImage];
    }
    _icon.userInteractionEnabled = YES;
    [_icon addGestureRecognizer:_iconTap];
    _icon.center = CGPointMake(self.view.center.x, 80 * HEIGHTMAKE);
    _icon.bounds = CGRectMake(0, 0, 68 * WIDTHMAKE, 68 * HEIGHTMAKE);
    [self.topView addSubview:_icon];
    
    //创建昵称
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:17 * HEIGHTMAKE];
    _nameLabel.textColor = [UIColor whiteColor];
//    _nameLabel.text = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"nickname"];
    [_nameLabel sizeToFit];
    _nameLabel.center = CGPointMake(self.view.center.x, CGRectGetMaxY(_icon.frame) + 20 * HEIGHTMAKE);
    [self.topView addSubview:_nameLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(5 * WIDTHMAKE, 30 * WIDTHMAKE, 30 * WIDTHMAKE, 30 * WIDTHMAKE);
    backBtn.contentMode = UIViewContentModeCenter;
    [backBtn setImage:[UIImage imageNamed:@"nav_back_icon"] forState:UIControlStateNormal];
    [self.topView addSubview:backBtn];
}

#pragma mark - createChildViewController
- (void)createChildViewController
{
    __weak typeof(self) weakSelf = self;
    AccountHomeViewController *accHomeVc = [[AccountHomeViewController alloc] initWithStyle:UITableViewStylePlain];
    accHomeVc.title = @"主页";
    accHomeVc.changeNickNameBlock = ^(NSString *nickName){
        weakSelf.changeNameBlock(nickName);
    };
    [self addChildViewController:accHomeVc];
    
    AccountGoodsViewController *accGoodsVc = [[AccountGoodsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    accGoodsVc.title = @"商品";
    [self addChildViewController:accGoodsVc];
    
    AccountAssessViewController *accAssessVc = [[AccountAssessViewController alloc] init];
    accAssessVc.title = @"评价";
    [self addChildViewController:accAssessVc];
}

#pragma mark - btnClick
- (void)btnClick:(UIButton *)btn
{
    self.preSelectBtn.selected = NO;
    btn.selected = YES;
    self.preSelectBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.width = btn.titleLabel.width;
        self.indicator.centerX = btn.centerX;
    }];
    
    //滚动scrollview到相应的位置
    NSUInteger index = [self.btnArray indexOfObject:btn];
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = index * WIDTHS;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / WIDTHS;
    UIViewController *willShowVc = self.childViewControllers[index];
    
    if (willShowVc.isViewLoaded) return;
    
    willShowVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowVc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //滚动结束后，显示相应的按钮
    NSInteger index = scrollView.contentOffset.x / WIDTHS;
    UIButton *btn = [self.btnArray objectAtIndex:index];
    [self btnClick:btn];
    //设置下面这句才能显示willShow.view
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 返回
- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 改变状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc
{
    [_icon removeGestureRecognizer:_iconTap];
}

#pragma mark - 更换头像
- (void)iconClick
{
    if ([[NSUserDefaults standardUserDefaults] valueForKeyPath:@"userID"]) {
        UIImagePickerController *imagePickerVc = [[UIImagePickerController alloc] init];
        imagePickerVc.delegate = self;
        imagePickerVc.allowsEditing = YES;
        // set appearance / 改变相册选择页的导航栏外观
        imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        self.imagePickerVc = imagePickerVc;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
        [self pushImagePickerController];
    } else {
        NSLog(@"sss");
    }
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - TZImagePickerController
- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self];
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIImage *selImage = photos.firstObject;
        [_icon setImage:selImage.circleImage];
        //更改个人首页头像
        self.changeIconBlock(selImage);
        //保存图片
        [self saveImage:selImage withName:@"userAvatar"];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

#pragma mark - UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            if (alertView.tag == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"]];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"]];
            }
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [_icon setImage:image.circleImage];
        //更改个人首页头像
        self.changeIconBlock(image);
        //保存图片
        [self saveImage:image withName:@"userAvatar"];
    }
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
}

#pragma mark - saveImage
- (void)saveImage:(UIImage *)selImage withName:(NSString *)imageName
{
    NSData *imageData = UIImagePNGRepresentation(selImage);
    //保存图片到 document
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *totalPath = [documentPath stringByAppendingPathComponent:imageName];
    [imageData writeToFile:totalPath atomically:NO];
    //保存到 NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:totalPath forKey:@"avatar"];
    
    //保存到服务器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                             @"text/html",
                             @"image/jpeg",
                             @"image/png",
                             @"application/octet-stream",
                             @"text/json", nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *userID = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"userID"];
    param[@"userId"] = userID;

    
    [manager POST:@"http://192.168.2.168:8080/user/uploadHead" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *fileName = [NSString stringWithFormat:@"123.png"];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@------",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@++++++",error);
    }];
}
@end

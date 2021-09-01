//
//  BKEHomeTableViewCell.m
//  ShoPiaoPiao
//
//  Created by 刘一博 on 2021/9/1.
//

#import "BKEHomeTableViewCell.h"

@interface BKEHomeTableViewCell ()

// 电影封面、标题、评分、导演、演员表、购票按钮
@property(nonatomic, strong, readwrite) UIImageView *leftImageView;
@property(nonatomic, strong, readwrite) UILabel *titleLabel;
@property(nonatomic, strong, readwrite) UILabel *ratingLabel;
@property(nonatomic, strong, readwrite) UILabel *directorLabel;
@property(nonatomic, strong, readwrite) UILabel *actorLabel;
@property(nonatomic, strong, readwrite) UIButton *purchaseButton;

@end

@implementation BKEHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // ❗️记得修改为相对布局（Mansory）
        [self.contentView addSubview:({
            self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(330, 15, 70, 70)];
            self.leftImageView.backgroundColor = [UIColor orangeColor];
            self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
            self.leftImageView;
        })];
        
        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 300, 50)];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel;
        })];
        
        [self.contentView addSubview:({
            self.ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 50, 20)];
            self.ratingLabel.font = [UIFont systemFontOfSize:12];
            self.ratingLabel.textColor = [UIColor redColor];
            self.ratingLabel;
        })];
        
        [self.contentView addSubview:({
            self.directorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 50, 20)];
            self.directorLabel.font = [UIFont systemFontOfSize:12];
            self.directorLabel.textColor = [UIColor redColor];
            self.directorLabel;
        })];
        
        [self.contentView addSubview:({
            self.actorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 50, 20)];
            self.actorLabel.font = [UIFont systemFontOfSize:12];
            self.actorLabel.textColor = [UIColor redColor];
            self.actorLabel;
        })];
        
        [self.contentView addSubview:({
            self.purchaseButton = [[UIButton alloc] initWithFrame:CGRectMake(290, 80, 30, 20)];
            [self.purchaseButton setTitle:@"购票" forState:UIControlStateNormal];
            [self.purchaseButton addTarget:self action:@selector(purchaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            self.purchaseButton.layer.cornerRadius = 10;
            self.purchaseButton.layer.masksToBounds = YES;
            self.purchaseButton;
        })];
    }
    return self;
}

// ❓这个click和头文件里的delegate Click有什么关联？里面可以包含delegate的Click；捋一捋怎么用
- (void)purchaseButtonClick {
    NSLog(@"Go To Purchase Page!");
}

@end

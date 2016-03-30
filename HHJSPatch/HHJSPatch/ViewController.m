//
//  ViewController.m
//  HHJSPatch
//
//  Created by caohuihui on 16/3/23.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "ViewController.h"
#import <JSPatch/JPEngine.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()
{
    dispatch_queue_t _queue;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _queue=dispatch_queue_create("downloadFile", nil);
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 50)];
    [btn setTitle:@"Push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:btn];
    

    UIButton *downloadBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 50)];
    [downloadBtn1 setTitle:@"下载红视图js" forState:UIControlStateNormal];
    [downloadBtn1 addTarget:self action:@selector(downLoadButton1) forControlEvents:UIControlEventTouchUpInside];
    [downloadBtn1 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:downloadBtn1];
    
    UIButton *downloadBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 50)];
    [downloadBtn2 setTitle:@"下载蓝视图js" forState:UIControlStateNormal];
    [downloadBtn2 addTarget:self action:@selector(downLoadButton2) forControlEvents:UIControlEventTouchUpInside];
    [downloadBtn2 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:downloadBtn2];
    
    
    UIButton *downloadBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, 50)];
    [downloadBtn3 setTitle:@"下载紫视图js" forState:UIControlStateNormal];
    [downloadBtn3 addTarget:self action:@selector(downLoadButton3) forControlEvents:UIControlEventTouchUpInside];
    [downloadBtn3 setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:downloadBtn3];
    
//    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 50)];
//    [btn2 setTitle:@"加载js" forState:UIControlStateNormal];
//    [btn2 addTarget:self action:@selector(loadJS) forControlEvents:UIControlEventTouchUpInside];
//    [btn2 setBackgroundColor:[UIColor grayColor]];
//    [self.view addSubview:btn2];
    
    

}

-(void)downLoadButton1{
    [self downloadFileWithUrlString:@"http://caohuihui.com/download/Test.js"];
}

-(void)downLoadButton2{
    [self downloadFileWithUrlString:@"http://caohuihui.com/download/Test2.js"];
}

-(void)downLoadButton3{
    [self downloadFileWithUrlString:@"http://caohuihui.com/download/Test3.js"];
}

-(void)downloadFileWithUrlString:(NSString *)urlString{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak typeof(self)weakSelf=self;
    dispatch_async(_queue, ^{
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSString * code=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSString *filePath=[self getFilePath];
        [code writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@",NSStringFromSelector(_cmd));
        [weakSelf loadJS];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        });
    });
    
}

- (void)handleBtn:(id)sender
{
    
}

- (void)loadJS{

    NSString *sourcePath = [self getFilePath];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    NSFileManager * fileManager=[[NSFileManager alloc]init];
    if ([fileManager fileExistsAtPath:sourcePath]) {
        [JPEngine startEngine];
        [JPEngine evaluateScript:script];
    }
}


-(NSString *)getFilePath{
    NSString *filePath=[NSString stringWithFormat:@"%@/Documents/Test.js",NSHomeDirectory()];
    return filePath;
}
@end

//
//  ViewController.m
//  pyfmdbdemo
//
//  Created by pengyong on 15/11/3.
//  Copyright © 2015年 pengyong. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
- (IBAction)add;
- (IBAction)update;
- (IBAction)delete;
- (IBAction)query;
- (IBAction)truncate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.table truncate];
    for (int i=0; i<30; i++) {
        NSDictionary *fields = @{@"name":@"test",@"wheels":[NSNumber numberWithInt:i]};
        [self.table addFields:fields];
    }
    
    
    [self.table updateFields:@{@"name":@"test2"} andWhere:@"name='test'"];
    NSLog(@"lastsql:%@",self.table.lastSql);
    NSString *field = (NSString *)[self.table getField:@"name" andWhere:nil];
    NSLog(@"field:%@",field);
    
}


-(CarTable *)table{
    if (_table) {
        return _table;
    }
    _table = [[CarTable alloc] init];
    return _table;
}
- (IBAction)add {
    // 3 添加数据
    for (int i=0; i<10; i++) {
        NSDictionary *data = @{
                               @"name":@"奥迪",
                               @"wheels":@4 ,
                               };
        [self.table addFields:data];
    }
    NSLog(@"sql:%@",self.table.lastSql);
    
    NSLog(@"table count:%lu",(unsigned long)[self.table count]);
     NSLog(@"sql:%@",self.table.lastSql);
}

- (IBAction)update {
    [self.table updateFields:@{@"name":@"奔驰"} andWhere:@"id > 2"];
    NSLog(@"sql:%@",self.table.lastSql);
}

- (IBAction)delete {
   
    [self.table deleteWithWhere:@"id>5"];
    NSLog(@"sql:%@",self.table.lastSql);
    
}

- (IBAction)query {
   // NSArray *result = [self.table selectWithWhere:nil andFields:@"*" andPage:1 andPageSize:5 andOrder:@"id desc"];
    NSArray *result = [self.table selectAll];
    NSLog(@"%@",result);
    NSLog(@"lastsql:%@",self.table.lastSql);
    
}

- (IBAction)truncate {
    [self.table truncate];
}

@end
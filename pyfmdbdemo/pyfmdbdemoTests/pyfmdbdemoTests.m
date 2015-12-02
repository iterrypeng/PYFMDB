//
//  pyfmdbdemoTests.m
//  pyfmdbdemoTests
//
//  Created by terry peng on 15/12/3.
//  Copyright © 2015年 pengyong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CarTable.h"
@interface pyfmdbdemoTests : XCTestCase
@property(nonatomic,strong)CarTable *table;
@end

@implementation pyfmdbdemoTests

-(CarTable *)table{
    if (_table) {
        return _table;
    }
    _table = [[CarTable alloc] init];
    [_table truncate];
    return _table;
}

-(void)testInsert{
    NSDictionary *fields = @{@"name":@"test",@"wheels":@1};
    [self.table addFields:fields];
    BOOL valid = [self.table count]==1 ? YES :NO;
    XCTAssertTrue(valid);
}

-(void)testDelete{
    NSDictionary *fields = @{@"name":@"test",@"wheels":@1};
    [self.table addFields:fields];
    [self.table deleteWithWhere:@"name='test'"];
    BOOL valid = [self.table count]==0 ? YES :NO;
     XCTAssertTrue(valid);
}

-(void)testSelect{
    for (int i=0; i<30; i++) {
        NSDictionary *fields = @{@"name":@"test",@"wheels":[NSNumber numberWithInt:i]};
        [self.table addFields:fields];
    }
    NSArray *result = [self.table selectAll];
    BOOL valid = [result count]==30 ? YES :NO;
    XCTAssertTrue(valid);
}

-(void)testUpdate{
    NSDictionary *fields = @{@"name":@"test",@"wheels":@1};
    [self.table addFields:fields];
    [self.table updateFields:@{@"name":@"test2"} andWhere:@"name='test'"];
     NSString *field = (NSString *)[self.table getField:@"name" andWhere:nil];
    XCTAssertTrue([field isEqualToString:@"test2"]);
}

@end

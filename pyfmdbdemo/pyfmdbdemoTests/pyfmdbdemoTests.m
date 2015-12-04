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

-(void)add{
    NSDictionary *fields = @{@"name":@"BMW",@"wheels":@1};
    [self.table addFields:fields];
}

-(void)delete{
    [self.table deleteWithWhere:@"name='BMW'"];
}

-(void)testInsert{
    [self add];
    BOOL valid = [self.table count]==1 ? YES :NO;
    XCTAssertTrue(valid);
}

-(void)testAddOrUpdate{
    [self add];
     NSDictionary *fields = @{@"name":@"MINI",@"wheels":@1};
    [self.table addOrUpdateFields:fields andWhere:@"name='MINI'"];
    BOOL valid1 = [self.table count]==2 ? YES :NO;
    [self.table addOrUpdateFields:fields andWhere:@"name='BMW'"];
    BOOL valid2 = [self.table count]==2 && ![self.table hasFields: @{@"name":@"BMW",@"wheels":@1}] ? YES :NO;
    XCTAssertTrue(valid1 && valid2);
}

-(void)testAddOrIgnore{
    [self add];
    NSDictionary *fields = @{@"name":@"MINI",@"wheels":@1};
    [self.table addFieldsIfNotExist:fields];
    BOOL valid1 = [self.table count]==2 ? YES :NO;
    [self.table addFieldsIfNotExist:@{@"name":@"BMW",@"wheels":@1}];
    BOOL valid2 = [self.table count]==2 ? YES :NO;
    XCTAssertTrue(valid1 && valid2);
}

-(void)testDelete{
    [self add];
    [self delete];
    BOOL valid = [self.table count]==0 ? YES :NO;
     XCTAssertTrue(valid);
}

-(void)testSelect{
    for (int i=0; i<30; i++) {
        [self add];
    }
    NSArray *result = [self.table selectAll];
    BOOL valid = [result count]==30 ? YES :NO;
    XCTAssertTrue(valid);
}

-(void)testUpdate{
    [self add];
    [self.table updateFields:@{@"name":@"MINI"} andWhere:@"name='BMW'"];
     NSString *field = (NSString *)[self.table getField:@"name" andWhere:nil];
    XCTAssertTrue([field isEqualToString:@"MINI"]);
}

-(void)testHasWhere{
    [self add];
    XCTAssertTrue([self.table hasWhere:@"name='BMW'"]);
}

-(void)testHasFields{
    [self add];
    NSDictionary *fields = @{@"name":@"BMW",@"wheels":@1};
    XCTAssert([self.table hasFields:fields]);
}

-(void)testExecuteQuery{
    [self add];
    NSString *sql = @"select * from car";
    XCTAssert([[self.table executeQueryWithSql:sql] count] ==1);
}

-(void)testExecuteUpdate{
    [self add];
    NSString *sql = @"delete from car where name='BMW'";
    XCTAssert([self.table executeUpdateWithSql:sql]);
}

@end

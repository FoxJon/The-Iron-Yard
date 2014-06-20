//
//  WTFAnimalTest.m
//  Why Tests Fail
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WTFAnimal.h"

@interface WTFAnimalTest : XCTestCase

@end

@implementation WTFAnimalTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

-(void)testIfCrawling
{
    WTFAnimal * bear = [[WTFAnimal alloc]init];
    bear.amountOfLegs = 4;
    
    XCTAssertTrue(bear.isCrawling, @"Bear is crawling");
}

-(void)testIfNotCrawling
{
    WTFAnimal * snake = [[WTFAnimal alloc]init];
    snake.amountOfLegs = 0;
    
    XCTAssertTrue(!snake.isCrawling, @"snake is not crawling");
    
    WTFAnimal * human = [[WTFAnimal alloc]init];
    human.amountOfLegs = 2;
    XCTAssertTrue(!human.isCrawling, @"Human is not crawling");
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__); 
//}

@end

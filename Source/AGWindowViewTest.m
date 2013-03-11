//
// Author: Håvard Fossli <hfossli@agens.no>
//
// Copyright (c) 2013 Agens AS (http://agens.no/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <SenTestingKit/SenTestingKit.h>
#import "AGWindowView.h"

@interface AGWindowView (Test)

@end

@interface AGWindowViewTest : SenTestCase

@end

@implementation AGWindowViewTest

#pragma mark - Construct and destruct

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - Tests

- (void)testAngleForOrientations
{
    {
        CGFloat angle = UIInterfaceOrientationAngleBetweenOrientations(UIInterfaceOrientationPortrait, UIInterfaceOrientationLandscapeLeft);
        STAssertEquals(angle, (CGFloat)M_PI_2, nil);
    }
    {
        CGFloat angle = UIInterfaceOrientationAngleBetweenOrientations(UIInterfaceOrientationLandscapeLeft, UIInterfaceOrientationPortraitUpsideDown);
        STAssertEquals(angle, (CGFloat)-M_PI_2 * 3, nil);
    }
    {
        CGFloat angle = UIInterfaceOrientationAngleBetweenOrientations(UIInterfaceOrientationPortrait, UIInterfaceOrientationPortrait); 
        STAssertEquals(angle, (CGFloat)0.0, nil);
    }
}

- (void)testEdge
{
    CGRect statusBarFrame = CGRectMake(0, 0, 1024, 20);
    CGRect windowBounds = CGRectMake(0, 0, 1024, 768);
    
    CGRectEdge edge = CGRectEdgeForRectPlacedAlongEdgeOfRect(windowBounds, statusBarFrame);
    STAssertEquals(edge, CGRectMinYEdge, nil);
}

- (void)testCalculateFrame
{
    
}

@end

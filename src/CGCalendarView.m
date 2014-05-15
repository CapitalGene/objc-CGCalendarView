//
//  CGCalendarView.m
//  CapitalGene
//
//  Created by Chen Liang on 9/11/13.
//  Copyright (c) 2013 Chen Liang. All rights reserved.
//  See the LICENSE file distributed with this work.

#import "CGCalendarView.h"
#import "CGCalendarCell.h"

@interface CGCalendarView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation CGCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _CGCalendarView_commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    
    [self _CGCalendarView_commonInit];
    
    return self;
}

- (void)_CGCalendarView_commonInit
{
    //DLog(@"in _CGCalendarView_commonInit");
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setShowsHorizontalScrollIndicator:NO];
    [_tableView setShowsVerticalScrollIndicator:NO];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.tableView.allowsMultipleSelection = NO;
    [self addSubview:_tableView];
    CGAffineTransform rotateTable = CGAffineTransformMakeRotation(-M_PI_2);
    _tableView.transform = rotateTable;
    //_tableView.frame = CGRectMake(0, 500,_tableView.frame.size.width, _tableView.frame.size.height);
}

- (void)dealloc;
{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

- (NSCalendar *)calendar;
{
    if (!_calendar) {
        self.calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}

- (Class)rowCellClass;
{
    if (!_rowCellClass) {
        self.rowCellClass = [CGCalendarCell class];
    }
    return _rowCellClass;
}

- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self rowCellClass];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor;
{
    [super setBackgroundColor:backgroundColor];
    [self.tableView setBackgroundColor:backgroundColor];
}

- (void)setFirstDate:(NSDate *)firstDate;
{
    // clamp to the beginning of its month
    _firstDate = firstDate;
}


- (void)setLastDate:(NSDate *)lastDate;
{
    _lastDate = lastDate;
}

- (void)setInitialSelectedDate:(NSDate *)date
{
    _selectedDate = date;
}

- (void)setSelectedDate:(NSDate *)newSelectedDate;
{

    if ([self.delegate respondsToSelector:@selector(calendarView:shouldSelectDate:)] && ![self.delegate calendarView:self shouldSelectDate:newSelectedDate]) {
        return;
    }
    
    _selectedDate = newSelectedDate;
    
    if ([self.delegate respondsToSelector:@selector(calendarView:didSelectDate:)]) {
        [self.delegate calendarView:self didSelectDate:newSelectedDate];
    }
}


- (void)scrollToDate:(NSDate *)date animated:(BOOL)animated
{

    [self.tableView scrollToRowAtIndexPath:[self indexPathForRowAtDate:date] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

}

#pragma mark Calendar calculations

- (CGCalendarCell *)cellForRowAtDate:(NSDate *)date;
{
    return (CGCalendarCell *)[self.tableView cellForRowAtIndexPath:[self indexPathForRowAtDate:date]];
}

- (NSInteger)sectionForDate:(NSDate *)date;
{
    return 0;
}

- (NSDate *)dateForCellAtIndexPath:(NSIndexPath*)indexPath
{
    NSDateComponents *components=[[NSDateComponents alloc] init];
    components.day=indexPath.row;
    NSDate *targetDate =[self.calendar dateByAddingComponents:components toDate:self.firstDate options: 0];
    return targetDate;
}

- (NSIndexPath *)indexPathForRowAtDate:(NSDate *)date;
{
    if (!date) {
        return nil;
    }
    
    NSInteger section = [self sectionForDate:date];

    int days = [self daysWithinEraFromDate:self.firstDate toDate:date];
    return [NSIndexPath indexPathForRow:days inSection:section];
}

//https://developer.apple.com/library/ios/documentation/cocoa/Conceptual/DatesAndTimes/Articles/dtCalendricalCalculations.html
-(NSInteger)daysWithinEraFromDate:(NSDate *) startDate toDate:(NSDate *) endDate
{
    NSInteger startDay=[self.calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:startDate];
    NSInteger endDay=[self.calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:endDate];
    return endDay-startDay;
}

- (void)refresh
{
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[self indexPathForRowAtDate:self.selectedDate] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark UIView

- (void)layoutSubviews;
{

    self.tableView.frame = self.bounds;
    if (self.selectedDate == Nil) {
        self.selectedDate = [NSDate date];
        [self.tableView selectRowAtIndexPath:[self indexPathForRowAtDate:self.selectedDate] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }else{
        [self.tableView selectRowAtIndexPath:[self indexPathForRowAtDate:self.selectedDate] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    //DLog(@"in numberOfSectionsInTableView");
    //return 1 + [self.calendar components:NSMonthCalendarUnit fromDate:self.firstDate toDate:self.lastDate options:0].month;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self daysWithinEraFromDate:self.firstDate toDate:self.lastDate];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{

        static NSString *identifier = @"row";
        CGCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
        if (!cell) {
            cell = [[[self rowCellClass] alloc] initWithCalendar:self.calendar reuseIdentifier:identifier];
            //cell.contentView.backgroundColor = [UIColor silver];//self.backgroundColor;
            cell.calendarView = self;
            cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
    
    
        return cell;
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDate *targetDate = [self dateForCellAtIndexPath:indexPath];
    [(CGCalendarCell*)cell setDate:targetDate];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [[self cellClassForRowAtIndexPath:indexPath] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedDate = [self dateForCellAtIndexPath:indexPath];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
{
    
    if (velocity.y > 0.38f) {
        velocity.y = 0.38f;
    }
    
    scrollView.decelerationRate = velocity.y;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.dragging && !scrollView.decelerating) {
        //[self detectScrollViewSelectedDate:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self detectScrollViewSelectedDate:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (!decelerate) {
        [self detectScrollViewSelectedDate:scrollView];
    }
    
}


- (void)detectScrollViewSelectedDate:(UIScrollView *)scrollView
{
    CGPoint centerPoint = CGPointMake(self.tableView.frame.origin.x + self.tableView.frame.size.width/2, self.tableView.frame.origin.y + self.tableView.frame.size.height/2);
    
    CGPoint sPoint = [self convertPoint:centerPoint toView:scrollView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:sPoint];
    NSIndexPath *SelectedindexPath = [self indexPathForRowAtDate:self.selectedDate];
    
    CGRect rec = [self.tableView rectForRowAtIndexPath:SelectedindexPath];
    
    if (!CGRectContainsPoint(rec, sPoint)) {
        self.selectedDate = [self dateForCellAtIndexPath:indexPath];
         [self.tableView selectRowAtIndexPath:[self indexPathForRowAtDate:self.selectedDate] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }

}

@end

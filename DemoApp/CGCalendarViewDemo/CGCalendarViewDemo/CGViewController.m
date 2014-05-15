//
//  CGViewController.m
//  CGCalendarViewDemo
//
//  Created by Chen Liang on 5/14/14.
//  Copyright (c) 2014 CapitalGene. All rights reserved.
//

#import "CGViewController.h"
#import "CGCalendarView.h"
#import "CGCalendarCell.h"
@interface CGViewController () <CGCalendarViewDelegate> {
    NSCalendar *calendar;
}
@property (nonatomic, strong) CGCalendarView *calendarView;
@property (nonatomic, strong) NSDateFormatter *DF;
@end

@implementation CGViewController

#define CG_CALENDAR_VIEW_HEIGHT 50

- (void)setupCalendarView
{
    // initalize calendarView with frame
    self.calendarView = [[CGCalendarView alloc] initWithFrame:CGRectMake(0, 20, 320, CG_CALENDAR_VIEW_HEIGHT)];
    // use a global NSCalendar
    self.calendarView.calendar = calendar;
    
    // Set the background color
    self.calendarView.backgroundColor = [UIColor lightGrayColor];
    
    // Set the RowCellClass
    self.calendarView.rowCellClass = [CGCalendarCell class];
    
    // The beginning date
    self.calendarView.firstDate = [NSDate dateWithTimeIntervalSinceNow: -60 * 60 * 24 * 30];
    
    // The end date
    self.calendarView.lastDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 180];
    
    // didSelectDate delegate
    self.calendarView.delegate = self;
    
    // Add the calendarView as a subview
    [self.view addSubview:self.calendarView];
    
    // Select Today
    self.calendarView.selectedDate = [NSDate date];
    
    // Prepare a dateformatter for displaying the selected
    // date
    self.DF = [[NSDateFormatter alloc] init];
    [self.DF setDateFormat:@"yyyy-MM-dd"];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupCalendarView];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- calendarView Delegate

- (void)calendarView:(CGCalendarView *)calendarView didSelectDate:(NSDate *)date
{
    self.SelectedDateLabel.text = [self.DF stringFromDate:date];
}

@end

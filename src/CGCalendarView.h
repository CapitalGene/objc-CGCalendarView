//
//  CGCalendarView.h
//  CapitalGene
//
//  Created by Chen Liang on 9/11/13.
//  Copyright (c) 2013 Chen Liang. All rights reserved.
//  See the LICENSE file distributed with this work.
//

#import <UIKit/UIKit.h>
/*
@interface CGCalendarView : UIView

@end
*/

@protocol CGCalendarViewDelegate;


@interface CGCalendarView : UIView

@property (nonatomic, strong) NSDate *firstDate;

@property (nonatomic, strong) NSDate *lastDate;

- (void)setInitialSelectedDate:(NSDate *)date;
- (void)refresh;
@property (nonatomic, strong) NSDate *selectedDate;

@property (nonatomic, strong) NSCalendar *calendar;


@property (nonatomic, strong) Class rowCellClass;

@property (nonatomic, weak) id<CGCalendarViewDelegate> delegate;

- (void)scrollToDate:(NSDate *)date animated:(BOOL)animated;
@end

@protocol CGCalendarViewDelegate <NSObject>

@optional

- (BOOL)calendarView:(CGCalendarView *)calendarView shouldSelectDate:(NSDate *)date;


- (void)calendarView:(CGCalendarView *)calendarView didSelectDate:(NSDate *)date;

@end
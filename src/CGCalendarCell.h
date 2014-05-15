//
//  CGCalendarCell.h
//  CapitalGene
//
//  Created by Chen Liang on 9/11/13.
//  Copyright (c) 2013 Chen Liang. All rights reserved.
//  See the LICENSE file distributed with this work.
//
// Comments and Properties inspired by:
// https://github.com/square/objc-TimesSquare/blob/master/TimesSquare/TSQCalendarCell.h

#import <UIKit/UIKit.h>

@class CGCalendarView;

@interface CGCalendarCell : UITableViewCell

@property (nonatomic, strong) NSCalendar *calendar;

/** The owning calendar view.
 
 This is a weak reference.
 */
@property (nonatomic, weak) CGCalendarView *calendarView;

/** @name Display Properties */

/** The preferred height for instances of this cell.
 
 The built-in implementation in `CGCalendarCell` returns `46.0f`. Your subclass may want to return another value.
 */
+ (CGFloat) cellHeight;

/** The text color.
 
 This is used for all text the cell draws; if a date is disabled, then it will draw in this color, but at 50% opacity.
 */
@property (nonatomic, strong) UIColor *textColor;

/** The text shadow offset.
 
 This is as you would set on `UILabel`.
 */
@property (nonatomic) CGSize shadowOffset;

/** The spacing between columns.
 
 This defaults to one pixel or `1.0 / [UIScreen mainScreen].scale`.
 */
@property (nonatomic) CGFloat columnSpacing;

@property (nonatomic, strong) NSDate *date;


/** @name Initialization */

/** Initializes the cell.
 
 @param calendar The `NSCalendar` the cell is representing
 @param reuseIdentifier A string reuse identifier, as used by `UITableViewCell`
 */
- (id)initWithCalendar:(NSCalendar *)calendar reuseIdentifier:(NSString *)reuseIdentifier;

/** Seven-column layout helper.
 
 @param index The index of the column we're laying out, probably in the range [0..6]
 @param rect The rect relative to the bounds of the cell's content view that represents the column.
 
 Feel free to adjust the rect before moving views and to vertically position them within the column. (In fact, you could ignore the rect entirely; it's just there to help.)
 */


@end

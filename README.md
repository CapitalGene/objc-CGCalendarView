# objc-CGCalendarView

A Lightweight Horizontal Calendar/Date Picker inspired by Square's TimesSquare
[https://github.com/square/objc-TimesSquare](https://github.com/square/objc-TimesSquare)

*Created for CapitalGene iOS App*

![Screenshot](https://github.com/CapitalGene/objc-CGCalendarView/raw/master/doc/img/capitalgene_sc_calendar.png "https://github.com/CapitalGene/objc-CGCalendarView/raw/master/doc/img/capitalgene_sc_calendar.png")

# Usage
## Initalize CGCalendarView

import `CGCalendarView.h` and `CGCalendarCell.h`

```Objective-C
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
```

## Delegate Methods

```Objective-C
- (BOOL)calendarView:(CGCalendarView *)calendarView shouldSelectDate:(NSDate *)date;
- (void)calendarView:(CGCalendarView *)calendarView didSelectDate:(NSDate *)date;
```
## Demo Screenshot

![Screenshot](https://github.com/CapitalGene/objc-CGCalendarView/raw/master/doc/img/screenshot.png "https://github.com/CapitalGene/objc-CGCalendarView/raw/master/doc/img/screenshot.png")

# Authors

**Chen Liang**

+ http://chen.technology
+ http://github.com/uschen

# Credits

+ Inspired by [https://github.com/square/objc-TimesSquare](https://github.com/square/objc-TimesSquare)
+ UIImage+Additions, Piotr Bernad
+ UIView+ViewHelpers, Nathan Mock

# License:
Licensed under the MIT license

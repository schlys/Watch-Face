import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class View extends WatchUi.WatchFace {

    hidden var front = WatchUi.loadResource(Rez.Fonts.Front);
    hidden var back = WatchUi.loadResource(Rez.Fonts.Back);
    hidden var backOutline = WatchUi.loadResource(Rez.Fonts.BackOutline);
    hidden var frontOutline = WatchUi.loadResource(Rez.Fonts.FrontOutline);

    hidden var walls = Application.loadResource(Rez.Drawables.Walls) as BitmapResource;
    hidden var borders = Application.loadResource(Rez.Drawables.Borders) as BitmapResource;
    hidden var entrance = Application.loadResource(Rez.Drawables.Entrance) as BitmapResource;

    hidden var _lowPower = false;

    hidden var _stats as Dictionary<Number, Stat> = {
        0 => new Steps(),
        1 => new Calories()
    } as Dictionary<Number, Stat>;

    function initialize(wfApp) {
        SettingsCache.refresh();
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        // setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    function onPartialUpdate(dc) as Void {
        if (_lowPower) {
            return;
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        dc.drawBitmap2( 0, 0, walls, { :tintColor => 0x10C6F4 });

        // dc.drawBitmap2( 0, 0, borders, { :tintColor => 0x1323bf } );
        dc.drawBitmap2( 0, 0, borders, { :tintColor => 0xfcf222  } );
        // dc.drawBitmap2( 0, 0, borders, { :tintColor => Graphics.COLOR_YELLOW } );

        dc.drawBitmap2( 0, 0, entrance, { :tintColor => 0xdd56c3 } );

        drawTime(dc);

        System.println("printing stat: " + _stats[SettingsCache.statRecord].getRecord());
    }

    // Draw the time
    private function drawTime(dc as Dc) as Void {
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (SettingsCache.useMilitaryFormat) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        dc.setColor(SettingsCache.timeBackColor as Number, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2,dc.getHeight()/2.1, back, timeString, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);

        // dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        // dc.drawText(dc.getWidth()/2,dc.getHeight()/2.1, backOutline, timeString, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);

        dc.setColor(SettingsCache.timeFrontColor as Number, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2,dc.getHeight()/2.1, front, timeString, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function onSettingsChanged() as Void {
        SettingsCache.refresh();
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
        _lowPower = false;
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
        _lowPower = true;
    }
 
}

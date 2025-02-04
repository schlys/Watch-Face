import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class View extends WatchUi.WatchFace {

    hidden var CrackMan = WatchUi.loadResource(Rez.Fonts.CrackMan);
    hidden var front = WatchUi.loadResource(Rez.Fonts.Front);
    hidden var back = WatchUi.loadResource(Rez.Fonts.Back);
    hidden var backOutline = WatchUi.loadResource(Rez.Fonts.BackOutline);
    hidden var frontOutline = WatchUi.loadResource(Rez.Fonts.FrontOutline);

    hidden var _lowPower = false;

    // hidden var _storage = new Storage();
    hidden var _settingsCache = new SettingsCache();

    private var _stats as Dictionary<Number, Stat> = {
        0 => new Steps(),
        1 => new Calories()
    } as Dictionary<Number, Stat>;

    function initialize(wfApp) {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        // setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    // function onShow() as Void {
    // }

    function onPartialUpdate(dc) as Void {
        if (_lowPower) {
            return;
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.clear();

        drawTime(dc);

        System.println("printing stat: " + _stats[_settingsCache.statRecord].getRecord());
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
            if (_settingsCache.useMilitaryFormat) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        dc.setColor(_settingsCache.timeBackColor as Number, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2,dc.getHeight()/2.06, back, timeString, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2,dc.getHeight()/2.06, backOutline, timeString, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);

        dc.setColor(_settingsCache.timeFrontColor as Number, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2,dc.getHeight()/2.06, front, timeString, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function onSettingsChanged() as Void {
        _settingsCache = new SettingsCache();
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

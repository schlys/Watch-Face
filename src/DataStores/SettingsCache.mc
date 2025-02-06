import Toybox.Application;

// holds settings values set by the user, using static for performance
class SettingsCache {
    public static var useMilitaryFormat;
    public static var timeFrontColor;
    public static var timeBackColor;
    public static var backgroundColor;
    public static var statRecord;

    static function refresh() {
        useMilitaryFormat = Application.Properties.getValue("UseMilitaryFormat");
        timeFrontColor = Application.Properties.getValue("TimeFrontColor");
        timeBackColor = Application.Properties.getValue("TimeBackColor");
        backgroundColor = Application.Properties.getValue("BackgroundColor");
        statRecord = Application.Properties.getValue("StatRecord");
    }
}
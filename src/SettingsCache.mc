class SettingsCache {
    public var useMilitaryFormat;
    public var timeFrontColor;
    public var timeBackColor;
    public var backgroundColor;

    function initialize() {
        useMilitaryFormat = Application.Properties.getValue("UseMilitaryFormat");
        timeFrontColor = Application.Properties.getValue("TimeFrontColor");
        timeBackColor = Application.Properties.getValue("TimeBackColor");
        backgroundColor = Application.Properties.getValue("BackgroundColor");
    }
}
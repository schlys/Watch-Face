import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class App extends Application.AppBase {

    hidden var _watchFace;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        _watchFace = new View(self);

        return [ _watchFace, new PowerBudgetDelegate() ];
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() as Void {
        _watchFace.onSettingsChanged();
        WatchUi.requestUpdate();
    }

}

function getApp() as App {
    return Application.getApp() as App;
}
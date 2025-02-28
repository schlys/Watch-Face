import Toybox.Lang;
import Toybox.Application.Storage;

// Holds stored properties set progromatically
class Storage {

    static function getRecordSteps() {
        return getStorageValue("recordSteps");
    }

    static function getRecordCalories() {
        return getStorageValue("recordCalories");
    }

    private static function getStorageValue(key as String) {
        var value = Storage.getValue(key);
        return value ? value : 0;
    }

    private static function setStorageValue(key as String, value) {
        Storage.setValue(key, value);
    }
}
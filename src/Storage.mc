import Toybox.Lang;
import Toybox.Application.Storage;

// Holds stored properties set progromatically
class Storage {
    function initialize() {}

    function getRecordSteps() {
        return getStorageValue("recordSteps");
    }

    function getRecordCalories() {
        return getStorageValue("recordCalories");
    }

    private function getStorageValue(key as String) {
        var value = Storage.getValue(key);
        return value ? value : 0;
    }

    private function setStorageValue(key as String, value) {
        Storage.setValue(key, value);
    }
}
class Calories extends Stat {

    function initialize() {
        Stat.initialize();
    }

    function getRecord() {
        return Storage.getRecordCalories();
    }
}
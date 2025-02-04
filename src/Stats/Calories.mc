class Calories extends Stat {
    
    function initialize() {
        Stat.initialize();
    }

    function getRecord(storage as Storage) {
        return storage.getRecordCalories();
    }
}
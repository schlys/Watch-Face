class Steps extends Stat {
    
    function initialize() {
        Stat.initialize();
    }

    function getRecord(storage as Storage) {
        return storage.getRecordSteps();
    }
}
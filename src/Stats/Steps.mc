class Steps extends Stat {

    function initialize() {
        Stat.initialize();
    }

    function getRecord() {
        return Storage.getRecordSteps();
    }
}
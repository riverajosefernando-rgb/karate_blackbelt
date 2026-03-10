function fn() {

    function uuid() {
        return java.util.UUID.randomUUID() + '';
    }

    function randomEmail() {
        var id = java.util.UUID.randomUUID().toString().substring(0,8);
        return "test_" + id + "@mail.com";
    }

    function randomName() {
        var names = ["Juan","Maria","Carlos","Ana","Pedro","Laura"];
        var index = Math.floor(Math.random() * names.length);
        return names[index];
    }

    function randomNumber(length) {
        var value = "";
        for(var i=0;i<length;i++){
            value = value + Math.floor(Math.random()*10);
        }
        return value;
    }

    function timestamp() {
        return java.time.Instant.now().toEpochMilli();
    }

    function today() {
        return java.time.LocalDate.now().toString();
    }

    function futureDate(days) {
        return java.time.LocalDate.now().plusDays(days).toString();
    }

    return {
        uuid: uuid,
        randomEmail: randomEmail,
        randomName: randomName,
        randomNumber: randomNumber,
        timestamp: timestamp,
        today: today,
        futureDate: futureDate
    }

}
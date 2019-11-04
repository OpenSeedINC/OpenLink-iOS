
function load_user() {

    var dataStr = "SELECT * FROM openseed_account WHERE 1"

    db.transaction(function (tx) {

        var pull = tx.executeSql(dataStr)
        if (pull.rows.length === 1) {
            userid = pull.rows.item(0).id
            username = pull.rows.item(0).name
            window.username = pull.rows.item(0).name
            ready = true
        } else {
            stackView.push("Setup.qml")
        }
       })

}


function create_db() {

    console.log("Checking databases")
    db.transaction(function (tx) {
    tx.executeSql(
                'CREATE TABLE IF NOT EXISTS Profile(id TEXT, name TEXT,phone TEXT,email TEXT,company TEXT,data TEXT)')
    tx.executeSql('CREATE TABLE IF NOT EXISTS openseed_account(id TEXT, name TEXT, passphrase TEXT)')
    tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(id TEXT, value INT)')
    tx.executeSql(
                'CREATE TABLE IF NOT EXISTS Themes(id TEXT, backgroundColor TEXT, highLightColor TEXT, seperatorColor TEXT, barColor TEXT, activeColor TEXT, cardcolor TEXT, overlayColor TEXT, fontColorTitle TEXT, fontColor TEXT)')
    tx.executeSql(
                'CREATE TABLE IF NOT EXISTS Stats(id TEXT, name TEXT,data TEXT, frequency INT)')
    tx.executeSql(
                'CREATE TABLE IF NOT EXISTS TempCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,data TEXT)')
    tx.executeSql(
                'CREATE TABLE IF NOT EXISTS SavedCards(id INT UNIQUE, name TEXT,phone TEXT,email TEXT,company TEXT,data TEXT)')
    tx.executeSql(
                'CREATE TABLE IF NOT EXISTS GlobCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,data TEXT)')

    tx.executeSql(
                'CREATE TABLE IF NOT EXISTS LIBRARY (id TEXT,thedir TEXT,file TEXT,thedate TEXT,private INT,picture_index INT, base64 BLOB)')


    tx.executeSql('CREATE TABLE IF NOT EXISTS NEWS (date TEXT)');

    tx.executeSql('CREATE TABLE IF NOT EXISTS Notes (contactid TEXT,title MEDIUMTEXT ,information MEDIUMTEXT,date MEDIUMINT,origin MEDIUMINT)');

    tx.executeSql('CREATE TABLE IF NOT EXISTS announcements (id TEXT, name TEXT,type TEXT,version INT,seen INT)');

    tx.executeSql('CREATE TABLE IF NOT EXISTS chatlog (id INT UNIQUE,attendees TEXT,message TEXT,date TEXT)');
    tx.executeSql('CREATE TABLE IF NOT EXISTS chatKeys (code TEXT UNIQUE,username1 TEXT,username2 TEXT)');
    tx.executeSql('CREATE TABLE IF NOT EXISTS badges (id TEXT UNIQUE,name TEXT,img TEXT,percentage INT,date TEXT)')
});

}


function load_chat(user) {

    db.transaction(function (tx) {
     var pull = tx.executeSql("SELECT * FROM chatlog WHERE attendees LIKE '%"+user+"%'")
        var num = 0
        while( num < pull.rows.length) {
            var loc = false
            chatWindow.last = pull.rows.item(num).id
            if (pull.rows.item(num).attendees.split(",")[0] === username) {
                loc = true
            }
            chatlog.insert(0,{
                    from:pull.rows.item(num).attendees,
                    local:loc,
                    //message:simp_decrypt(ekey,pull.rows.item(num).message.replace('b"',""))
                    message:pull.rows.item(num).message
                    })
            num += 1
         }
        });
    chatList.currentIndex = 0
}


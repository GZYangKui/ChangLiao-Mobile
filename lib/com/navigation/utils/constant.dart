const double currentVersion = 0.2;
const String http = "http://";
const String domain = "polyglot.net.cn";
const int tcpPort = 7373;
const String type = "type";
const String subtype = "subtype";
const String message = "message";
const String search = "search";
const String friend = "friend";
const String messages = "messages";
const String friends = "friends";
const String user = "user";
const String request = "request";
const String response = "response";
const String delete = "delete";
const String login = "login";
const String register = "register";
const String version = "version";
const String from = "from";
const String to = "to";
const String info = "info";
const String nickname = "nickname";
const String id = "id";
const String password = "password";
const String dir = "dir";
const String host = "host";
const String body = "body";
const String accept = "accept";
const String text = "text";
const String tcp_port = "tcp-port";
const String http_port = "http-port";
const String keyword = "keyword";
const String offline = "offiline";

const String end = "\r\n";
const String messageOwn = "{[|@#\$%|]}";
const String carefree = "carefree";
const String phone = "phone";
const String mail = "mail";
const String address = "address";
const String website = "website";
const String company = "company";
const String brief = "brief";
const String status = "status";
const String data = "data";
const String createUserTable = "CREATE TABLE IF NOT EXISTS "
    "user(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
    "userName VARCHAR NOT NULL,"
    "password VARCHAR NOT NULL,"
    "brief VARCHAR)";
const String obtainUser = "SELECT userName,password FROM user";
const String addUser = " INSERT INTO user(userName,password) VALUES(?,?)";
const String createCollectionTable = "CREATE TABLE IF NOT EXISTS collects("
    "id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
    "title VARCHAR NOT NULL,"
    "url VARCHAR NOT NULL,"
    "en_brief VARCHAR NOT NULL,"
    "cn_brief VARCHAR NOT NULL,"
    "type VARCHAR NOT NULL)";
const String insertCollect =
    "INSERT INTO collects(title,url,en_brief,cn_brief,type) VALUES(?,?,?,?,?)";
const String selectCollect = ""
    "SELECT title FROM collects WHERE title=?";
const String deleteCollect = "DELETE FROM collects WHERE title = ?";

var express = require('express');
var fs = require('fs')
var favicon = require('serve-favicon');//Подключаем новый модуль
var path = require('path'); // модуль для парсинга пути
var log = require('morgan');
var app = express();
var config = require('./libs/config');
var bodyParser = require('body-parser');
var methodOverride = require('method-override');
var accessLogStream = fs.createWriteStream(__dirname + '/access.log', {flags: 'a'})
var api = require('./routes/api');

var options = {
    favicon: "./favicon.ico"
};

/*app.listen(config.get('port'), function () {
    log.info('Express server listening on port ' + config.get('port'));
});*/

//app.use(express.favicon()); // отдаем стандартную фавиконку, можем здесь же свою задать
app.use(favicon(options.favicon));//Загружаем нашу иконку
app.use(log('combined'), {stream: accessLogStream}); // выводим все запросы со статусами в консоль
app.use(bodyParser); // стандартный модуль, для парсинга JSON в запросах
app.use(methodOverride); // поддержка put и delete
app.use(express.static(path.join(__dirname, "public"))); // запуск статического файлового сервера, который смотрит на папку public/ (в нашем случае отдает index.html)

app.get('/', api);

app.listen(1337, function () {
    log.info('Express server listening on port 1337');
});

app.route();
app.use(function (req, res, next) {
    res.status(404);
    log.debug('Not found URL: %s', req.url);
    res.send({error: 'Not found'});
    return;
});

app.use(function (err, req, res, next) {
    res.status(err.status || 500);
    log.error('Internal error(%d): %s', res.statusCode, err.message);
    res.send({error: err.message});
    return;
});

app.get('/ErrorExample', function (req, res, next) {
    next(new Error('Random error!'));
});
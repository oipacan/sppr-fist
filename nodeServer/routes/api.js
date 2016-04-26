var router = require('router');

/* GET users listing. */
router.get('/', function (req, res) {
    res.json({
        msg: 'API is running'
    });
});

module.exports = router;
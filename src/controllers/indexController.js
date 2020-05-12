const controller = {};

controller.list = (req, res) => {
    res.render('index.html', {
        title: 'Trascendencias'
    });
};

module.exports = controller;
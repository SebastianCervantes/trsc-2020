const controller = {};

controller.list = (req, res) => {
    res.render('actividades.html', {
        title: 'Trascendencias'
    });
};

module.exports = controller;
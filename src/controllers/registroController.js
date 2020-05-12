const controller = {};

controller.list = (req, res) => {
    res.render('registro.html', {
        title: 'Trascendencias'
    });
};

controller.save = (req, res) =>{
    const data =req.body;
    req.getConnection((err, conn) =>{
        conn.query('INSERT INTO usuario set ? ', [data], (err, contact) =>{
            if(err){
                res.json(err);
            }
            res.redirect('/');
        });
        console.log(data);
    });
};

module.exports = controller;
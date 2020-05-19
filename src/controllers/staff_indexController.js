const controller = {};

controller.list = (req, res) => {
    req.getConnection((err, conn) =>{
        conn.query('CALL registro(?)', [data_query], (err, contact) =>{
            if(err){
                res.json(err);
                console.log(err);
                console.log(data);
                return;
            }
            res.redirect('/');
        })
    });
    res.render('indexStaff.html', {
        title: 'Staff'
    });
};

module.exports = controller;
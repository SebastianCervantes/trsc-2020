const controller = {};

controller.list = (req, res) => {
    req.getConnection((err, conn) =>{
        conn.query('CALL dashboard_queries', (err, data_dashboard) =>{
            if(err){
                res.json(err);
                console.log(err);  
                return;
            }
            console.log(data_dashboard)
            res.render('indexStaff.html', {
                data: data_dashboard[0],
                title: 'Staff'
            });
        });
    });
};

module.exports = controller;
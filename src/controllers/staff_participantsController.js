const controller = {};

controller.list = (req, res) => {
    req.getConnection((err, conn) =>{
        conn.query('CALL listado_participantes', (err, list_p) =>{
            if(err){
                res.json(err);
                console.log(err);  
                return;
            }
            console.log(list_p)
            res.render('staff_participants.html', {
                data: list_p[0],
                title: 'Staff'
            });
        });
    });
};

module.exports = controller;
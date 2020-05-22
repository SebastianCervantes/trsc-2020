const controller = {};

controller.list = (req, res) => {
    const persona = req.params.persona;
    req.getConnection((err, conn) =>{
        conn.query('CALL datos_usuario(?)',[persona], (err, data) =>{
            if(err){
                res.json(err);
                console.log(err);  
                return;
            }
            console.log(persona);
            console.log(data);
            res.render('staff_single_participant.html', {
                data: data[0],
                title: 'Staff'
            });
        });
    });
};

module.exports = controller;
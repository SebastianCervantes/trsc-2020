const controller = {};
var dateFormat = require('dateformat');
var date = dateFormat("isoDate") + 'T' + dateFormat("isoTime");

controller.list = (req, res) => {
    res.render('registro.html', {
        title: 'Trascendencias'
    });
};

controller.save = (req, res) =>{
    const data = req.body;

    const data_query = [
    data.nombre,
    data.apellidos,
    data.correo,
    data.telefono,
    data.edad,
    data.sexo,
    data.carrera,
    data.campus,
    data.sem,
    data.talla,
    data.veget,
    data.alergias,
    data.tipo,
    date,
    0,
    950,
    'Pendiente'
    ];

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
};

module.exports = controller;
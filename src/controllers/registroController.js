const controller = {};
var dateFormat = require('dateformat');

controller.list = (req, res) => {
    res.render('registro.html', {
        title: 'Trascendencias'
    });
};

controller.save = (req, res) =>{
    const data = req.body;
    // const data_query = new Object();
    // data_query.nombre = data.nombre;
    // data_query.apellidos = data.apellidos;
    // data_query.correo = data.correo;
    // data_query.telefono = data.telefono;
    // data_query.edad = data.edad;
    // data_query.sexo = data.sexo;
    // data_query.carrera = data.carrera;
    // data_query.campus = data.campus;
    // data_query.sem = data.sem;
    // data_query.talla = data.talla;
    // data_query.veget = data.veget;
    // data_query.alergias = data.alergias;
    // data_query.tipo = data.tipo;
    // data_query.fecha = dateFormat ('isoDateTime');
    // data_query.cantidad = 0;
    // data_query.deuda = 950;
    // data_query.estatus = 'Pendiente';

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
    '2020-10-03T10:20:42',
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
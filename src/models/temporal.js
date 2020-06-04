module.exports = function Cart(cart) {
    
    this.nombre = cart.nombre || null;
    this.apellidos = cart.apellidos || null;
    this.correo = cart.correo || null;
    this.telefono = cart.telefono || null;
    this.edad = cart.edad || null;
    this.sexo = cart.sexo || null;
    this.carrera = cart.carrera || null;
    this.campus = cart.campus || null;
    this.sem = cart.sem || null;
    this.talla = cart.talla || null;
    this.veget = cart.veget || null;
    this.alergias = cart.alergias || null;
    this.tipo = cart.tipo || null;

    this.add = function(nombre, apellidos, correo, telefono, edad, sexo, carrera, campus, sem, talla, veget, alergias, tipo) {
       this.nombre = nombre;
       this.apellidos = apellidos;
       this.correo = correo;
       this.telefono = telefono;
       this.edad = edad;
       this.sexo = sexo;
       this.carrera = carrera;
       this.campus = campus;
       this.sem = sem;
       this.talla = talla;
       this.veget = veget;
       this.alergias = alergias;
       this.tipo = tipo;
    };

    this.remove = function() {
        delete this.nombre;
        delete this.apellidos;
        delete this.correo;
        delete this.telefono;
        delete this.edad;
        delete this.sexo;
        delete this.carrera;
        delete this.campus;
        delete this.sem;
        delete this.talla;
        delete this.veget;
        delete this.alergias;
        delete this.tipo;
    };

    this.getData = function() {
        return [this.nombre, this.apellidos, this.correo, this.telefono, this.edad, this.sexo, this.carrera, this.campus, this.sem, this.talla, this.veget, this.alergias, this.tipo];
    };

};
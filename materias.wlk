class Alumno{
    const property carrerasInscriptas = #{}
    var property materiasAprobadas = [] 
    var property materiasInscriptas = []

    method registrarMateriaInscripta(materia){
        self.comprobarSiPuedeInscribirseAMateria(materia)
        materiasInscriptas.add(materia)
        materia.inscribirAlumno(self)
    }

    method agregarCarrera(carrera){
        carrerasInscriptas.add(carrera)
    }

    method registrarMateriaAprobada(materia, nota){
        self.comprobarSiYaEstaAprobada(materia)
        materiasAprobadas.add(new MateriaAprobada(materia = materia, nota = nota))
    }

    method cantidadDeMateriasAprobadas(){
        return materiasAprobadas.size()
    }

    method promedioEntreMateriasAprobadas(){
        return self.notasDeMateriasAprobadas().sum() / self.cantidadDeMateriasAprobadas()
    }

    method tieneAprobada(materia){
        return materiasAprobadas.map({materiaAprobada => materiaAprobada.materia()}).contains(materia)
    }

    //utils
    
    method notasDeMateriasAprobadas(){
        return materiasAprobadas.map({materia => materia.nota()})
    }

    method nombresDeMateriasAprobadas(){
        return materiasAprobadas.map({materiaAprobada => materiaAprobada.materia()})
    }

    method materiasDeLasCarreras(){
        return carrerasInscriptas.map({carrera => carrera.materiasDeLaCarrera()}).flatten()
    }

    method tieneEnCarrera(materia){
        return self.nombreDeMateriasDeCarreras().contains(materia.nombre())
    }

    method nombreDeMateriasDeCarreras(){
        return self.materiasDeLasCarreras().map({ materia => materia.nombre()})
    }

    method estaInscriptoEnMateria(materia){
        return self.nombreDeMateriasInscriptas().contains(materia.nombre())
    }

    method nombreDeMateriasInscriptas(){
        return materiasInscriptas.map({materia => materia.nombre()})
    }

    method verificarCorrelativas(materia){
        return materia.correlativas().all({ correlativa =>
        self.tieneAprobada(correlativa)
    })
    }

    method verificarSiTieneMaterias(materia1, materia2){
        return (self.nombresDeMateriasAprobadas().contains(materia1.nombre()) and self.nombresDeMateriasAprobadas().contains(materia2.nombre()))
    }

    //excepciones
    method comprobarSiYaEstaAprobada(materia){
        if(self.tieneAprobada(materia)){
            self.error("Ya se ha registrado la aprovacion de esta materia")
        }
    }

    method comprobarSiPerteneceACarrerasInscriptas(materia){
        if(!self.tieneEnCarrera(materia)){
            self.error("La materia no pertenece a ninguna carrera a la que estes inscripto")
        }
    }

    method comprobarSiYaEstaInscripto(materia){
        if(self.estaInscriptoEnMateria(materia)){
            self.error("Ya esta inscripto a esta materia")
        }
    }

    method comprobarCorrelativas(materia){
        if(!self.verificarCorrelativas(materia)){
            self.error("No tiene aprobadas las materias de esta correlativa")
        }
    }

    method comprobarSiPuedeInscribirseAMateria(materia){
        self.comprobarSiPerteneceACarrerasInscriptas(materia)
        self.comprobarSiYaEstaAprobada(materia)
        self.comprobarSiYaEstaInscripto(materia)
        self.comprobarCorrelativas(materia)
    }
}

class Carrera{
    const property materiasDeLaCarrera = #{}

    method agregarMaterias()
}

class Programacion inherits Carrera{
    
    override method agregarMaterias() {
        materiasDeLaCarrera.add(materiasFactory.crearObjetos1())
        materiasDeLaCarrera.add(materiasFactory.crearElementosDeProgramacion())
        materiasDeLaCarrera.add(materiasFactory.crearMatematica1())
        materiasDeLaCarrera.add(materiasFactory.crearObjetos2())
        materiasDeLaCarrera.add(materiasFactory.crearObjetos3())
        materiasDeLaCarrera.add(materiasFactory.crearTrabajoFinal())
        materiasDeLaCarrera.add(materiasFactory.crearBasesDeDatos())
    }

}

class Medicina inherits Carrera {
    
    override method agregarMaterias(){
        materiasDeLaCarrera.add(materiasFactory.crearQuimica())
        materiasDeLaCarrera.add(materiasFactory.crearBiologia1())
        materiasDeLaCarrera.add(materiasFactory.crearBiologia2())
        materiasDeLaCarrera.add(materiasFactory.crearAnatomiaGeneral())
    }
    
}

class Derecho inherits Carrera{

    override method agregarMaterias(){
        materiasDeLaCarrera.add(materiasFactory.crearLatin())
        materiasDeLaCarrera.add(materiasFactory.crearDerechoRomano())
        materiasDeLaCarrera.add(materiasFactory.crearHistoriaDelDerechoArgentino())
        materiasDeLaCarrera.add(materiasFactory.crearDerechoPenal1())
        materiasDeLaCarrera.add(materiasFactory.crearDerechoPenal2())
    }
}

class MateriaAprobada{
    var property materia = Materia
    var property nota = 0
}

class Materia{
    var property nombre = "";
    var property cuposDisponibles = 1
    const property alumnosInscriptos = []
    const property listaDeEspera = []
    const property correlativas = []

    method inscribirAlumno(alumno){
        if(cuposDisponibles > alumnosInscriptos.size()){
            self.alumnosInscriptos().add(alumno)
        } else{
            self.listaDeEspera().add(alumno)
        }
    }

    method darDeBajaAlAlumno(alumno) {
        self.alumnosInscriptos().remove(alumno)
        
        if (!self.listaDeEspera().isEmpty()) {
            const siguienteEnEspera = self.listaDeEspera().get(0)
            self.alumnosInscriptos().add(siguienteEnEspera)
            self.listaDeEspera().remove(siguienteEnEspera)
        }
    }

    
}

object materiasFactory {
    
    method crearObjetos1() {
        return new Materia(nombre = "Objetos 1")
    }

    method crearElementosDeProgramacion() {
        return new Materia(nombre = "Elementos de Programación")
    }

    method crearMatematica1() {
        return new Materia(nombre = "Matemática 1")
    }

    method crearObjetos2() {
        return new Materia(nombre = "Objetos 2", correlativas = [self.crearObjetos1(), self.crearMatematica1()], cuposDisponibles = 3)
    }

    method crearObjetos3() {
        return new Materia(nombre = "Objetos 3", correlativas = [self.crearObjetos2(), self.crearBasesDeDatos()])
    }

    method crearTrabajoFinal() {
        return new Materia(nombre = "Trabajo Final")
    }

    method crearBasesDeDatos() {
        return new Materia(nombre = "Bases de Datos")
    }

    method crearQuimica() {
        return new Materia(nombre = "Química")
    }

    method crearBiologia1() {
        return new Materia(nombre = "Biología 1")
    }

    method crearBiologia2() {
        return new Materia(nombre = "Biología 2", correlativas = [self.crearBiologia1()])
    }

    method crearAnatomiaGeneral() {
        return new Materia(nombre = "Anatomía General")
    }

    method crearLatin() {
        return new Materia(nombre = "Latín")
    }

    method crearDerechoRomano() {
        return new Materia(nombre = "Derecho Romano")
    }

    method crearHistoriaDelDerechoArgentino() {
        return new Materia(nombre = "Historia del Derecho Argentino")
    }

    method crearDerechoPenal1() {
        return new Materia(nombre = "Derecho Penal 1")
    }

    method crearDerechoPenal2() {
        return new Materia(nombre = "Derecho Penal 2")
    }
}
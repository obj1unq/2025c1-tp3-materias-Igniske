class Alumno{
    const carrerasInscriptas = #{}
    var property materiasAprobadas = [] 

    method registrarMateriaAprobada(materia, nota){
        self.comprobarYaSiExiste(materia)
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

    //excepciones
    method comprobarYaSiExiste(materia){
        if(self.tieneAprobada(materia)){
            self.error("Ya se ha registrado la aprovacion de esta materia")
        }
    }
}

//Dudas a consultar
/*
1) tengo que utilizar inherits para crear Programacion, Medicina y Derecho y pasarles las materias? o con crear los objetos en una variable
y pasarle las materias es suficiente?
2) tengo que definir cada instancia de Materia aca? O solo para los tests?
*/

class Carrera{
    var materiasDeLaCarrera


}

class Programacion inherits Carrera{

}

class MateriaAprobada{
    var property materia = Materia
    var property nota = 0
}



class Materia{
    var property nombre = "";
}
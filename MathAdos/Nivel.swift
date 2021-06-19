//
//  Nivel.swift
//  MathAdos
//
//  Created by Sebastian San Blas on 18/06/2021.
//

import Foundation

class Nivel {
    
    func avanzarNivel(nivel: Int,
                      aciertos: Int) -> (nivelNuevo: Int,
                                              contador: Int){
        var nivelNuevo = nivel
        var contador = aciertos
        
        if contador < 5 {
            contador += 1
        }
        if contador == 5 {
            nivelNuevo += 1
            print("Subiendo de nivel")
            contador = 0
        }
        return (nivelNuevo, contador)
    }
        
}

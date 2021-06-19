//
//  Generadores.swift
//  MathAdos
//
//  Created by Sebastian San Blas on 18/06/2021.
//

import Foundation

class Generadores {
    
    func generadorProblema(nivel: Int) -> (operador: String,
                                           salida1: Int,
                                           salida2: Int) {
        var operador: String = "+"
        var salida1: Int = 0
        var salida2: Int = 0

        switch nivel {
        // Nivel 1 - 1+1
        case 1:
            salida1 = Int.random(in: 0..<10)
            salida2 = Int.random(in: 0..<10)
        // Nivel 2 - 10+1
        case 2:
            salida1 = Int.random(in: 0..<10)
            salida2 = Int.random(in: 10..<100)
        // Nivel 3 - 10+10 [10 a 25]
        case 3:
            salida1 = Int.random(in: 10...25)
            salida2 = Int.random(in: 10...50)
        // Nivel 4 - 99+50 [10 a 99]
        case 4:
            salida1 = Int.random(in: 10...99)
            salida2 = Int.random(in: 10...99)
        // Nivel 5 - [1 a 99] * [0 a 10]
        case 5:
            salida1 = Int.random(in: 0...99)
            salida2 = Int.random(in: 0...9)
            operador = "*"
        // Nivel 6 - [100 a 999] + [0 a 99]
        case 6:
            salida1 = Int.random(in: 100...999)
            salida2 = Int.random(in: 0...99)
        // Nivel 7 - [100 a 999] + [100 a 999]
        case 7:
            salida1 = Int.random(in: 100...999)
            salida2 = Int.random(in: 100...999)
        default:
            salida1 = Int.random(in: 999...9999)
            salida2 = Int.random(in: 999...9999)
        }
        return (operador, salida1, salida2)
    }
    
    func respuestaCorrectaFc(nivel: Int) -> (operador: String,
                                             salida1: Int,
                                             salida2: Int,
                                             respuesta: String) {
        var respuesta: String
        var operador: String
        var salida1: Int = 0
        var salida2: Int = 0
        (operador, salida1, salida2) = generadorProblema(nivel: nivel)
        switch operador {
        case "*":
            respuesta = String(salida1*salida2)
        default:
            respuesta = String(salida1+salida2)
        }
        return (operador, salida1, salida2, respuesta)
    }
    
    func respuestaTotalmenteIncorrectaFc(respuestaCorrecta: String) -> String {
        var respuesta: String
        respuesta = String((Int(respuestaCorrecta) ?? 0) + Int.random(in: -100...100))
//        print("La respuesta totalmente incorrecta es \(respuesta)") // debug
        while respuesta == respuestaCorrecta {
//            print("Respuesta repetida") // debug
            respuesta = String((Int(respuestaCorrecta) ?? 0) + Int.random(in: -100...100))
//            print(respuesta) // debug
        }
        return respuesta
    }
    
    func respuestaCercanaFc(respuestaCorrecta: String) -> String {
        var respuesta: String
        respuesta = String((Int(respuestaCorrecta) ?? 0) + Int.random(in: -10...10))
//        print("La respuesta incorrecta es \(respuesta)")
        while respuesta == respuestaCorrecta {
//            print("Respuesta repetida") // debug
            respuesta = String((Int(respuestaCorrecta) ?? 0) + Int.random(in: -10...10))
//            print(respuesta) // debug
        }
        return respuesta
    }
}

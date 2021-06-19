//
//  Vidas.swift
//  MathAdos
//
//  Created by Sebastian San Blas on 18/06/2021.
//

import Foundation

class Vidas {
    
    func perderVida(vidas: Int) -> (Int, Int) {
        return (vidas - 1, 0)
    }
    
    func ganarVida(vidas: Int,
                   aciertos: Int) -> (vidaNueva: Int,
                                      aciertosSalida: Int) {
        var vidaNueva = vidas
        var aciertoSalida = aciertos
        if vidas < 3 {
            if aciertos < 5 {
                aciertoSalida = aciertos + 1
                print("Acierto nº \(aciertoSalida)")
            }
            if aciertoSalida == 5 {
                vidaNueva = vidas + 1
                print("Vida gana \(vidaNueva)")
                aciertoSalida = 0
            }
        }
        return (vidaNueva,aciertoSalida)
    }
}

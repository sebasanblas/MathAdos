//
//  ViewController.swift
//  MathAdos
//
//  Created by Sebastian San Blas on 16/06/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // Var iniciales
    var timer:Timer?
    var seconds = 60
    var life = 3
    var nivel = 1
    var respuestaGlobal = ""
    var salidaUno = ""
    var salidaDos = ""
    var salidaTres = ""
    var salidaCuatro = ""
    
    // Debug
    
    
    @IBAction func debugbutton(_ sender: UIButton) {
        
        
        generadorProblemaField(nivel: nivel)
        
        
    }
    
    
    
    // Vidas
    @IBOutlet var vidaUno: UIButton!
    @IBOutlet var vidaDos: UIButton!
    @IBOutlet var vidaTres: UIButton!
    // Nivel
    @IBOutlet var levelField: UILabel!
    // Tiempo
    @IBOutlet var timeField: UILabel!
    //
    @IBOutlet var NumerosField: UILabel!
    // Opciones de respuestas
    @IBOutlet var opcionUno: UIButton!
    @IBOutlet var opcionDos: UIButton!
    @IBOutlet var opcionTres: UIButton!
    @IBOutlet var opcionCuatro: UIButton!
    // Status
    @IBOutlet var statusField: UIImageView!
    // Respuestas
    @IBAction func responderUno(_ sender: Any) {
        checkRespuesta(input: salidaUno)
    }
    @IBAction func responderDos(_ sender: Any) {
        checkRespuesta(input: salidaDos)
    }
    @IBAction func responderTres(_ sender: Any) {
        checkRespuesta(input: salidaTres)
    }
    @IBAction func responderCuatro(_ sender: Any) {
        checkRespuesta(input: salidaCuatro)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Clean Status
        statusField.isHidden = true
        // Vidas
        contadorVidas()
        // Nivel
        contadorNivel()
        // Tiempo
        contadorTiempo()
        
        // Comienzo
        
        generadorProblemaField(nivel: nivel)
        
    }
    
    func contadorVidas() {
        switch life {
        case 3:
            vidaUno.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            vidaDos.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            vidaTres.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        case 2:
            vidaTres.setImage(UIImage(systemName: "heart"), for: .normal)
        case 1:
            vidaDos.setImage(UIImage(systemName: "heart"), for: .normal)
        default:
            vidaUno.setImage(UIImage(systemName: "heart"),for: .normal)
        }
    }
    
    func contadorNivel() {
        levelField?.text = "Level: " + String(nivel)
    }
    
    func contadorTiempo() {

        let min = (seconds / 60) % 60
        let sec = seconds % 60

        timeField?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
    }

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
        print("La respuesta totalmente incorrecta es \(respuesta)") // debug
        while respuesta == respuestaCorrecta {
            print("Respuesta repetida") // debug
            respuesta = String((Int(respuestaCorrecta) ?? 0) + Int.random(in: -100...100))
            print(respuesta)
        }
        return respuesta
    }
    
    func respuestaCercanaFc(respuestaCorrecta: String) -> String {
        var respuesta: String
        respuesta = String((Int(respuestaCorrecta) ?? 0) + Int.random(in: -10...10))
        print("La respuesta incorrecta es \(respuesta)")
        while respuesta == respuestaCorrecta {
            print("Respuesta repetida") // debug
            respuesta = String((Int(respuestaCorrecta) ?? 0) + Int.random(in: -10...10))
            print(respuesta)
        }
        return respuesta
    }
    
    func generadorProblemaField(nivel: Int) {
        var output, operador, respuesta: String
        var salida1, salida2: Int
        var lista: [String] = []
        //Correcto
        (operador, salida1, salida2, respuesta) = respuestaCorrectaFc(nivel: nivel)
        output = String(salida1) + " " + operador + " " + String(salida2)
        NumerosField?.text = output
        print("La respuesta correcta es \(respuesta)") //debug
        respuestaGlobal = respuesta
        // Valores listados
        lista.append(respuesta)
        lista.append(respuestaTotalmenteIncorrectaFc(respuestaCorrecta: respuesta))
        lista.append(respuestaCercanaFc(respuestaCorrecta: respuesta))
        lista.append(respuestaCercanaFc(respuestaCorrecta: respuesta))
        lista.shuffle()

        salidaUno = lista[0]
        salidaDos = lista[1]
        salidaTres = lista[2]
        salidaCuatro = lista[3]
        
        respuestasField()
    }
    
    func respuestasField() {
        opcionUno.setTitle(salidaUno, for: .normal)
        opcionDos.setTitle(salidaDos, for: .normal)
        opcionTres.setTitle(salidaTres, for: .normal)
        opcionCuatro.setTitle(salidaCuatro, for: .normal)
    }
    func showIcon(_ input: Bool) {
        if input == true {
            statusField?.image = UIImage(systemName: "checkmark.circle.fill")
            statusField.tintColor = .systemGreen
        }
        else {
            statusField.image = UIImage(systemName: "multiply.circle.fill")
            statusField.tintColor = .systemRed
        }
        statusField.isHidden = false
        UIView.animate(withDuration: 1, delay: 0.5, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
            self.statusField.alpha = 0
        }, completion: { finished in
            self.statusField.isHidden = true
            self.statusField.alpha = 1
        })
    }
    
    func checkRespuesta(input: String) {
        if input == respuestaGlobal {
            showIcon(true)
        }
        else {
            showIcon(false)
        }
    }
}

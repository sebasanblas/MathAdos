//
//  ViewController.swift
//  MathAdos
//
//  Created by Sebastian San Blas on 16/06/2021.
//

import UIKit

class MainViewController: UIViewController {

    // Instancia
    var generadores = Generadores()
    var vidas = Vidas()
    var niveles = Nivel()
    var notificacion = Notificacion()
    // Var iniciales
    var respuestaGlobal = ""
    var salidaUno = ""
    var salidaDos = ""
    var salidaTres = ""
    var salidaCuatro = ""
    
    var timer:Timer?
    var seconds = 60
    
    var life = 3
    var contadorvidas = 0

    var nivel = 1
    var contadornivel = 0

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
        Main(input: salidaUno)
    }
    @IBAction func responderDos(_ sender: Any) {
        Main(input: salidaDos)
    }
    @IBAction func responderTres(_ sender: Any) {
        Main(input: salidaTres)
    }
    @IBAction func responderCuatro(_ sender: Any) {
        Main(input: salidaCuatro)
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
            vidaUno.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            vidaDos.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            vidaTres.setImage(UIImage(systemName: "heart"), for: .normal)
        case 1:
            vidaUno.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            vidaDos.setImage(UIImage(systemName: "heart"), for: .normal)
            vidaTres.setImage(UIImage(systemName: "heart"), for: .normal)
        default:
            vidaUno.setImage(UIImage(systemName: "heart"), for: .normal)
            vidaDos.setImage(UIImage(systemName: "heart"), for: .normal)
            vidaTres.setImage(UIImage(systemName: "heart"), for: .normal)
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
    
    func generadorProblemaField(nivel: Int) {
        var output, operador, respuesta: String
        var salida1, salida2: Int
        var lista: [String] = []
        //Correcto
        (operador, salida1, salida2, respuesta) = generadores.respuestaCorrectaFc(nivel: nivel)
        output = String(salida1) + " " + operador + " " + String(salida2)
        NumerosField?.text = output
//        print("La respuesta correcta es \(respuesta)") //debug
        respuestaGlobal = respuesta
        // Valores listados
        lista.append(respuesta)
        lista.append(generadores.respuestaTotalmenteIncorrectaFc(respuestaCorrecta: respuesta))
        lista.append(generadores.respuestaCercanaFc(respuestaCorrecta: respuesta))
        lista.append(generadores.respuestaCercanaFc(respuestaCorrecta: respuesta))
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
    
    func Main(input: String) {
        timeContador()
        if input == respuestaGlobal {
            showIcon(true)
            (life, contadorvidas) = vidas.ganarVida(vidas: life, aciertos: contadorvidas)
            (nivel, contadornivel, seconds) = niveles.avanzarNivel(nivel: nivel, aciertos: contadornivel, segundos: seconds)
        }
        else {
            showIcon(false)
            (life, contadorvidas) = vidas.perderVida(vidas: life)
            if life == 0 {
                finishGame()
            }
        }
        contadorVidas()
        contadorNivel()
        contadorTiempo()
        generadorProblemaField(nivel: nivel)
    }
    
    func updateTimeLabel() {

        let min = (seconds / 60) % 60
        let sec = seconds % 60

        timeField?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
    }

}

extension MainViewController {

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
        UIView.animate(withDuration: 0.15, delay: 0.25, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
            self.statusField.alpha = 0
        }, completion: { finished in
            self.statusField.isHidden = true
            self.statusField.alpha = 1
        })
    }
    
    func finishGame() {
        timer?.invalidate()
        timer = nil
        
        notificacion.endGame(nivel: nivel)
        generadorProblemaField(nivel: nivel)

        nivel = 1
        life = 3
        seconds = 60
        
        contadorVidas()
        contadorNivel()
        contadorTiempo()
    }
    
    func timeContador() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                
                if self.seconds == 0 {
                    self.finishGame()
                } else if self.seconds > 0 {
                    self.seconds -= 1
                    self.updateTimeLabel()
                }
            }
        }
    }
}

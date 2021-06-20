//
//  Notification.swift
//  MathAdos
//
//  Created by Sebastian San Blas on 19/06/2021.
//

import UIKit
import SwiftMessages

class Notificacion {
    
    func endGame(nivel: Int) {
        let messageView: MessageView = MessageView.viewFromNib(layout: .centeredView)
        messageView.configureBackgroundView(width: 350)
        messageView.configureContent(title: "Hey!", body: "Lograste llegar al nivel \(nivel).", iconImage: nil, iconText: "👻", buttonImage: nil, buttonTitle: "¡Jugar de vuelta!") { _ in
            SwiftMessages.hide()
        }
        messageView.backgroundView.backgroundColor = UIColor.init(white: 0.97, alpha: 1)
        messageView.backgroundView.layer.cornerRadius = 10
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.presentationContext  = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: config, view: messageView)
    }
}

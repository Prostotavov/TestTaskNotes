//
//  ViewController.swift
//  TestTaskNotes
//
//  Created by Роман Сенкевич on 4.12.22.
//

import UIKit

class ViewController: UIViewController {
    
    let backHeight: CGFloat = 170

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBackgroundView()
    }
    
    private func setupBackgroundView() {
        let backgroundViewBack = BackgroundView()
        backgroundViewBack.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: backHeight)
        backgroundViewBack.fillColor = Colors.LightMode.lightGreen
        backgroundViewBack.backgroundColor = .clear
        view.addSubview(backgroundViewBack)
        
        let backgroundViewFront = BackgroundView()
        backgroundViewFront.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: backHeight)
        backgroundViewFront.transform = CGAffineTransform(scaleX: -1, y: 1)
        backgroundViewFront.fillColor = Colors.LightMode.darkGreen
        backgroundViewFront.backgroundColor = .clear
        view.addSubview(backgroundViewFront)
    }

}


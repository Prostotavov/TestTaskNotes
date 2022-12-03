//
//  ViewController.swift
//  TestTaskNotes
//
//  Created by Роман Сенкевич on 4.12.22.
//

import UIKit

class ViewController: UIViewController {
    
    let backHeight: CGFloat = 170
    let backgroundViewBack = BackgroundView()
    let backgroundViewFront = BackgroundView()
    let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBackgroundView()
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        backgroundViewFront.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: backgroundViewFront.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backgroundViewFront.centerYAnchor),
        ])
        titleLabel.text = "Заметки"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        titleLabel.transform = CGAffineTransform(scaleX: -1, y: 1)
        titleLabel.textColor = .white
    }
    
    private func setupBackgroundView() {
        backgroundViewBack.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: backHeight)
        backgroundViewBack.fillColor = Colors.LightMode.lightGreen
        backgroundViewBack.backgroundColor = .clear
        view.addSubview(backgroundViewBack)
        
        backgroundViewFront.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: backHeight)
        backgroundViewFront.transform = CGAffineTransform(scaleX: -1, y: 1)
        backgroundViewFront.fillColor = Colors.LightMode.darkGreen
        backgroundViewFront.backgroundColor = .clear
        view.addSubview(backgroundViewFront)
    }

}


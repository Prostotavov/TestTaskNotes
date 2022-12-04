//
//  ExpandableCell.swift
//  TestTaskNotes
//
//  Created by Роман Сенкевич on 4.12.22.
//

import UIKit


struct CellData {
    var tittle: String
    var content: String
}

class ExpandableCell: UITableViewCell {
    
    var data: CellData? {
        didSet {
            guard let data = data else {return}
            self.tittle.text = data.tittle
            self.shortTittle.text = String(data.content.prefix(15))
            self.content.text = data.content
        }
    }
    
    fileprivate let tittle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let shortTittle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let content: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        container.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        
        container.addSubview(tittle)
        NSLayoutConstraint.activate([
            tittle.topAnchor.constraint(equalTo: container.topAnchor),
            tittle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            tittle.trailingAnchor.constraint(equalTo: container.centerXAnchor),
            tittle.heightAnchor.constraint(equalToConstant: self.frame.height)
        ])
        
        container.addSubview(shortTittle)
        NSLayoutConstraint.activate([
            shortTittle.topAnchor.constraint(equalTo: container.topAnchor),
            shortTittle.leadingAnchor.constraint(equalTo: container.centerXAnchor),
            shortTittle.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            shortTittle.heightAnchor.constraint(equalToConstant: self.frame.height)
        ])
        
        container.addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: tittle.bottomAnchor, constant: 15),
            content.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            content.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // MARK: Animation
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.container.layoutIfNeeded()
        }
    }
}

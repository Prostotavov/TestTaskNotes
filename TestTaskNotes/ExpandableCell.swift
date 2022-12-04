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

    
    var isExpanded: Bool? {
        didSet {
            if isExpanded == true {
                bottomLineView.isHidden = false
            } else {
                bottomLineView.isHidden = true
            }
        }
    }
    
    let distanceFromContentLabelAndHeaderView: CGFloat = 15
    let distanceFromEdgesAndContent: CGFloat = 40
    var rowSize: CGSize!
    
    var contentHeight: CGFloat? {
        let heightLine = UILabel.textSize(font: contentLabel.font, text: contentLabel.text ?? "").height
        let lineCount = ceil(contentLabel.textWidth() / rowSize.width)
        return heightLine * lineCount + distanceFromContentLabelAndHeaderView
    }
    
    var data: CellData? {
        didSet {
            guard let data = data else {return}
            self.tittleLabel.text = data.tittle
            self.shortDescriptionLabel.text = String(data.content.prefix(15))
            self.contentLabel.text = data.content
        }
    }
    
    fileprivate let tittleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let backHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    fileprivate let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        return view
    }()
    
    fileprivate let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    fileprivate let chevronView: UIImageView = {
        let image = UIImage(systemName: "chevron.down")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate let bottomLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        return button
    }()
    
    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainerView()
        setupTittleLabel()
        setupShortDescriptionLabel()
        setupContentLabel()
    }
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, rowSize: CGSize) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.rowSize = rowSize
        
        setupContainerView()
        setupBackHeaderView()
        setupHeaderView(rowSize: rowSize)
        setupDeleteButton()
        setupLineView()
        setupTittleLabel()
        setupShortDescriptionLabel()
        setupContentLabel()
        setupChevronView()
        setupBottomLineView()
    }
    

    
    //MARK: constraints
    
    fileprivate func setupContainerView() {
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    fileprivate func setupBackHeaderView() {
        containerView.addSubview(backHeaderView)
        NSLayoutConstraint.activate([
            backHeaderView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            backHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backHeaderView.widthAnchor.constraint(equalToConstant: rowSize.width),
            backHeaderView.heightAnchor.constraint(equalToConstant: rowSize.height),
        ])
        backHeaderView.transform = CGAffineTransform(scaleX: 0.87, y: 0.87)
    }
    
    var headerXAnchor : NSLayoutConstraint = NSLayoutConstraint()
    
    fileprivate func setupHeaderView(rowSize: CGSize) {
        backHeaderView.addSubview(headerView)
        
        
        headerXAnchor = headerView.centerXAnchor.constraint(equalTo: backHeaderView.centerXAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: backHeaderView.topAnchor),
            headerView.bottomAnchor.constraint(equalTo: backHeaderView.bottomAnchor),
            headerView.widthAnchor.constraint(equalTo: backHeaderView.widthAnchor),
            headerXAnchor,
        ])
    }
    
    fileprivate func setupTittleLabel() {
        headerView.addSubview(tittleLabel)
        NSLayoutConstraint.activate([
            tittleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            tittleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            tittleLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            tittleLabel.heightAnchor.constraint(equalToConstant: self.frame.height)
        ])
    }
    
    fileprivate func setupShortDescriptionLabel() {
        headerView.addSubview(shortDescriptionLabel)
        NSLayoutConstraint.activate([
            shortDescriptionLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            shortDescriptionLabel.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 15),
            shortDescriptionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            shortDescriptionLabel.heightAnchor.constraint(equalToConstant: self.frame.height)
        ])
    }
    
    fileprivate func setupContentLabel() {
        containerView.addSubview(contentLabel)
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: tittleLabel.bottomAnchor, constant: distanceFromContentLabelAndHeaderView),
            contentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: distanceFromEdgesAndContent),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -distanceFromEdgesAndContent),
        ])
    }
    
    fileprivate func setupLineView() {
        headerView.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            lineView.centerXAnchor.constraint(equalTo: headerView.leadingAnchor, constant: rowSize.width / 3),
            lineView.widthAnchor.constraint(equalToConstant: 1.5),
            lineView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.7)
        ])
    }
    
    fileprivate func setupChevronView() {
        headerView.addSubview(chevronView)
        NSLayoutConstraint.activate([
            chevronView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            chevronView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
        ])
    }
    
    fileprivate func setupBottomLineView() {
        containerView.addSubview(bottomLineView)
        NSLayoutConstraint.activate([
            bottomLineView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomLineView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1),
            bottomLineView.widthAnchor.constraint(equalToConstant: self.frame.width),
        ])
        bottomLineView.isHidden = true
    }
    
    fileprivate func setupDeleteButton() {
        backHeaderView.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.trailingAnchor.constraint(equalTo: backHeaderView.trailingAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: headerView.trailingAnchor),
            deleteButton.topAnchor.constraint(equalTo: backHeaderView.topAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: backHeaderView.bottomAnchor),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

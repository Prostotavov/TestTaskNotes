//
//  ViewController.swift
//  TestTaskNotes
//
//  Created by Роман Сенкевич on 4.12.22.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let backgroundViewBack = BackgroundView()
    let backgroundViewFront = BackgroundView()
    let titleLabel = UILabel()
    
    
    let mockData = [CellData(tittle: "1 1 1", content: "one one one"),
                    CellData(tittle: "2 2 2", content: "two two two "),
                    CellData(tittle: "3 3 3", content: "three three three "),]
    
    let backHeight: CGFloat = 170
    var selectedIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBackgroundView()
        setupTitleLabel()
        setupTableView()
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



extension ViewController: UITableViewDelegate, UITableViewDataSource {

    
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: backgroundViewFront.bottomAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        tableView.separatorStyle = .none
        tableView.register(ExpandableCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath {
            return 200
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExpandableCell
        cell.data = mockData[indexPath.row]
        cell.selectionStyle = .none
        cell.animate()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        tableView.beginUpdates()
        tableView.reloadRows(at: [selectedIndex!], with: .none)
        tableView.endUpdates()
    }
    
}

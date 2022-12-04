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
    
    
    var mockData = [CellData(tittle: "1 1 1", content: "one one one"),
                    CellData(tittle: "2 2 2", content: "two two two "),
                    CellData(tittle: "3 3 3", content: "three three three dfsf f sdf sadf sadf asdf ds fds f asdf ghfhjf ghfhfhfhgf fghf hf hf gf hjgfghfhg fg fghf hgf hjfhgf hfgh fh gfhg fjhg fjhg fjhg fjg fjgf jghf jgf jf hgjf ghf hjf hgf hgf jhfg hgf hj fhjgf hg f"),]
    
    let backHeight: CGFloat = 170
    var rowSize: CGSize!
    var selectedIndex: IndexPath?

    override func viewDidLoad() {
        
        rowSize = CGSize(width: view.frame.width, height: 50)
        
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
            guard let cell = tableView.cellForRow(at: indexPath) as? ExpandableCell else {return rowSize.height}
            return cell.contentHeight! + rowSize.height + 20 
        }
        return rowSize.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ExpandableCell(style: .default, reuseIdentifier: "cell", rowSize: rowSize)
        cell.data = mockData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let oldCell = tableView.cellForRow(at: indexPath) as? ExpandableCell
        
        if oldCell?.isExpanded == true {
            selectedIndex = nil
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.endUpdates()
        } else {
            selectedIndex = indexPath
            tableView.beginUpdates()
            tableView.reloadRows(at: [selectedIndex!], with: .none)
            tableView.endUpdates()
            let cell = tableView.cellForRow(at: indexPath) as? ExpandableCell
            cell?.isExpanded = true
        }
    }
    
}

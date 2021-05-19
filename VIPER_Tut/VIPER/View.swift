//
//  View.swift
//  VIPER_Tut
//
//  Created by Sukumar Anup Sukumaran on 19/05/21.
//

import Foundation
import UIKit

//ViewController
//Protocol
//reference presenter

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController {
    
    var presenter: AnyPresenter?
    var users: [User] = []
    
    private let tableVw: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .systemBlue
        view.addSubview(tableVw)
        tableVw.delegate = self
        tableVw.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableVw.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
}

extension UserViewController: AnyView {
    
    func update(with users: [User]) {
        print("Got data")
        DispatchQueue.main.async {
            self.users = users
            self.tableVw.reloadData()
            self.tableVw.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.label.text = error
            self.tableVw.isHidden = true
            self.label.isHidden = false
        }
    }
    
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
}

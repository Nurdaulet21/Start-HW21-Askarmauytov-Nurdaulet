//
//  ViewController.swift
//  hw21
//
//  Created by Нурдаулет on 17.11.2023.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    private var cards = [CardInfo]()
    
    // MARK: - UI
    private lazy var cardsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.indentifier)
        tableView.backgroundColor = .systemCyan
        return tableView
        
    }()
    // MARK: - LifeCycle Hierarchy
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cards"
        setupViews()
        fetchData()
    }
    
    private func setupViews() {
        view.addSubview(cardsTableView)
        cardsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - Fetch Data
    private func fetchData() {
        AF.request("https://api.magicthegathering.io/v1/cards")
            .validate()
            .responseDecodable(of: CardResponse.self) { response in
                switch response.result {
                case .success(let cardResponse):
                    DispatchQueue.main.async {
                        self.cards = cardResponse.cards
                        self.cardsTableView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
    
}
    // MARK: - TableView options
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.indentifier, for: indexPath) as! TableViewCell
        let card = cards[indexPath.row]
        cell.configure(card: card)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cards[indexPath.row]
        showDetailModal(for: card)
    }
    
    func showDetailModal(for card: CardInfo) {
        let detailVC = DetailViewController(card: card)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

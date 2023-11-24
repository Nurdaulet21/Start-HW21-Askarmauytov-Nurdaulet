//
//  ViewController.swift
//  hw21
//
//  Created by Нурдаулет on 17.11.2023.
//

import UIKit
import Alamofire
import SnapKit

final class ViewController: UIViewController {
    private var cards = [CardInfo]()

    // MARK: - UI
    private lazy var cardsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.indentifier)
        tableView.backgroundColor = .white
        return tableView
    }()

    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.placeholder = "Card name..."
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .systemGray6
        return textField
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Search", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttoTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - LifeCycle Hierarchy
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraint()
        fetchData()
    }

    private func setupViews() {
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(cardsTableView)
        title = "Cards"
        view.backgroundColor = .white
    }

    private func setupConstraint() {
        
        let guide = view.safeAreaLayoutGuide

        searchTextField.snp.makeConstraints { make in
            make.left.equalTo(guide.snp.left).offset(20)
            make.top.equalTo(guide.snp.top).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(250)
        }

        searchButton.snp.makeConstraints { make in
            make.left.equalTo(searchTextField.snp.right).offset(30)
            make.top.equalTo(guide.snp.top).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(70)
        }

        cardsTableView.snp.makeConstraints { make in
            make.left.equalTo(guide)
            make.top.equalTo(searchTextField.snp.bottom).offset(15)
            make.right.equalTo(guide)
            make.bottom.equalToSuperview()
        }



    }

    // MARK: - Fetch Data
    private func fetchData(cardName: String? = nil) {
        var requestURL = "https://api.magicthegathering.io/v1/cards"

        // Append cardName parameter if provided
        if let cardName = cardName, !cardName.isEmpty {
            requestURL += "?name=\(cardName)"
        }
        AF.request(requestURL)
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

    @objc func buttoTapped() {
        guard let cardName = searchTextField.text, !cardName.isEmpty else {
            showAlert(message: "Please enter a card name")
            return
        }
        fetchData(cardName: cardName)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

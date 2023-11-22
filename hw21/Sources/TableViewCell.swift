//
//  TableViewCell.swift
//  hw21
//
//  Created by Нурдаулет on 17.11.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let indentifier = "TableViewCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()

    private let manaCostLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()

    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(manaCostLabel)
        contentView.addSubview(typeLabel)
    }

    private func setupConstraint() {
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.height.equalTo(30)
        }

        manaCostLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel).offset(100)
            make.height.equalTo(30)
        }
    }

    func configure(card: CardInfo) {
        nameLabel.text = card.name
        manaCostLabel.text = "Mana Cost: \(card.manaCost ?? "")"
        typeLabel.text = "Type: \(card.type ?? "")"
    }
}

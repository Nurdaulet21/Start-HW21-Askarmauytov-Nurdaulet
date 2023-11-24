//
//  DetailViewController.swift
//  hw21
//
//  Created by Нурдаулет on 19.11.2023.
//

import UIKit

final class DetailViewController: UIViewController {

    var card: CardInfo

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .systemCyan
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    init(card: CardInfo) {
        self.card = card
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraint()
        cardInfo(card: card)
    }

    private func setupViews() {
        view.addSubview(label)
        title = card.name
        view.backgroundColor = .white
    }

    private func setupConstraint() {
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
    }

   private func cardInfo(card: CardInfo ) {
        label.text = card.text
       }
}


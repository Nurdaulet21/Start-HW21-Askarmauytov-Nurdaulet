//
//  DetailViewController.swift
//  hw21
//
//  Created by Нурдаулет on 19.11.2023.
//

import UIKit

class DetailViewController: UIViewController {

    var card: CardInfo

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .systemCyan
        label.font = UIFont.systemFont(ofSize: 10)
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
        title = card.name
        label.text = card.setName
        view.backgroundColor = .white
    }
}


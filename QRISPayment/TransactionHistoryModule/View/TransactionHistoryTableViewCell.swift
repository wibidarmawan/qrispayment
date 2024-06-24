//
//  TransactionHistoryTableViewCell.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 24/06/24.
//

import UIKit

class TransactionHistoryTableViewCell: UITableViewCell {
    
    private let merchantNameLabel = {
        let label = UILabel()
        label.text = "Nama Merchant: "
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let transactionAmountLabel = {
        let label = UILabel()
        label.text = "Nominal Transaksi: "
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.spacing = Spacing.xxs
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    var cellModel: PaymentItemModel? {
        didSet {
            guard let cellModel = cellModel else { return }
            updateUI(cellModel)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews(
            merchantNameLabel,
            transactionAmountLabel
        )
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Spacing.l)
            make.top.bottom.equalToSuperview().inset(Spacing.xxs)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func updateUI(_ cellModel: PaymentItemModel) {
        merchantNameLabel.text = "Nama Merchant: \(cellModel.merchantName)"
        transactionAmountLabel.text = "Nominal Transaksi: Rp\(cellModel.transactionAmount.thousandSeparator())"
    }
}

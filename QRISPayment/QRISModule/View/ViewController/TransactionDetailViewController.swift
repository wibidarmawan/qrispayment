//
//  TransactionDetailViewController.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit
import CoreData

class TransactionDetailViewController: UIViewController {
    
    // MARK: - Views
    
    private let bankNameLabel = {
        let label = UILabel()
        label.text = "Nama Bank: "
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let transactionIDLabel = {
        let label = UILabel()
        label.text = "ID Transaksi: "
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
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
        stackView.spacing = Spacing.m
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var payButton = {
        let button = UIButton()
        button.setTitle("Bayar", for: .normal)
        button.backgroundColor = .primary
        button.setTitleColor(.black, for: .normal)
        button.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapPayButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Properties
    
    var presenter: TransactionDetailPresenterProtocol?
    
    override func viewDidLoad() {
        baseConfigure()
        setupConstraints()
        presenter?.viewDidLoad()
    }
    
    private func baseConfigure() {
        view.backgroundColor = .white
        title = "Detail Transaksi"
    }
    
    private func setupConstraints() {
        view.addSubviews(stackView, payButton)
        stackView.addArrangedSubviews(
            bankNameLabel,
            transactionIDLabel,
            merchantNameLabel,
            transactionAmountLabel
        )
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        payButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Spacing.l)
            make.top.equalTo(stackView.snp.bottom).offset(Spacing.l)
            make.height.equalTo(35)
        }
    }
    
    @objc
    private func didTapPayButton() {
        presenter?.proceedPayment()
    }
}

extension TransactionDetailViewController: TransactionDetailViewProtocol {
    
    func showDetail(_ qrisModel: QRISModel) {
        bankNameLabel.text = "Nama Bank: \(qrisModel.bankName)"
        transactionIDLabel.text = "ID Transaksi: \(qrisModel.transactionID)"
        merchantNameLabel.text = "Nama Merchant: \(qrisModel.merchantName)"
        transactionAmountLabel.text = "Nominal Transaksi: Rp\(qrisModel.transactionAmount.thousandSeparator())"
    }
    
    func transactionSuccess() {
        view.showToast(message: "Pembayaran Berhasil")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let persistentContainer = appDelegate.persistentContainer
        let coreDataHelper = CoreDataHelper(container: persistentContainer)
        
        if let payments = coreDataHelper.fetchAllPayments() {
            print("wibi: \(payments)")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            self?.presenter?.popQRISPage()
        })
    }
    
    func showError(_ message: String) {
        view.showToast(message: message)
    }
}

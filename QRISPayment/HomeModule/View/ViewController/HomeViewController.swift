//
//  HomeViewController.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - Views
    
    private let balanceContainerView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.cornerRadius = 12
        return view
    }()
    
    private let totalSaldoTitleLabel = {
        let label = UILabel()
        label.text = "Total Saldo"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let balanceLabel = {
        let label = UILabel()
        label.text = "Rp"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    private let hiddenSaldoLabel = {
        let label = UILabel()
        label.text = "Tap untuk lihat saldo"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let eyeIconImageView = {
        let imageView = UIImageView()
        imageView.setImage(image: .eyeFill, color: .black)
        return imageView
    }()
    
    private lazy var ctaButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapCTAButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    var presenter: HomePresenterProtocol? 
    
    private var isSaldoHidden = true {
        didSet {
            balanceLabel.isHidden = isSaldoHidden
            hiddenSaldoLabel.isHidden = !isSaldoHidden
            eyeIconImageView.setImage(image: isSaldoHidden ? .eyeFill : .eyeSlashFill, color: .black)
        }
    }
    
    override func viewDidLoad() {
        baseConfigure()
        setupConstraints()
        presenter?.getBalance()
    }
    
    private func baseConfigure() {
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshBalance), name: NSNotification.Name(rawValue: NotificationKeyConstants.needToRefreshBalance.rawValue), object: nil)
    }
    
    private func setupConstraints() {
        view.addSubview(balanceContainerView)
        balanceContainerView.addSubviews(totalSaldoTitleLabel, balanceLabel, hiddenSaldoLabel, eyeIconImageView, ctaButton)
        balanceContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacing.l + AppInfo.topSafeAreaInsets)
            make.leading.trailing.equalToSuperview().inset(Spacing.l)
            make.height.equalTo(150)
        }
        
        totalSaldoTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(Spacing.s)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(totalSaldoTitleLabel.snp.bottom).offset(Spacing.xxs)
            make.leading.equalTo(totalSaldoTitleLabel)
        }
        
        hiddenSaldoLabel.snp.makeConstraints { make in
            make.top.equalTo(totalSaldoTitleLabel.snp.bottom).offset(Spacing.xxs)
            make.leading.equalTo(totalSaldoTitleLabel)
        }
        
        eyeIconImageView.snp.makeConstraints { make in
            make.leading.equalTo(totalSaldoTitleLabel.snp.trailing).offset(Spacing.xs)
            make.centerY.equalTo(totalSaldoTitleLabel)
        }
        
        ctaButton.snp.makeConstraints { make in
            make.leading.top.equalTo(totalSaldoTitleLabel)
            make.trailing.bottom.equalTo(hiddenSaldoLabel)
        }
    }
    
    @objc 
    private func didTapCTAButton() {
        isSaldoHidden.toggle()
    }
    
    @objc
    private func refreshBalance() {
        presenter?.getBalance()
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func showBalance(_ balance: Double) {
        balanceLabel.text = "Rp\(balance.thousandSeparator())"
    }
    
}

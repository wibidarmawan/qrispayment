//
//  TransactionHistoryViewController.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 24/06/24.
//

import UIKit

class TransactionHistoryViewController: UITableViewController {
    
    // MARK: - Properties
    
    var presenter: TransactionHistoryPresenterProtocol?
    var paymentItemList: [PaymentItemModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getPaymentHistory()
    }
    
    private func baseConfigure() {
        title = "Riwayat"
        view.backgroundColor = UIColor.white
        tableView.register(TransactionHistoryTableViewCell.self, forCellReuseIdentifier: "TransactionHistoryTableViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshPaymentHistory), name: NSNotification.Name(rawValue: NotificationKeyConstants.needToRefreshPaymentHistory.rawValue), object: nil)
    }
    
    @objc
    private func refreshPaymentHistory() {
        presenter?.getPaymentHistory()
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentItemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryTableViewCell", for: indexPath) as? TransactionHistoryTableViewCell
        else {
            return UITableViewCell()
        }
        
        let paymentItem = paymentItemList[indexPath.row]
        cell.cellModel = paymentItem
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension TransactionHistoryViewController: TransactionHistoryViewProtocol {
    
    func updatePaymentHistory(_ paymentItemList: [PaymentItemModel]) {
        self.paymentItemList = paymentItemList
    }
    
}

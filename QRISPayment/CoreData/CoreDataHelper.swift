//
//  CoreDataHelper.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 24/06/24.
//

import CoreData

class CoreDataHelper {
    
    private let persistentContainer: NSPersistentContainer
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    // MARK: - CRUD Operations
    
    // Create a new PaymentModel
    func createPayment(qrisModel: QRISModel) -> PaymentModel? {
        let payment = PaymentModel(context: context)
        payment.bankName = qrisModel.bankName
        payment.transactionID = qrisModel.transactionID
        payment.merchantName = qrisModel.merchantName
        payment.transactionAmount = qrisModel.transactionAmount
        payment.createdAt = Date()
        
        do {
            try context.save()
            return payment
        } catch {
            print("Failed to create payment: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchAllPayments() -> [PaymentItemModel]? {
        let fetchRequest: NSFetchRequest<PaymentModel> = PaymentModel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let payments = try context.fetch(fetchRequest)
            return payments.map { payment in
                PaymentItemModel(
                    bankName: payment.bankName ?? "",
                    transactionID: payment.transactionID ?? "",
                    merchantName: payment.merchantName ?? "",
                    transactionAmount: payment.transactionAmount)
            }
        } catch {
            print("Failed to fetch payments: \(error.localizedDescription)")
            return nil
        }
    }
    
    func createInitialBalance(balance: Double) -> BalanceModel? {
        let balanceModel = BalanceModel(context: context)
        balanceModel.balance = balance

        do {
            try context.save()
            return balanceModel
        } catch {
            print("Failed to create initial balance: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchBalanceModel() -> BalanceModel? {
        let fetchRequest: NSFetchRequest<BalanceModel> = BalanceModel.fetchRequest()

        do {
            let balanceModels = try context.fetch(fetchRequest)
            return balanceModels.first
        } catch {
            print("Failed to fetch balance: \(error.localizedDescription)")
            return nil
        }
    }

    func updateBalance(newBalance: Double) -> Bool {
        guard let balanceModel = fetchBalanceModel() else { return false }
        balanceModel.balance = newBalance

        do {
            try context.save()
            return true
        } catch {
            print("Failed to update balance: \(error.localizedDescription)")
            return false
        }
    }
}

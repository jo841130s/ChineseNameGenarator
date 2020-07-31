//
//  IAPManager.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/7/30.
//  Copyright © 2020 Joe. All rights reserved.
//

import StoreKit
class IAPManager: NSObject {
    
    static let canUsedTimes = 100
    static func buyTimes() -> Int {
        return UserDefaults.standard.integer(forKey: "BuyTimes")
    }
    static func usedTimes() -> Int {
        return UserDefaults.standard.integer(forKey: "UsedTimes")
    }
    static let shared = IAPManager()
    var products = [SKProduct]()
    fileprivate var productRequest: SKProductsRequest!
    var apiBuilder = APIBuilder()
    var delegate : IAPManagerDelegate?
    
    func getProductIDs() -> [String] {
        ["GuangXin.ChineseNameGeneratorEnglish.One", "GuangXin.ChineseNameGeneratorEnglish.Two", "GuangXin.ChineseNameGeneratorEnglish.Three"]
    }
    
    func getProducts() {
        let productIds = getProductIDs()
        let productIdsSet = Set(productIds)
        productRequest = SKProductsRequest(productIdentifiers: productIdsSet)
        productRequest.delegate = self
        productRequest.start()
    }
    
    func buy(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            print("Can't Make Payment")
        }
    }
    
}
extension IAPManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        response.products.forEach {
            print($0.localizedTitle, $0.price, $0.localizedDescription)
            delegate?.getPaymentInfo(info: ["title":$0.localizedTitle, "price":"\($0.price)"])
        }
        self.products = response.products
        DispatchQueue.main.async {
            self.products = response.products
        }
    }
    
}

extension IAPManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            print($0.payment.productIdentifier, $0.transactionState.rawValue)
            switch $0.transactionState {
            case .purchased:
                apiBuilder.endLoading()
                let buyTimes = UserDefaults.standard.integer(forKey: "BuyTimes")
                UserDefaults.standard.set(buyTimes+5, forKey: "BuyTimes")
                self.delegate?.finishPurchase()
                SKPaymentQueue.default().finishTransaction($0)
            case .failed:
                apiBuilder.endLoading()
                print($0.error ?? "")
                if ($0.error as? SKError)?.code != .paymentCancelled {
                    // show error
                }
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                apiBuilder.endLoading()
                SKPaymentQueue.default().finishTransaction($0)
            case .purchasing, .deferred:
                apiBuilder.startLoading()
            @unknown default:
                apiBuilder.endLoading()
            }
            
        }
    }
   
}

protocol IAPManagerDelegate {
    func finishPurchase()
    func getPaymentInfo(info:[String:String])
}

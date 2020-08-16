//
//  IAPManager.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/7/30.
//  Copyright © 2020 Joe. All rights reserved.
//

import StoreKit
class IAPManager: NSObject {
    static let canUsedTimes = 2
    static func buyTimes() -> Int {
        return UserDefaults.standard.integer(forKey: "BuyTimes")
    }
    static func usedTimes() -> Int {
        return UserDefaults.standard.integer(forKey: "UsedTimes")
    }
    static let shared = IAPManager()
    static var products = [SKProduct]()
    fileprivate var productRequest: SKProductsRequest!
    var apiBuilder = APIBuilder()
    var delegate : IAPManagerDelegate?
    
    func getProductIDs() -> [String] {
        return ["GuangXin.ChineseNameGeneratorChinese.One", "GuangXin.ChineseNameGeneratorChinese.Two", "GuangXin.ChineseNameGeneratorChinese.Three"]
    }
    
    func getProducts() {
        let productIds = getProductIDs()
        let productIdsSet = Set(productIds)
        productRequest = SKProductsRequest(productIdentifiers: productIdsSet)
        productRequest.delegate = self
        productRequest.start()
    }
    
    static func buy(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            print(product.productIdentifier)
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            print("Can't Make Payment")
        }
    }
    
}
extension IAPManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
        response.products.forEach {
            print($0.localizedTitle, $0.price, $0.localizedDescription)
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            let formattedPrice = formatter.string(from: $0.price) ?? ""
            delegate?.getPaymentInfo(info: ["title":$0.localizedTitle, "price":"\(formattedPrice)"])
        }
        IAPManager.products = response.products
        DispatchQueue.main.async {
            IAPManager.products = response.products
        }
    }
    
}

extension IAPManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            let identifier = $0.payment.productIdentifier
            print($0.payment.productIdentifier, $0.transactionState.rawValue)
            switch $0.transactionState {
            case .purchased:
                apiBuilder.endLoading()
                let buyTimes = UserDefaults.standard.integer(forKey: "BuyTimes")
                var addTimes : Int = 0
                if identifier == "GuangXin.ChineseNameGeneratorEnglish.One" {
                    addTimes = 5
                } else if identifier == "GuangXin.ChineseNameGeneratorEnglish.Two" {
                    addTimes = 12
                } else {
                    addTimes = 20
                }
                UserDefaults.standard.set(buyTimes+addTimes, forKey: "BuyTimes")
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

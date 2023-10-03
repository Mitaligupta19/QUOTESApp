//
//  ViewController.swift
//  InspoQuotes
//
//  Created by Mitali Gupta on 27/09/23.
//

import UIKit
import StoreKit

class QuoteTableViewController: UITableViewController {
    
    let productId = "com.example.InspoQuotes.PremiumQuotes"
    
    var  quotesToShow = [
        "qwertyu",
        "asdfghj",
        "zxcvbn",
        "qwertyu",
        "qwertyui"
    ]
    
    let premiumQuotes = [
        "ghfhgjbm",
        "hguygue",
        "qwertyui",
        "zxcvbnm,",
        "qwedfghjnm"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SKPaymentQueue.default().add(self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return quotesToShow.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
        
        if indexPath.row < quotesToShow.count {
            cell.textLabel?.text = quotesToShow[indexPath.row]
            cell.textLabel?.numberOfLines = 0
        }else{
            cell.textLabel?.text = "get more texts"
            cell.textLabel?.textColor = UIColor(white: 0.5, alpha: 1)
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == quotesToShow.count{
            buypremiumQuotes()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func buypremiumQuotes() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productId
            SKPaymentQueue.default().add(paymentRequest)
        } else{
            print("cant make payments")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                
                
                print("transaction successful!!")
                showPremiumQuotes()
                
                UserDefaults.standard.set(true, forKey: productId)
                
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .failed {
                
                if let error = transaction.error{
                    let errorDescription = error.localizedDescription
                    print("transaction failed due to error: \(errorDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    func showPremiumQuotes() {
        quotesToShow.append(contentsOf: premiumQuotes)
    }
    
    func isPurcahsed() -> Bool {
        
    }
    
    @IBAction func restorePressed(_ sender: UIBarButtonItem){
        
    }
}



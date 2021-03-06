//
//  ViewController.swift
//  drinkApp
//
//  Created by Lai Po Ying on 2021/5/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var options: [UIButton]!
    @IBOutlet weak var titleLabel: UIButton!
    @IBOutlet weak var drinksView: UIView!
    @IBOutlet weak var iceSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sugarSegmentedControl: UISegmentedControl!
    @IBOutlet weak var drinksImageView: UIImageView!
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var bubbleSwitch: UISwitch!
    @IBOutlet weak var konjacSwitch: UISwitch!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var subtotalPriceLabel: UILabel!
    @IBOutlet weak var orderTextView: UITextView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var iceLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var bubbleLabel: UILabel!
    @IBOutlet weak var konjacLabel: UILabel!
    @IBOutlet weak var cupTitleLabel: UILabel!
    @IBOutlet weak var cupLabel: UILabel!
    @IBOutlet weak var subTotalTitleLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var addInCartButton: UIButton!
    @IBOutlet weak var submitButtonN: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var coverpageImageView: UIImageView!
    @IBOutlet weak var specialDrinkLabel: UILabel!
    
    var unitPrice = 0
    var subtotalPrice = 0
    var totalPrice = 0
    let formatterPrice = NumberFormatter()
    let formatterQuantity = NumberFormatter()
    
    func syncSubtotalPrice() {
            subtotalPrice = unitPrice * Int(quantityStepper.value)
            formatterPrice.numberStyle = .currencyISOCode
            formatterPrice.locale = Locale(identifier: "zh-TW")
            formatterPrice.maximumFractionDigits = 0
            subtotalPriceLabel.text = formatterPrice.string(from: NSNumber(value: subtotalPrice))
    }
    func unHiddenAllComponent() {
        drinksView.isHidden = false
        drinksImageView.isHidden = false
        introduceLabel.isHidden = false
        iceLabel.isHidden = false
        iceSegmentedControl.isHidden = false
        sugarSegmentedControl.isHidden = false
        sugarLabel.isHidden = false
        bubbleLabel.isHidden = false
        bubbleSwitch.isHidden = false
        konjacLabel.isHidden = false
        konjacSwitch.isHidden = false
        cupTitleLabel.isHidden = false
        subTotalTitleLabel.isHidden = false
        subtotalPriceLabel.isHidden = false
        cupLabel.isHidden = false
        quantityStepper.isHidden = false
        quantityLabel.isHidden = false
        addInCartButton.isHidden = false
        submitButtonN.isHidden = false
        totalTitleLabel.isHidden = false
        totalPriceLabel.isHidden = false
        orderTextView.isHidden = false
        clearButton.isHidden = false
        coverpageImageView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinksView.layer.borderWidth = 2
        drinksView.layer.borderColor = CGColor(red: 188/255, green: 149/255, blue: 92/255, alpha: 1)
        iceSegmentedControl.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16),.foregroundColor: UIColor.white], for: .normal)
        sugarSegmentedControl.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16),.foregroundColor: UIColor.white], for: .normal)
        orderTextView.layer.borderWidth = 2
        orderTextView.layer.borderColor = CGColor(red: 188/255, green: 149/255, blue: 92/255, alpha: 1)
    }
    
    @IBAction func startSelect(_ sender: Any) {
        for option in options {
            UIView.animate(withDuration: 0.2, animations: {
                option.isHidden = !option.isHidden
            })
        }
        if titleLabel.currentTitle == "MENU" {
        }
        else {
            titleLabel.setTitle("MENU", for: UIControl.State.normal)
        }
            
    }
    @IBAction func optionPressed(_ sender: UIButton) {
        let drinksName = sender.currentTitle
        titleLabel.setTitle(drinksName, for: UIControl.State.normal)

        for option in options {
            UIView.animate(withDuration: 0.2, animations: {
                option.isHidden = !option.isHidden
            })
        }
        
    }
    @IBAction func bubbleSwitchChange(_ sender: Any) {
        if bubbleSwitch.isOn {
            unitPrice = unitPrice + 10
            syncSubtotalPrice()
        }
        else {
            unitPrice = unitPrice - 10
            syncSubtotalPrice()
        }
    }
    @IBAction func konjacSwitchChange(_ sender: Any) {
        if konjacSwitch.isOn {
            unitPrice = unitPrice + 20
            syncSubtotalPrice()
        }
        else {
            unitPrice = unitPrice - 20
            syncSubtotalPrice()
        }
    }
    @IBAction func stepperChange(_ sender: UIStepper) {
        if quantityStepper.value > 1{
            formatterQuantity.maximumFractionDigits = 0
            quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
            syncSubtotalPrice()
        }
        else {
            quantityStepper.value = 1
            formatterQuantity.maximumFractionDigits = 0
            quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
            syncSubtotalPrice()
        }
    }
    @IBAction func addInButton(_ sender: UIButton) {
        totalPrice = totalPrice + subtotalPrice
        formatterPrice.numberStyle = .currencyISOCode
        formatterPrice.locale = Locale(identifier: "zh-TW")
        formatterPrice.maximumFractionDigits = 0
        totalPriceLabel.text = formatterPrice.string(from: NSNumber(value: totalPrice))
        if bubbleSwitch.isOn, konjacSwitch.isOn {
            orderTextView.text = titleLabel.currentTitle! + " " +   sugarSegmentedControl.titleForSegment(at: sugarSegmentedControl.selectedSegmentIndex)! + " " + iceSegmentedControl.titleForSegment(at: iceSegmentedControl.selectedSegmentIndex)! + " " + "??????????????? ??????????????? " + "\(Int(quantityStepper.value))" + " ???" + "\n\(String(describing: orderTextView.text!))"
        }
        else if bubbleSwitch.isOn {
            orderTextView.text = titleLabel.currentTitle! + " " +   sugarSegmentedControl.titleForSegment(at: sugarSegmentedControl.selectedSegmentIndex)! + " " + iceSegmentedControl.titleForSegment(at: iceSegmentedControl.selectedSegmentIndex)! + " " + "??????????????? " + "\(Int(quantityStepper.value))" + " ???" + "\n\(String(describing: orderTextView.text!))"
        }
        else if konjacSwitch.isOn {
            orderTextView.text = titleLabel.currentTitle! + " " +   sugarSegmentedControl.titleForSegment(at: sugarSegmentedControl.selectedSegmentIndex)! + " " + iceSegmentedControl.titleForSegment(at: iceSegmentedControl.selectedSegmentIndex)! + " " + "??????????????? " + "\(Int(quantityStepper.value))" + " ???" + "\n\(String(describing: orderTextView.text!))"
        }
        else {
            orderTextView.text = titleLabel.currentTitle! + " " +   sugarSegmentedControl.titleForSegment(at: sugarSegmentedControl.selectedSegmentIndex)! + " " + iceSegmentedControl.titleForSegment(at: iceSegmentedControl.selectedSegmentIndex)! + " " + "\(Int(quantityStepper.value))" + " ???" + "\n\(String(describing: orderTextView.text!))"
        }
    }
    @IBAction func clearButtonPressed(_ sender: Any) {
        titleLabel.setTitle("MEMU", for: .normal)
        orderTextView.text = nil
        totalPrice = 0
        formatterPrice.locale = Locale(identifier: "zh-TW")
        formatterPrice.maximumFractionDigits = 0
        totalPriceLabel.text = formatterPrice.string(from: NSNumber(value: totalPrice))
        coverpageImageView.isHidden = false
        drinksView.isHidden = true
        drinksImageView.isHidden = true
        introduceLabel.isHidden = true
        iceLabel.isHidden = true
        iceSegmentedControl.isHidden = true
        sugarSegmentedControl.isHidden = true
        sugarLabel.isHidden = true
        bubbleLabel.isHidden = true
        bubbleSwitch.isHidden = true
        konjacLabel.isHidden = true
        konjacSwitch.isHidden = true
        cupTitleLabel.isHidden = true
        subTotalTitleLabel.isHidden = true
        subtotalPriceLabel.isHidden = true
        cupLabel.isHidden = true
        quantityStepper.isHidden = true
        quantityLabel.isHidden = true
        addInCartButton.isHidden = true
        submitButtonN.isHidden = true
        totalTitleLabel.isHidden = true
        totalPriceLabel.isHidden = true
        orderTextView.isHidden = true
        clearButton.isHidden = true
        specialDrinkLabel.isHidden = true
    }
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "???? Congratulations! ????", message: "Your order has been submitted! The drinks will be delivered to your address in 15 minutes.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.titleLabel.setTitle("MEMU", for: .normal)
            self.orderTextView.text = nil
            self.totalPrice = 0
            self.formatterPrice.locale = Locale(identifier: "zh-TW")
            self.formatterPrice.maximumFractionDigits = 0
            self.totalPriceLabel.text = self.formatterPrice.string(from: NSNumber(value: self.totalPrice))
            self.coverpageImageView.isHidden = false
            self.drinksView.isHidden = true
            self.drinksImageView.isHidden = true
            self.introduceLabel.isHidden = true
            self.iceLabel.isHidden = true
            self.iceSegmentedControl.isHidden = true
            self.sugarSegmentedControl.isHidden = true
            self.sugarLabel.isHidden = true
            self.bubbleLabel.isHidden = true
            self.bubbleSwitch.isHidden = true
            self.konjacLabel.isHidden = true
            self.konjacSwitch.isHidden = true
            self.cupTitleLabel.isHidden = true
            self.subTotalTitleLabel.isHidden = true
            self.subtotalPriceLabel.isHidden = true
            self.cupLabel.isHidden = true
            self.quantityStepper.isHidden = true
            self.quantityLabel.isHidden = true
            self.addInCartButton.isHidden = true
            self.submitButtonN.isHidden = true
            self.totalTitleLabel.isHidden = true
            self.totalPriceLabel.isHidden = true
            self.orderTextView.isHidden = true
            self.clearButton.isHidden = true
            self.specialDrinkLabel.isHidden = true
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    // drink1 = ????????????
    @IBAction func drink1Pressed(_ sender: UIButton) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "?????????/??????????????????????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 25
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
        
    }
    // drink2 = ????????????
    @IBAction func drink2Pressed(_ sender: UIButton) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "??????????????????????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 25
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink3 = ????????????
    @IBAction func drink3Pressed(_ sender: UIButton) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "?????????????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 25
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink4 = ????????????
    @IBAction func drink4Pressed(_ sender: UIButton) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 35
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink5 = ????????????
    @IBAction func drink5Pressed(_ sender: UIButton) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "?????????????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 45
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink6 = ????????????
    @IBAction func drink6(_ sender: UIButton) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "??????????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 25
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink7 = ????????????
    @IBAction func drink7Pressed(_ sender: UIButton) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "?????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 35
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink8 = ????????????
    @IBAction func drink8Pressed(_ sender: UIButton) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "???????????????????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 25
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink9 = ????????????
    @IBAction func drink9Pressed(_ sender: Any) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "??????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 25
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink10 = ????????????
    @IBAction func drink10(_ sender: UIButton) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "??????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 25
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink11 = ????????????
    @IBAction func drink11Pressed(_ sender: Any) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "?????????????????????????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 40
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink12 = ????????????
    @IBAction func drink12Pressed(_ sender: Any) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "???????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 40
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink13 = ????????????
    @IBAction func drink13Pressed(_ sender: Any) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "???????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 50
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // drink14 = ????????????
    @IBAction func drink14(_ sender: Any) {
        specialDrinkLabel.isHidden = true
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "???????????????????????????????????????????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 50
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // specialDrink1 = ????????????
    @IBAction func specialDrink1Pressed(_ sender: Any) {
        specialDrinkLabel.isHidden = false
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 40
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // specialDrink2 = ????????????
    @IBAction func specialDrink2Pressed(_ sender: Any) {
        specialDrinkLabel.isHidden = false
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "????????????????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 55
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
    // specialDrink3 = ????????????
    @IBAction func specialDrink3Pressed(_ sender: Any) {
        specialDrinkLabel.isHidden = false
        drinksImageView.image = UIImage(named: "????????????")
        introduceLabel.text = "????????????????????????????????????????????????"
        iceSegmentedControl.selectedSegmentIndex = 0
        sugarSegmentedControl.selectedSegmentIndex = 0
        bubbleSwitch.isOn = false
        konjacSwitch.isOn = false
        unitPrice = 65
        quantityStepper.value = 1
        formatterQuantity.maximumFractionDigits = 0
        quantityLabel.text = formatterQuantity.string(from: NSNumber(value: quantityStepper.value))
        syncSubtotalPrice()
        if drinksView.isHidden {
            unHiddenAllComponent()
        }
    }
}

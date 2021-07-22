//
//  ViewController.swift
//  SalonKadai3
//
//  Created by 坂本龍哉 on 2021/07/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var firstNumberLabel: UILabel!
    @IBOutlet private weak var secondNumberLabel: UILabel!
    @IBOutlet private weak var firstNumberSwitch: UISwitch!
    @IBOutlet private weak var secondNumberSwitch: UISwitch!
    @IBOutlet weak var caluculateButton: UIButton!
    
    private let notificationCenter = NotificationCenter()
    private var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(notificationCenter: notificationCenter)
        
        firstTextField.addTarget(self,
                                 action: #selector(firstTextFieldEditingChanged),
                                 for: .editingChanged)
        secondTextField.addTarget(self,
                                 action: #selector(secondTextFieldEditingChanged),
                                 for: .editingChanged)
        
        firstNumberSwitch.addTarget(self,
                                    action: #selector(firstTextFieldEditingChanged),
                                    for: .touchUpInside)
        secondNumberSwitch.addTarget(self,
                                     action: #selector(secondTextFieldEditingChanged),
                                     for: .touchUpInside)

        notificationCenter.addObserver(self,
                                       selector: #selector(updateValidationText),
                                       name: .inputFirstText,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(updateValidationText),
                                       name: .inputSecondText,
                                       object: nil)
        
        caluculateButton.addTarget(self,
                                   action: #selector(calculate),
                                   for: .touchUpInside)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(displayResultLabel),
                                       name: .displayResult,
                                       object: nil)
    }
}

extension ViewController {
    @objc func firstTextFieldEditingChanged(sender: UITextField) {
        viewModel?.NumbersInput(text: firstTextField.text,
                                isOn: firstNumberSwitch.isOn,
                                textState: .first)
    }
    
    @objc func secondTextFieldEditingChanged(sender: UITextField) {
        viewModel?.NumbersInput(text: secondTextField.text,
                                isOn: secondNumberSwitch.isOn,
                                textState: .second)
    }
    
    @objc func updateValidationText(notifiation: Notification) {
        switch notifiation.name {
        case .inputFirstText:
            guard let text = notifiation.object as? String else { return }
            firstNumberLabel.text = text
        case .inputSecondText:
            guard let text = notifiation.object as? String else { return }
            secondNumberLabel.text = text
        default:
            break
        }
    }
    
    @objc func calculate() {
        viewModel?.calculate(firstLabel: firstNumberLabel.text, secondLabel: secondNumberLabel.text)
    }
    
    @objc func displayResultLabel(notification: Notification) {
        guard let result = notification.object as? String else { return }
        resultLabel.text = result
        print(result)
    }

}

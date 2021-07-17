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

        notificationCenter.addObserver(self,
                                       selector: #selector(updateValidationFirstText),
                                       name: .inputFirstText,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(updateValidationSecondText),
                                       name: .inputSecondText,
                                       object: nil)

    }
}

extension ViewController {
    @objc func firstTextFieldEditingChanged(sender: UITextField) {
        viewModel?.firstNumbersInput(firstText: firstTextField.text)
    }
    
    @objc func secondTextFieldEditingChanged(sender: UITextField) {
        viewModel?.secondNumbersInput(secondText: secondTextField.text)
    }

    
    @objc func updateValidationFirstText(notifiation: Notification) {
        guard let text = notifiation.object as? String else { return }
        firstNumberLabel.text = text
    }
    
    @objc func updateValidationSecondText(notifiation: Notification) {
        guard let text = notifiation.object as? String else { return }
        secondNumberLabel.text = text

    }

}

//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Sateesh on 05/01/2021.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    @IBOutlet weak var selectedCurrency: UILabel!
    @IBOutlet weak var selectedCurrencyValue: UILabel!
    @IBOutlet weak var baseCurrency: UILabel!
    @IBOutlet weak var baseCurrencyTextField: UITextField!
    
    var viewModel: CurrencyConververterViewModel!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        initlializeViewModel()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Initialization
    
    private func setupView() {
        title = "CONVERTER"
    }
    
    private func initlializeViewModel() {
        
        selectedCurrency.text = viewModel.selectedCurrencyCode()
        baseCurrency.text = viewModel.baseCurrency
        baseCurrencyTextField.text = viewModel.baseCurrencyStringValue()
        
        baseCurrencyTextField.becomeFirstResponder()
        
        viewModel.updateResult = { [weak self] value in
            self?.selectedCurrencyValue.text = value
        }
        
        viewModel.baseCurrencyValueChanged(viewModel.baseCurrencyStringValue())
        
    }
    
}

// MARK: - Text Field Delegates

extension CurrencyConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            viewModel.baseCurrencyValueChanged(updatedText)
        } else {
            viewModel.baseCurrencyValueChanged("0")
        }
        return true
    }
}

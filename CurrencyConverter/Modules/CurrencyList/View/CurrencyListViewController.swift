//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Sateesh on 05/01/2021.
//

import UIKit
import RSSelectionMenu;

class CurrencyListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    @IBOutlet weak var baseCurrencyFlag: UILabel!

    lazy var viewModel: CurrencyListViewModel = {
        return CurrencyListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getRates()
        initViewModel()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Initialization
    
    private func setupView() {
        title = AppInfo.title
    }

    
    private func initViewModel() {
        viewModel.errorOccured = { [weak self] error in
            self?.showError(error: error)
        }
        viewModel.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        viewModel.navigateToNextScreen = {[weak self] in
            self?.performSegue(withIdentifier: Sugeses.converterView, sender: self)
        }
    }
    private func updateUI() {
        tableView.reloadData()
        baseCurrencyLabel.text = viewModel.getBaseCurrency()
        baseCurrencyFlag.text = viewModel.flagFor(currency: viewModel.getBaseCurrency())
    }
    
    private func showError(error: String) {
        UIAlertController.show(title: "Alert", message: error, primaryButtonTitle: "Ok")
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CurrencyConverterViewController {
            destination.viewModel = viewModel.converterViewModel()
        }
    }
    
    // MARK: - Button Actions

    @IBAction func baseCurrencyClicked(){
                
        let vc: CurrencySelectionVC = self.storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifiers.currencySelection) as! CurrencySelectionVC
        vc.viewModel = self.viewModel
        let nav = UINavigationController(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)

    }
    
    // MARK: - Helpers
}
// MARKL - UITableViewDataSource
extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyValueTableViewCell.identifier, for: indexPath)
        guard let currencyCell = cell as? CurrencyValueTableViewCell else {
            fatalError()
        }
        let item = viewModel.itemForCell(indexPath: indexPath)
        
        currencyCell.item = item

        return cell
    }
}
// MARKL: - UITableViewDelegate
extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
}

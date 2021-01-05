//
//  CurrencySelectionVC.swift
//  CurrencyConverter
//
//  Created by Sateesh on 05/01/2021.
//

import UIKit

class CurrencySelectionVC: UIViewController {

    var viewModel: CurrencyListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "SELECT BASE CURRENCY"
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARKL - UITableViewDataSource
extension CurrencySelectionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyValueTableViewCell.identifier, for: indexPath)
        guard let currencyCell = cell as? CurrencyValueTableViewCell else {
            fatalError()
        }
        let item = viewModel?.itemForCell(indexPath: indexPath)
        
        currencyCell.item = item
        
        return cell
    }
}
// MARKL - UITableViewDelegate

extension CurrencySelectionVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = viewModel?.itemForCell(indexPath: indexPath)

        self.viewModel?.setBaseCurrency(base: item?.currency ?? "")
        self.dismiss(animated: true, completion: nil)
    }
}

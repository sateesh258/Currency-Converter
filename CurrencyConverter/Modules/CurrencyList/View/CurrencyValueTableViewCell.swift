//
//  CurrencyValueTableViewCell.swift
//  CurrencyConverter
//
//  Created by Sateesh on 05/01/2021.
//

import UIKit

class CurrencyValueTableViewCell: UITableViewCell {
    static let identifier = "CurrencyValueTableViewCell"
    
    @IBOutlet weak var flagLbl: UILabel?
    @IBOutlet weak var currency: UILabel?
    @IBOutlet weak var value: UILabel?

    var item:(currency: String, value: String, flag:String)?{
        
        didSet{
            self.currency?.text = item?.currency
            self.value?.text = item?.value
            self.flagLbl?.text = item?.flag
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

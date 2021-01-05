//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Sateesh on 05/01/2021.
//

import Foundation

class CurrencyListViewModel {
    
    var errorOccured: ((String) -> Void)?
    var updateUI: (() -> Void)?
    var navigateToNextScreen: (() -> Void)?
    var dataSource: [CurrencyTableModel] = [] {
        didSet {
            updateUI?()
        }
    }
    private var ratesListModel: RatesListModel!
    private var selectedTableModel: CurrencyTableModel!
    private var baseCurrency: String?
    
    private var counties = [Country]()
    
    init() {
        self.getCountriesList()
    }
    
    func getCountriesList() {

        guard let path = Bundle.main.path(forResource: "countries", ofType: "json") else { return }
        
        if let url = URL(string: path) {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

                let decoder = JSONDecoder()
                let model = try decoder.decode(CountriesListModel.self, from: data)
                counties = model.countries ?? []

            } catch {
                    print("Unable to load data: \(error)")
                }
        }
        
    }
    
    func getRates(for base: String = "EUR") {
        
        // https://api.exchangeratesapi.io/latest?base=USD
        
        let request = Request(path: "\(AppUrl.currencyList)?base=\(base)")
        
        Network.shared.send(request) { (result: Result<RatesListModel, Error>) in
            
            switch result {
            case .success(let response):
                //   self.citiesArray = response["data"] as! [Dictionary<String, Any>]
                if let error = response.error {
                    self.errorOccured?(error)
                }else{
                    self.ratesListModel = response
                    self.baseCurrency = response.base
                    self.ratesRecieved(model: response)
                    
                }
                
            case .failure(let error):
                self.errorOccured?(error.localizedDescription)
            }
            
        }
        
    }
    
    func flagFor(currency:String) -> String {

        if let country = getCountryFor(currencyCode: currency){
            
            let flagStr = flag(country: country.countryCode)
            return flagStr
        }
        
        return ""
    }
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    func getCountryFor(currencyCode: String) -> Country? {
        let filtered = counties.filter { item in
            return (currencyCode == item.currencyCode)
        }
        return filtered.count > 0 ? filtered[0] : nil
    }
    
    func numberOfRows() -> Int {
        dataSource.count
    }
    func getBaseCurrency() -> String {
        return baseCurrency ?? "--"
    }
    func setBaseCurrency(base: String){
        getRates(for: base)
    }
    
    func itemForCell(indexPath: IndexPath) -> (currency: String, value: String, flag:String) {
        let item = dataSource[indexPath.row]
        let flag = flagFor(currency: item.code)
        return (currency: item.code, value: String(item.value), flag)
    }
    func didSelectItem(at indexPath: IndexPath) {
        selectedTableModel = dataSource[indexPath.row]
        navigateToNextScreen?()
    }
    func converterViewModel() -> CurrencyConververterViewModel {
        CurrencyConververterViewModel(baseCurrency: ratesListModel.base,
                                      selectedCurrency: selectedTableModel)
    }
    private func ratesRecieved(model: RatesListModel) {
        dataSource = model.rates.compactMap({ CurrencyTableModel(code: $0.key, value: $0.value.rounded(toPlaces: 2)) })
    }
    
    
}

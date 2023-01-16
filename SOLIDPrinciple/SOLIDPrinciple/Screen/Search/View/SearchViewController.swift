//
//  SearchViewController.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 15/01/23.
//

import UIKit

class SearchViewController: UIViewController,UITextFieldDelegate {
    private var viewModel = StaffViewModel()
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    var SearchData:[Staff_PickedModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        // Do any additional setup after loading the view.
    }
    func configuration() {
        searchTableView.register(StaffTableCell.nib, forCellReuseIdentifier: StaffTableCell.identifier)
        Utility.addAllSidesShadowOnView(searchView)
        Utility.setViewCornerRadius(searchView, 5)
        searchTextField.delegate = self
        initViewModel()
        observeEvent()
        if viewModel.staff_Picked.count>0{
            self.SearchData = self.viewModel.staff_Picked
            self.searchTableView.reloadData()

        }
        
    }
    @IBAction func HomeButtonTapped(_ sender: UIButton) {
     
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func initViewModel() {
        viewModel.getAll()
    }
    
    func observeEvent() {
        viewModel.dataHandler = {
            [weak self] datas in
            guard let self else { return }
            DispatchQueue.main.async {
                self.SearchData = self.viewModel.staff_Picked ?? []
                self.searchTableView.reloadData()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var search = textField.text!
        if search.count >= 2
        {
        if string.isEmpty
            {
                search = String(search.dropLast())
            }
            else
            {
                search=textField.text!+string
            }

            print(search)
            let predicate=NSPredicate(format: "SELF.name CONTAINS[cd] %@", search)
        SearchData.removeAll()
//        SearchData = viewModel.staff_Picked.filter { thing in
//            return thing.title?.lowercased().contains(search.lowercased())
//            }
        SearchData = viewModel.staff_Picked.filter(
//            {$0.title?.range(of: search, options: [.caseInsensitive,.diacriticInsensitive]) != nil}
            {
                $0.title?.localizedCaseInsensitiveContains(search) ?? false ||
                $0.releaseDate?.localizedCaseInsensitiveContains(search) ?? false ||
                $0.rating?.description.localizedCaseInsensitiveContains(search) ?? false
            })
                print(SearchData)
            }else{
                    SearchData = viewModel.staff_Picked

            }
        searchTableView.reloadData()
           
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
            print("search text field will be empty here")
            return true
        }
}
extension SearchViewController: UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            SearchData.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StaffTableCell") as? StaffTableCell else {
                return UITableViewCell()
            }
            let product = SearchData[indexPath.row]
            cell.product = product
            return cell
        }

    }

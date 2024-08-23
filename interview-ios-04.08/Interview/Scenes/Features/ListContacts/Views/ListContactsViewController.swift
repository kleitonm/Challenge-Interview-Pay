import UIKit

final class ListContactsViewController: UIViewController {
    
    // MARK: Private constant
   
    private var viewModel: ListContactsViewModelProtocol
    weak var delegate: ListContactsViewModelDelegate?
    
    // MARK: Init
    init(viewModel: ListContactsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.indentifaier)
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        navigationItem.title = "Lista de contatos"
        loadData()
        viewModel.setDelegate = self
    }
    
    private func loadData() {
        viewModel.loadContacts { result in
            switch result {
            case .success(let model):
                self.viewModel.contact = model
                self.tableView.reloadData()
                self.activity.stopAnimating()
            case .failure(let error):
                self.showAlert(title: "Ops, ocorreu um erro", message: error.localizedDescription)
            }
        }
    }
}

extension ListContactsViewController {
    func configureViews() {
        view.backgroundColor = .red
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension ListContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.indentifaier, for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(contact: viewModel.contact[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.isLegacy(index: indexPath)
    }
}

extension ListContactsViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension ListContactsViewController: ListContactsViewModelDelegate {
    func legacy() {
        showAlert(title: "Atenção", message: "Você tocou no contato sorteado")
    }
    
    func notLegacy(name: String) {
        showAlert(title: "Você tocou em", message: name)
    }
    
    
}

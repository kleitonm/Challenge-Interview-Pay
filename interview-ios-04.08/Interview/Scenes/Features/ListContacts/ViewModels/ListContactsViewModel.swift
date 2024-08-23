import Foundation

protocol ListContactsViewModelDelegate: AnyObject {
    func legacy()
    func notLegacy(name: String)
}

protocol ListContactsViewModelProtocol {
    func loadContacts(completion: @escaping(Result<[Contact], Error>) -> Void)
    
    func isLegacy(index: IndexPath)
    var contact: [Contact] { get set }
    var setDelegate: ListContactsViewModelDelegate? { get set }
}

final class ListContactsViewModel {
    weak var delegate:  ListContactsViewModelDelegate?
    private let service: ListContactServiceProtocol
    private var contacts = [Contact]()
    init(service: ListContactServiceProtocol) {
        self.service = service
    }
}

extension ListContactsViewModel: ListContactsViewModelProtocol {
    var contact: [Contact] {
        get { contacts }
        set { self.contacts = newValue}
    }
    
    var setDelegate: ListContactsViewModelDelegate? {
        get { delegate }
        set { self.delegate = newValue}
    }
    
    func loadContacts(completion: @escaping (Result<[Contact], any Error>) -> Void) {
        service.fetchContacts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let contacts):
                    completion(.success(contacts))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func isLegacy(index: IndexPath) {
        if UserIdsLegacy.isLegacy(id: contacts[index.row].id) {
            delegate?.legacy()
        } else {
            delegate?.notLegacy(name: contacts[index.row].name)
        }
    }
}



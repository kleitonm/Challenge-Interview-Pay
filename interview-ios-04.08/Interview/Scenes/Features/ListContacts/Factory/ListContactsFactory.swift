
import UIKit

enum ListContactsFactory {
    
    static func make() -> UIViewController {
        let service = ListContactService(session: .shared)
        let viewModel = ListContactsViewModel(service: service)
        let controller = ListContactsViewController(viewModel: viewModel)
        return controller
    }
}

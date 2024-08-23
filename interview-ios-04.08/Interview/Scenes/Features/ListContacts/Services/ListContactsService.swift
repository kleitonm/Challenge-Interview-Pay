import Foundation

protocol ListContactServiceProtocol {
    func fetchContacts(completion: @escaping(Result<[Contact], Error>) -> Void)
}

final class ListContactService {
    
    private let apiURL = "https://669ff1b9b132e2c136ffa741.mockapi.io/picpay/ios/interview/contacts"
    
    private var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }

}

extension ListContactService: ListContactServiceProtocol {
    
    func fetchContacts(completion: @escaping(Result<[Contact], Error>) -> Void) {
        guard let api = URL(string: apiURL) else { return }
        
        session.dataTask(with: api) { data, response, error in
            if let error {
                completion(.failure(error))
            }
            if let data,
               let response = response as? HTTPURLResponse {
                if (200..<300).contains(response.statusCode) {
                    
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode([Contact].self, from: data)
                        
                        completion(.success(decoded))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        .resume()
    }
}

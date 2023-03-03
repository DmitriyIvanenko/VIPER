//
//  Interactor.swift
//  VIPER
//
//  Created by Dmytro Ivanenko on 03.03.2023.
//

import Foundation

// Object
// Protocol
// ref to Presentor

// https://jsonplaceholder.typicode.com/users

protocol AnyInteractor {
    var presenter: AnyPresentor? { get set }
    
    func getUser()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresentor?
    
    func getUser() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [ weak self ] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            }
            catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
    
    
}

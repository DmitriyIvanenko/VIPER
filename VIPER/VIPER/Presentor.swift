//
//  Presentor.swift
//  VIPER
//
//  Created by Dmytro Ivanenko on 03.03.2023.
//

import Foundation

// Object
// Protocol
// Reference to Interactor, Router, View 

enum FetchError: Error {
    case failed
}

protocol AnyPresentor {
    var router: AnyRouter? { get set  }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set  }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresentor: AnyPresentor {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUser()
        }
    }
    
    var view: AnyView?
  
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(wirh: users)
        case .failure:
            view?.update(wirh: "Something went wrong")
        }

    }

    
}
 

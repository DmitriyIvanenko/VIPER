//
//  Router.swift
//  VIPER
//
//  Created by Dmytro Ivanenko on 03.03.2023.
//

import Foundation
import UIKit
// Object
// Entry Point

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        // Asign VIP (View, Interactor, Presentor)
        var view: AnyView = UserViewController()
        var presenter: AnyPresentor = UserPresentor()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
         return router
    }
}

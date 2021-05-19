//
//  Presenter.swift
//  VIPER_Tut
//
//  Created by Sukumar Anup Sukumaran on 19/05/21.
//

import Foundation

// object
// protocol
// ref to interactor, router, view

// https://jsonplaceholder.typicode.com/users

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
   var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set}
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    
    
    var view: AnyView?
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    

    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
            
        case .failure(let error):
            view?.update(with: error.localizedDescription)
            
        }
    }
    
}

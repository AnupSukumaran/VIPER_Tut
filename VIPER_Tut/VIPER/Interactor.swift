//
//  Interaction.swift
//  VIPER_Tut
//
//  Created by Sukumar Anup Sukumaran on 19/05/21.
//

import Foundation

// object
// protocol
// ref to present

// https://jsonplaceholder.typicode.com/users


protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        
        task.resume()
    }
    
    
    var presenter: AnyPresenter?
    
}

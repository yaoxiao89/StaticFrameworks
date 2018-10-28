//
//  SessionServiceProvider.swift
//  AppCore
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information
//

import Foundation
import NetworkCore

public class SessionServiceProvider: ServiceProvider {
    
    let networkProvider: NetworkProvider
    
    public convenience init() {
        self.init(networkProvider: SessionNetworkProvider())
    }
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    public func searchRepositories(for searchString: String, completion: FetchRepositoriesResult?) {
        guard let url = URL.searchRepositories(searchString) else {
            DispatchQueue.main.async {
                let result = self.createErrorResult(nil)
                completion?(result)
            }
            return
        }
                
        networkProvider.fetch(url: url) { [weak self] (result) in
            guard let `self` = self else { return }
            let res: Result<RepositorySearchModel>
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let search: RepositorySearchModel = try decoder.decode(RepositorySearchModel.self, from: data)
                    res = Result(value: search)
                } catch {
                    res = self.createErrorResult(error)
                }
            case .failure(let error):
                res = self.createErrorResult(error)
            }
            
            DispatchQueue.main.async {
                completion?(res)
            }
        }
    }
    
    func createErrorResult(_ error: Error?) -> Result<RepositorySearchModel> {
        return Result<RepositorySearchModel>(error: error)
    }
    
}

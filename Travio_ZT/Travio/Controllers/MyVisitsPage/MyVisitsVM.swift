//
//  MyVisitsVM.swift
//  Travio
//
//  Created by Oğuz on 18.11.2023.
//

import Foundation

class MyVisitsVM {
    
    var visitsTransfer: (([Visit]) -> Void)?
    
    func getAllVisits() {
        NetworkingHelper.shared.fetchData(urlRequest: .getAllVisits, completion: { [weak self] (result: Result<GetAllVisitsResponse, Error>) in
            switch result {
                case .success(let success):
                    self?.visitsTransfer?(success.data!.visits)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        })
    }
    
}

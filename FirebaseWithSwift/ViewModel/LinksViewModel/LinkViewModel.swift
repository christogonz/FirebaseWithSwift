//
//  LinkViewModel.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-26.
//

import Foundation

final class LinkViewModel: ObservableObject {
    @Published var links: [LinkModel] = []
    @Published var messageError: String?
    
    
    private let linkRepository: LinkRepository
    
    init(linkRepository: LinkRepository = LinkRepository()) {
        self.linkRepository = linkRepository
    }
    
    func getAllLinks() {
        linkRepository.getAllLinks { [weak self] result in
            switch result {
            case .success(let linkModels):
                self?.links = linkModels
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func createNewLink(fromURL url: String) {
        linkRepository.createNewLink(withURL: url) { [weak self] result in
            switch result {
            case .success(let link):
                print("Succes, new link \(link.title) added")
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
}

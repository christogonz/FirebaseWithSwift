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
    
    // MARK: Get all links
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
    
    // MARK: Create a new link
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
    
    
    //MARK: Update a link
    func updateIsFavorited(link: LinkModel) {
        let updateLink = LinkModel(id: link.id,
                                   url: link.url,
                                   title: link.title,
                                   isFavorited: link.isFavorited ? false : true,
                                   isCompleted: link.isCompleted)
        
        linkRepository.update(link: updateLink)
    }
    
    //MARK: Update a link
    func updateIsCompleted(link: LinkModel) {
        let updateLink = LinkModel(id: link.id,
                                   url: link.url,
                                   title: link.title,
                                   isFavorited: link.isFavorited,
                                   isCompleted: link.isCompleted ? false : true)
        
        linkRepository.update(link: updateLink)
    }
    
    // MARK: Detele Link
    func detele(link: LinkModel) {
        linkRepository.delete(link: link)
    }
    
}

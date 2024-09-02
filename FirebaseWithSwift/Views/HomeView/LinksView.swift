//
//  LinksView.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-26.
//

import SwiftUI

struct LinksView: View {
    @ObservedObject var linksViewModel: LinkViewModel
    @State var text: String = ""
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .frame(height: 100)
                .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
                )
                .padding(.horizontal, 12)
                .clipShape(.rect(cornerRadius: 3))
                .padding(.bottom)
            
            Button {
                linksViewModel.createNewLink(fromURL: text)
                text = ""
            } label: {
                HStack {
                    Text("Create Link")
                    Image(systemName: "link")
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .foregroundStyle(.white)
                .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(.rect(cornerRadius: 12))
            }
            .padding(.bottom, 30)
            
            if (linksViewModel.messageError != nil) {
                Text(linksViewModel.messageError!)
                    .bold()
                    .foregroundStyle(.red.gradient)
            }
            
            
            // MARK: Links List
            List {
                ForEach(linksViewModel.links) { link in
                    VStack {
                        Text(link.title)
                            .bold()
                            .lineLimit(4)
                            .padding(.bottom, 8)
                        Text(link.url)
                            .foregroundStyle(.gray)
                            .font(.caption)
                        HStack {
                            Spacer()
                            if link.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .foregroundStyle(.blue)
                                    .frame(width: 10, height: 10)
                            }
                            if link.isFavorited {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .foregroundStyle(.yellow)
                                    .frame(width: 10, height: 10)
                            }
                        }
                        Divider()
                            .padding()
                    }
                    .swipeActions(edge: .leading) {
                        Button(action: {
                            linksViewModel.updateIsFavorited(link: link)
                        }, label: {
                            Label("Favorite", systemImage: "star.fill")
                        })
                        .tint(.yellow)
                        
                        Button(action: {
                            linksViewModel.updateIsCompleted(link: link)
                        }, label: {
                            Label("Completed", systemImage: "checkmark.circle.fill")
                        })
                        .tint(.blue)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(action: {
                            linksViewModel.detele(link: link)
                        }, label: {
                            Label("Detele", systemImage: "trash.fill")
                        })
                        .tint(.red)
                    }
                }
            }
        }
        .task {
            linksViewModel.getAllLinks()
        }
    }
}

#Preview {
    LinksView(linksViewModel: LinkViewModel())
        .preferredColorScheme(.dark)
}

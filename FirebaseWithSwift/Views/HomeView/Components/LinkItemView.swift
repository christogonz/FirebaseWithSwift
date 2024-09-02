//
//  LinkItemView.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-09-02.
//

import SwiftUI

struct LinkItemView: View {
    var linkTitle: String = "Supabase"
    var linkURL: String = "https://supabase.com"
    @State var isCompleted: Bool = true
    @State var isFavorited: Bool = true
    var deteleLink: Void
    
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(linkTitle)
                Text(linkURL)
            }
            
            HStack(spacing: 16) {
                Spacer()
                Button(action: {
                    isCompleted.toggle()
                }, label: {
                    Image(systemName: isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                        .tint(isCompleted ? .blue : .white)
                })
                
                Button(action: {
                    isFavorited.toggle()
                }, label: {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                        .tint(isFavorited ? .red : .white)
                })
                
                Button(action: {
                    deteleLink
                }, label: {
                    Image(systemName: "trash")
                        .tint(.red)
                })
            }
            .font(.headline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(LinearGradient(colors: [.purple, .blue, .black], startPoint: .leading, endPoint: .trailing))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    LinkItemView(deteleLink: {}())
        .preferredColorScheme(.dark)
}


//
//  SettingsView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 2.1.2023.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @Environment(\.openURL) var openURL
    //@Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    let email = "support@nordicprograms.com"
    
    var body: some View {
        NavigationView {
            
            List {
                Section {
                    Button(action:{
                        mailto(email)
                    }) {
                        SettingsCell(title: "Contact us", imgName: "envelope.fill", color: .accentColor)
                        
                    }
                    Button(action:{
                        if let url = URL(string: "https://www.nordicprograms.com/contact") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        SettingsCell(title: "Give feedback", imgName: "exclamationmark.triangle.fill", color: .accentColor)
                        
                    }
                    Button(action:{
                        self.writeReview()
                    }) {
                        SettingsCell(title: "Rate the app", imgName: "star", color: .accentColor)
                        
                    }
                }
                // TODO: Tee privacy policy tälle apille
                Section {
                    Button(action:{
                        if let url = URL(string: "https://www.nordicprograms.com/privacyfishingdiary") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        SettingsCell(title: "Privacy Policy", imgName: "network.badge.shield.half.filled", color: .accentColor)
                        
                    }
                }
                
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: dismiss, label: {
                            Circle()
                                .fill(Color(.secondarySystemBackground))
                                .frame(width: 40, height: 30) // You can make this whatever size, but keep UX in mind.
                                .overlay(
                                    Image(systemName: "xmark")
                                        .font(.system(size: 15, weight: .bold, design: .rounded)) // This should be less than the frame of the circle
                                        .foregroundColor(.secondary)
                                )
                        })
                        .buttonStyle(PlainButtonStyle())
                        .accessibilityLabel(Text("Close"))
                    }
                }
                
            } //:LIST
            .navigationBarTitle("Settings")
            
            
        } //: NAVIGATION
        
    }
    //self.presentationMode.wrappedValue.dismiss()
    func mailto(_ email: String) {
        let mailto = "mailto:\(email)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(mailto ?? "")
        if let url = URL(string: mailto!) {
            openURL(url)
        }
    }
    
    func writeReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

//
//  10_toolbar.swift
//  studySwift
//
//  Created by YunXing on 2023/2/21.
//

import Foundation

import SwiftUI


//设置TollbarItem项是每个按钮
//有很多样式可以选择
//不仅可以用于导航栏，可以用在任意的工具栏中


struct StudyToobar : View {
    @State private var buttonIdentifier = "initial state"
    @State private var showSheet = false
    
    var body: some View {
        
        //设置工具栏
//        NavigationView {
//            Text("Hello World!").navigationTitle("navigation")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button("Edit") {
//                            print("Edit")
//                        }
//                    }
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button("Back") {
//                            print("back")
//                        }
//                    }
//                }
//        }
        
        NavigationView {
                   VStack {
                       Spacer()
                       Text( $buttonIdentifier.wrappedValue )
                       Spacer()
                       Button( "Present Sheet" )
                           { showSheet = true }
                       Spacer()
                   }
                   .toolbar {
                       ToolbarItem( placement: .navigationBarLeading )
                           { Button( "Save", action: reportSave ) }
                       ToolbarItem( placement: .navigationBarTrailing )
                           { Button( "Cancel", action: reportCancel ) }
                   }
                   .navigationBarTitle( "MAIN" )
               }
               .sheet(isPresented: $showSheet )
                   { PresentedView(buttonIdentifier: $buttonIdentifier ) }
        
    }
    
    
    
    private func reportSave()
      {
          buttonIdentifier = "save"
      }

      private func reportCancel()
      {
          buttonIdentifier = "cancel"
      }

}


struct PresentedView: View {

    // MARK: API
    @Binding var buttonIdentifier: String

    // MARK: instance variables
    @Environment( \.presentationMode ) var mode

    //.confirmationAction

    var body: some View {
        NavigationView {
            Text( "Tap action buttons" )
                .toolbar {
                    ToolbarItem( placement: .confirmationAction )
                        { Button( "Confirm", action: reportConfirm ) }
                    ToolbarItem( placement: .cancellationAction )
                        { Button( "Deny", action: reportDenied ) }
                }
                .navigationBarTitle( "SHEET" )
        }
    }

    private func reportDenied() {
        buttonIdentifier = "sheet denied"
        self.mode.wrappedValue.dismiss()
    }

    private func reportConfirm() {
        buttonIdentifier = "sheet confirmed"
        self.mode.wrappedValue.dismiss()
    }
}



struct StudyToobar_Previews: PreviewProvider {
    static var previews: some View {
        StudyToobar()
    }
}

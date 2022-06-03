//
//  ProjectCellView.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import Foundation
import SwiftUI

struct ProjectCellView: View {
    var projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(projectVM.projectName)
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
            Text(projectVM.projectDescription)
                .font(.subheadline)
        }
        .padding()
        .foregroundColor(projectVM.projectCellColor.accessibleFontColor)
    }
}

struct ProjectCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCellView(projectVM: ProjectViewModel())
    }
}

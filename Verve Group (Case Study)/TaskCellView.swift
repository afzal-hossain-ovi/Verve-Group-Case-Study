//
//  TaskCellView.swift
//  Verve Group (Case Study)
//
//  Created by Afzal Hossain on 02.06.22.
//

import SwiftUI

struct TaskCellView: View {
    @ObservedObject var taskVM: TaskViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(taskVM.taskTitle)")
                    .strikethrough(taskVM.isCompleted, color: .primary)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Text("\(taskVM.taskDescription)")
                    .strikethrough(taskVM.isCompleted, color: .primary)
                    .font(.subheadline)
            }
            .padding()
        }
    }
}

struct TaskCellView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCellView(taskVM: TaskViewModel())
    }
}

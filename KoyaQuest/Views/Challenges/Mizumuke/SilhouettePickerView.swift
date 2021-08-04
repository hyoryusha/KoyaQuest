//
//  SilhouettePickerView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/12.
//

import SwiftUI
import UIKit

struct SilhouettePickerView: UIViewRepresentable {
     @Binding var cols: [Int]

    var pickerData: [[String]] =
        [
            ["silhouette_1", "silhouette_2", "silhouette_3" ],
            ["silhouette_2", "silhouette_3", "silhouette_1" ],
            ["silhouette_3", "silhouette_1", "silhouette_2" ]
        ]

    func makeCoordinator() -> SilhouettePickerView.Coordinator {
        return SilhouettePickerView.Coordinator(self, viewModel: MizumukeChallengeViewModel())
    }

    func makeUIView(context: UIViewRepresentableContext<SilhouettePickerView>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<SilhouettePickerView>) {

    }

    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: SilhouettePickerView
        var correct = false
        var viewModel: MizumukeChallengeViewModel
        init(_ pickerView: SilhouettePickerView, viewModel: MizumukeChallengeViewModel) {
            self.parent = pickerView
            self.viewModel = viewModel
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return parent.pickerData.count
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return parent.pickerData[component].count
        }

        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return UIScreen.main.bounds.width/3 - 30
        }

        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 126
        }

        func pickerView(_ pickerView: UIPickerView,
                        viewForRow row: Int,
                        forComponent component: Int,
                        reusing view: UIView?) -> UIView {

            let view = UIView(
                frame: CGRect(
                            x: 0, y: 0,
                            width: pickerView.bounds.width,
                            height: 0
                )
            )

            let imageView = UIImageView(frame: CGRect(x: 2, y: 0, width: 90, height: 126))
            for _ in 0..<self.parent.pickerData.count {
                imageView.image = UIImage(named: self.parent.pickerData[component][row])
            }
            view.addSubview(imageView)
            return view
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let leftCol = pickerView.selectedRow(inComponent: 0)
            let middleCol = pickerView.selectedRow(inComponent: 1)
            let rightCol = pickerView.selectedRow(inComponent: 2)
            self.parent.cols = [leftCol, middleCol, rightCol]

        }
    }
}

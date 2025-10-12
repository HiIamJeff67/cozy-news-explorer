import SwiftUI

struct HTMLText: UIViewRepresentable {
    let html: String
    var textColor: UIColor

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        guard let data = html.data(using: .utf8) else {
            uiView.text = html // fallback 顯示原始文字
            return
        }
        
        print("success")

        if let attributedString = try? NSAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        ) {
            uiView.attributedText = attributedString
        } else {
            uiView.text = html
        }
        uiView.textColor = textColor
    }
}

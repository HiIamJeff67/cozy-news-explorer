import UIKit

// Inspired by [StackOverflow](https://stackoverflow.com/questions/39546856/how-to-open-a-url-in-swift)
func goToMyGithub() -> Void {
    guard let url = URL(string: "https://github.com/HiIamJeff67") else {
      return
    }
    
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
        UIApplication.shared.openURL(url)
    }
}

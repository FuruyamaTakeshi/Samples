// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation
import UIKit
import SampleSelectableDate

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: nil)
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func performSegue<S: StoryboardSegueType>(segue: S, sender: AnyObject? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

enum StoryboardScene {
  enum InputBloodPressureViewController: String, StoryboardSceneType {
    static let storyboardName = "InputBloodPressureViewController"

    static func initialViewController() -> SampleSelectableDate.InputBloodPressureViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? SampleSelectableDate.InputBloodPressureViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case InputBloodPressureViewControllerScene = "InputBloodPressureViewController"
    static func instantiateInputBloodPressureViewController() -> SampleSelectableDate.InputBloodPressureViewController {
      guard let vc = StoryboardScene.InputBloodPressureViewController.InputBloodPressureViewControllerScene.viewController() as? SampleSelectableDate.InputBloodPressureViewController
      else {
        fatalError("ViewController 'InputBloodPressureViewController' is not of the expected class SampleSelectableDate.InputBloodPressureViewController.")
      }
      return vc
    }
  }
  enum InputWeightViewController: String, StoryboardSceneType {
    static let storyboardName = "InputWeightViewController"

    static func initialViewController() -> SampleSelectableDate.InputWeightViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? SampleSelectableDate.InputWeightViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case InputWeightViewControllerScene = "InputWeightViewController"
    static func instantiateInputWeightViewController() -> SampleSelectableDate.InputWeightViewController {
      guard let vc = StoryboardScene.InputWeightViewController.InputWeightViewControllerScene.viewController() as? SampleSelectableDate.InputWeightViewController
      else {
        fatalError("ViewController 'InputWeightViewController' is not of the expected class SampleSelectableDate.InputWeightViewController.")
      }
      return vc
    }
  }
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: StoryboardSceneType {
    static let storyboardName = "Main"

    static func initialViewController() -> SampleSelectableDate.ViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? SampleSelectableDate.ViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }
  }
}

enum StoryboardSegue {
}

private final class BundleToken {}


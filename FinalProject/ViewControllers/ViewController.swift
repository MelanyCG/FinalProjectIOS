import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, AVPlayerViewControllerDelegate{
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    var playerController = AVPlayerViewController()
    
    @IBOutlet weak var singUpButtun: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(singUpButtun)
        Utilities.styleHollowButton(loginButton)
    }
    
    func setUpVideo() {
        let bundlePath = Bundle.main.path(forResource: Constants.Media.mediaName, ofType: Constants.Media.mediaType)
        guard bundlePath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        let item = AVPlayerItem(url: url)
        
        videoPlayer = AVPlayer(playerItem: item)
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        videoPlayerLayer?.frame = self.view.bounds
        videoPlayerLayer?.videoGravity = .resizeAspectFill
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 0.3)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            self.videoPlayer!.pause()
            self.videoPlayerLayer!.removeFromSuperlayer()
        }
    }
    
}


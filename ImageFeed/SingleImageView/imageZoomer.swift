import UIKit

class imageZoomer: UIScrollView {
    convenience init() {
        self.init(frame: .zero)
    }

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        imageInit()
    }

    func downloadStartImage(_ photo: UIImage) {
        imageView.image = photo
    }

    private func imageInit() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        minimumZoomScale = 1
        maximumZoomScale = 3
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delegate = self

        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapRecognizer)
    }

    @objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        setZoomScale(zoomScale == 1 ? 2 : 1, animated: true)
    }
}

extension imageZoomer: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { imageView }
}

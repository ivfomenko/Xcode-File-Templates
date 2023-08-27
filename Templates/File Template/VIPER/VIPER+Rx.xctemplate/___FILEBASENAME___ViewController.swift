import RxCocoa
import RxSwift

// MARK: - ___VARIABLE_sceneName___ViewController

final class ___VARIABLE_sceneName___ViewController: UIViewController, StoryboardInitializable {

    // - Outlets

    // - Internal properties
    var presenter: ___VARIABLE_sceneName___Presenter!

    // - Private properties
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.configBinding()
    }
}

// MARK: - Private

private extension ___VARIABLE_sceneName___ViewController {

    // - UI Setup
    func configUI() {}

    // - Binding Setup
    func configBinding() {}
}
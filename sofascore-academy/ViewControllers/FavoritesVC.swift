import UIKit

class FavoritesVC: UIViewController {
    let tableView = UITableView()
    var favorites: [Follower]?

    override func viewDidLoad() {
        super.viewDidLoad()

        getFavorites()
        configureViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        getFavorites()
    }

    private func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "ChecklistItem")

        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }

        view.backgroundColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                print(favorites)
                if favorites.isEmpty {
                    self.presentAlertOnMainThread(title: "No favorites", message: "You have to add some users to favorites", buttonTitle: "OK")
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView) 
                    }
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

    private func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = CustomAlertView(alertTitle: title, alertMessage: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }

    private func pushGitHubFollowersVC(follower: Follower) {
        let followersVC = GitHubFollowersVC(followersUrl: follower.followersUrl, title: follower.login)
        navigationController?.pushViewController(followersVC, animated: true)
    }
}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favorites = favorites else { return }
        self.pushGitHubFollowersVC(follower: favorites[indexPath.row])
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let follower = favorites?[indexPath.row] else {
                return
            }
            PersistenceManager.updateWith(favorite: follower, actionType: .remove) { [weak self] _ in
                guard let self = self else { return }
                self.favorites?.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favorites = favorites else {
            return 0
        }

        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: "ChecklistItem",
                    for: indexPath) as? CustomTableViewCell
        else {
            fatalError()
        }

        cell.set(labelText: self.favorites?[indexPath.row].login ?? "")

        return cell
    }
}

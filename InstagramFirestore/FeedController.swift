//
//  FeedController.swift
//  InstagramFirestore
//
//  Created by Anahi Rojas on 30/06/21.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {
   
    //MARK: - Lifecycle
    
    private var posts = [Post]() {
        didSet { collectionView.reloadData()}
    }
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchPosts()
    }
    
    //MARK: - Actions
    
    @objc func handleRefresh(){
        posts.removeAll()
        fetchPosts()
    }
    
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG: Failed to sign out")
        }
        
    }

    //MARK: - API
    
    func fetchPosts() {
        guard post == nil else { return}
        
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.checkIfUserLikedPost()
            
        }
    }
    
    func checkIfUserLikedPost(){
        self.posts.forEach { post in
            PostService.checkIfUserLikedPost(post: post) { didLike in
                //Find the post we're looking at and get it's index
                if let index = self.posts.firstIndex(where: { $0.postId == post.postId }) {
                    self.posts[index].didLike = didLike
                }
            }
            
        }
    }
    
    //MARK: - helpers
    
    func configureUI(){
        collectionView.backgroundColor = .white
        
        //register a collectionCell
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //Add logout button
        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(handleLogout))
        }
        
        
        navigationItem.title = "Feed"
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
        
    }
}

//MARK: - UICollectionViewDataSource

extension FeedController {
    
    //How many cell we're going to create
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
    }
    
    //Defines each cell in the collection view and how to create it
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        cell.delegate = self
        
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }
        
        
        return cell
    }
}

//MARK:- UICollectionViewDelegateFlowLayout

//Change the size of the cells
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        //height of photo posted
        height += 50
        //height of comments, like button, etc
        height += 60
        
        return CGSize(width: width, height: height)
    }
}

//MARK: -FeedCellDelegate

extension FeedController: FeedCellDelegate{
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func cell(_ cell: FeedCell, didLike post: Post) {
        cell.viewModel?.post.didLike.toggle()
        
        if post.didLike {
            PostService.unlikePost(post: post) { _ in
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
                cell.likeButton.tintColor = .black
                cell.viewModel?.post.likes = post.likes - 1
            }
        } else {
            print("DEBUG: Like post here")
            PostService.likePost(post: post) { error in
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_selected"), for: .normal)
                cell.likeButton.tintColor = .red
                cell.viewModel?.post.likes = post.likes + 1
            }
        }
    }
}

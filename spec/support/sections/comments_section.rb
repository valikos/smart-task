class CommentsSection < SitePrism::Section
  element :new_comment_field, '.new-comment'
  element :add_new_comment, '.add-new-comment'

  elements :comment, '.comment-item'
  elements :remove_comment, '.remove-comment'
end
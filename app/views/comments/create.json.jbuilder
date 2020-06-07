json.comment_id      @comment.id
json.comment         @comment.comment
json.comment_user_id @comment.user_id
json.name            @comment.user.nickname
json.comment_item_id @comment.item_id
json.item_id         @item.id
json.item_user_id    @item.user_id
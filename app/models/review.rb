class Review < ApplicationRecord
    belongs_to :product #reviewは1つのproductに属している
    belongs_to :user #reviewは1つのuserに属している
    
    scope :reviews_with_id, -> { where.not(:product_id => nil)}
    # Ex:- scope :active, -> {where(:active => true)}
    scope :star_repeat_select, -> {
        {
            "★★★★★" => 5,
            "★★★★" => 4,
            "★★★" => 3,
            "★★" => 2,
            "★" => 1
        }
    }
    # Ex:- scope :active, -> {where(:active => true)}

    def save_review(review, review_params)
        review.score = review_params[:score] #フォームから送信された評価をデーターベースに保存
        review.content = review_params[:content]
        review.user_id = review_params[:user_id]
        review.product_id = review_params[:product_id]
        save
    end
end

class Category < ApplicationRecord
    has_many :products

    # scopeを使ってメソッド定義を行っている。
    # すべてのカテゴリのデータの中からmajor_category_nameのカラムのみを取得しています。
    # そしてさらにuniqメソッドを使い、重複するデータを削除しています。
    scope :major_categories, -> { pluck(:major_category_name).uniq }
    # これと同じ
    # def self.major_categories
    #     pluck(:major_category_name).uniq
    # end

    scope :request_category, -> (category) { find(category.to_i)}
    # Ex:- scope :active, -> {where(:active => true)}
end

class Book < ApplicationRecord
	belongs_to :user, optional: true
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
    def self.search(method,method2,word)
                if method2 == "forward_match"
                         where("title LIKE?","#{word}%")
                elsif method2 == "backward_match"
                         where("title LIKE?","%#{word}")
                elsif method2 == "perfect_match"
                         where("#{word}")
                elsif method2 == "partial_match"
                         where("title LIKE?","%#{word}%")
                else
                         all
                end
    end
end


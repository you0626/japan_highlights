# テーブル設計

## Users テーブル

| Column	        | Type	    | Options                                                                     |
| --------------- | --------- | --------------------------------------------------------------------------- |
| username	      | string	  | null: false, unique: true                                                   |
| email	          | string	  | null: false, unique: true                                                   |
| password_digest	| string	  | null: false                                                                 |
| created_at	    | datetime	| default: -> { ‘CURRENT_TIMESTAMP’ }                                         |
| updated_at	    | datetime	| default: -> { ‘CURRENT_TIMESTAMP’ }, on_update: -> { ‘CURRENT_TIMESTAMP’ }  |

## Association
-	has_many :posts
-	has_many :comments
-	has_many :likes
-	has_many :reports, foreign_key: :reporter_id


## Posts テーブル

| Column	        | Type	     | Options                                                                     |
| --------------- | ---------- | --------------------------------------------------------------------------- |
| user	          | references | null: false, foreign_key: true                                              |
| title	          | string	   | null: false                                                                 |
| content	        | text       |	                                                                           |
| media_url	      | string	   |                                                                             |
| category	      | references | foreign_key: true                                                           |
| created_at	    | datetime	 | default: -> { ‘CURRENT_TIMESTAMP’ }                                         |
| updated_at	    | datetime	 | default: -> { ‘CURRENT_TIMESTAMP’ }, on_update: -> { ‘CURRENT_TIMESTAMP’ }  |

## Association
-	belongs_to :user
-	belongs_to :category
-	has_many :comments
-	has_many :likes
-	has_many :post_tags
-	has_many :tags, through: :post_tags


## Categories テーブル

| Column      | Type	    | Options                                                                     |
| ----------- | --------- | --------------------------------------------------------------------------- |
| name	      | string	  | null: false, unique: true                                                   |
| created_at	| datetime	| default: -> { ‘CURRENT_TIMESTAMP’ }                                         |
| updated_at	| datetime	| default: -> { ‘CURRENT_TIMESTAMP’ }, on_update: -> { ‘CURRENT_TIMESTAMP’ }  |

## Association
-	has_many :posts


## Tags テーブル

| Column	    | Type	    | Options                              |
| ----------- | --------- | ------------------------------------ |
| name	      | string	  | null: false, unique: true            |
| created_at	| datetime	| default: -> { ‘CURRENT_TIMESTAMP’ }  |

## Association
-	has_many :post_tags
-	has_many :posts, through: :post_tags


## Post_Tags テーブル

| Column  | Type	      | Options                        |
| ------- | ----------- | ------------------------------ |
| post	  | references	| null: false, foreign_key: true |
| tag	    | references	| null: false, foreign_key: true |

## Association
-	belongs_to :post
-	belongs_to :tag


## Comments テーブル

| Column	    | Type	      | Options                                                                     |
| ----------- | ----------- | --------------------------------------------------------------------------- |
| post	      | references	| null: false, foreign_key: true                                              |
| user	      | references	| null: false, foreign_key: true                                              |
| content	    | text	      | null: false                                                                 |
| created_at	| datetime	  | default: -> { ‘CURRENT_TIMESTAMP’ }                                         |
| updated_at	| datetime	  | default: -> { ‘CURRENT_TIMESTAMP’ }, on_update: -> { ‘CURRENT_TIMESTAMP’ }  |

## Association
-	belongs_to :post
-	belongs_to :user


## Likes テーブル

| Column	    | Type	      | Options                              |
| ----------- | ----------- | ------------------------------------ |
| user	      | references	| null: false, foreign_key: true       |
| post	      |references	  | null: false, foreign_key: true       |
| created_at	| datetime	  | default: -> { ‘CURRENT_TIMESTAMP’ }  |

## Association
-	belongs_to :user
-	belongs_to :post


## Reports テーブル

| Column	      | Type	      | Options                                         |
| ------------- | ----------- | ----------------------------------------------- |
| reporter	    | references	| null: false, foreign_key: { to_table: :users }  |
| reported_type	| string	    | null: false                                     |
| reported_id	  | integer	    | null: false                                     |
| reason	      | text	      |                                                 |
| created_at	  | datetime	  | default: -> { ‘CURRENT_TIMESTAMP’ }             |

## Association
-	belongs_to :reporter, class_name: ‘User’

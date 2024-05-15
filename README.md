# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル

|Column|Type|Options|
|------|----|-------|
| nickname | string | null:false |
| email | string | null:false,unique:true |
| password | string | null:false,unique:true |
| last_name | string | null:false |
| first_name | string | null:false |
| last_name_kana | string | null:false |
| first_nama_kana | string | null:false |
| birthday | date | null:false |

## Association
- has_many:items
- has_many:orders
- has_many:comments

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
| user | references | null:false |
| name | string | null:false |
| description | text | null:false |
| price | integer | null:false |

## Association
- belongs_to:user
- has_one:order
- has_many:comments

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
| user | references | null:false,foreign_key: true |
| item | references | null:false,foreign_key: true |

## Association
- belongs_to:user
- belongs_to:item
- has_one:payment

## paymentsテーブル
|Column|Type|Options|
|------|----|-------|
| order | references | null:false,foreign_key:true |
| postcode | string | null:false |
| city | string | null:false |
| block | string | null:false |
| building | string |
| phone_number | string | null:false |

## Association
- belongs_to:order

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
| user | references | null:false,foreign_key:true |
| item | references | null:false,foreign_key:true |
| text | text | null:false |

## Association
- belongs_to:user
- belongs_to:item
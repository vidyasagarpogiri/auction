# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130730040722) do

  create_table "aboutmeimgs", :force => true do |t|
    t.integer  "user_id"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "blacklists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "block_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dealasks", :force => true do |t|
    t.integer  "deal_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "deallogs", :force => true do |t|
    t.integer  "deal_id"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "deals", :force => true do |t|
    t.integer  "product_id"
    t.string   "serialnum"
    t.string   "productname"
    t.integer  "amount"
    t.integer  "shippingfee"
    t.string   "shippingway"
    t.string   "shippingcode"
    t.date     "paydate"
    t.string   "paytime"
    t.string   "payaccount"
    t.string   "paytype"
    t.string   "status"
    t.integer  "buyer_id"
    t.string   "buyertel"
    t.string   "buyername"
    t.integer  "seller_id"
    t.string   "sellertel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dealvalues", :force => true do |t|
    t.integer  "deal_id"
    t.integer  "user_id"
    t.string   "value"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orderasks", :force => true do |t|
    t.integer  "order_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "orders", :force => true do |t|
    t.integer  "stock_id"
    t.string   "productname"
    t.integer  "productprice"
    t.integer  "shippingfee"
    t.string   "shippingway"
    t.string   "shippingcode"
    t.string   "ordernum"
    t.date     "paydate"
    t.string   "paytime"
    t.string   "payaccount"
    t.string   "paytype"
    t.string   "status"
    t.integer  "buyer_id"
    t.string   "buyertel"
    t.string   "buyername"
    t.integer  "saler_id"
    t.string   "salertel"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "amount"
    t.string   "producttype"
  end

  create_table "ordervalues", :force => true do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "value"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "productaskres", :force => true do |t|
    t.integer  "productask_id"
    t.text     "content"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "productasks", :force => true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "status"
  end

  create_table "productclasses", :force => true do |t|
    t.integer  "parent_class"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "productimgs", :force => true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "image"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.string   "status"
    t.string   "cover"
    t.string   "region"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.integer  "amount"
  end

  create_table "status_logs", :force => true do |t|
    t.integer  "user_id"
    t.string   "status"
    t.text     "reason"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "tel"
    t.string   "name"
    t.text     "aboutme"
    t.text     "accountinfo"
    t.string   "status"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

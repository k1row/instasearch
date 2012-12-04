# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  # User Nameに関するチェック
  validates :user_name, :presence => true,
  :length => {:minimum => 2, :maximum => 10}
  
  # Mail Addressに関するチェック
  validates :mail_address, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

  attr_accessible :id, :mail_address, :password, :user_id, :user_name
end

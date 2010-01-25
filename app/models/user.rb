class User < ActiveRecord::Base
  acts_as_authentic do |conf|
    conf.merge_validates_confirmation_of_password_field_options(:unless => Proc.new {|user| !user.register })
    conf.merge_validates_length_of_password_confirmation_field_options(:unless => Proc.new {|user| !user.register })
    conf.merge_validates_length_of_password_field_options(:unless => Proc.new {|user| !user.register })
  end
  
  has_attached_file :avatar,
                    :styles => {:large => '95x95>', :standard => '65x65>', :small => '55x56>'},
                    :default_url => '/images/no_picture.png',
                    :url => '/system/users/:id/avatars/:style.:extension',
                    :path => ':rails_root/public/system/users/:id/avatars/:style.:extension'
  
  has_many :user_conversations
  has_many :conversations, :through => :user_conversations, :order => 'updated_at DESC'
  
  has_many :user_groups
  has_many :groups, :through => :user_groups
  
  named_scope :enabled, :conditions => 'active = 1 AND banned = 0'
  named_scope :basic_admin, :conditions => 'admin = 1 AND super_user = 0'
  
  validates_presence_of :name
  validates_confirmation_of :email, :on => :update
  
  attr_accessor :register, :note, :activation_url
  
  def activate!
    write_attribute(:active, true)
  end
  
  def register=(value)
    @register = value == "0" ? false : true
  end
  
  def ban!
    self.banned = true
    save!
  end
end

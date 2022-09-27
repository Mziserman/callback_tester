class Callbacker < ApplicationRecord

  belongs_to :has_one, optional: true
  belongs_to :has_many, optional: true
  has_many :belongs_tos, dependent: :destroy

  def to_s
  "#{self.class}##{id || 'nil'}"
  end

  # create/update
  before_validation do |record|
    puts"before_validation called for #{record}".blue.underline
  end

  after_validation do |record|
    puts"after_validation called for #{record}".blue.underline
  end

  before_save do |record|
    puts"before_save called for #{record}".cyan.underline
  end

  around_save :around_save_callback
  def around_save_callback
    puts"around_save before called for #{self}".cyan.underline
    yield
    puts"around_save after called for #{self}".cyan.underline
  end

  after_save do |record|
    puts"after_save called for #{record}".cyan.underline
  end

  after_commit ->(record){ puts"after_commit called for #{record}".green.underline }, on: :create
  after_commit ->(record){ puts"after_commit called for #{record}".yellow.underline }, on: :update
  after_commit ->(record){ puts"after_commit called for #{record}".red.underline }, on: :destroy

  after_rollback do |record|
    puts"after_rollback called for #{record}".magenta.underline
  end

  # update
  before_update do |record|
    puts"before_update called for #{record}".yellow.underline
  end

  around_update :around_update_callback
  def around_update_callback
    puts"around_update before called for #{self}".yellow.underline
    yield
    puts"around_update after called for #{self}".yellow.underline
  end

  after_update do |record|
    puts"after_update called for #{record}".yellow.underline
  end

  # create
  before_create do |record|
    puts"before_create called for #{record}".green.underline
  end

  around_create :around_create_callback
  def around_create_callback
    puts"around_create before called for #{self}".green.underline
    yield
    puts"around_create after called for #{self}".green.underline
  end

  after_create do |record|
    puts"after_create called for #{record}".green.underline
  end

  # destroy
  before_destroy do |record|
    puts"before_destroy called for #{record}".red.underline
  end

  around_destroy :around_destroy_callback
  def around_destroy_callback
    puts"around_destroy before called for #{self}".red.underline
    yield
    puts"around_destroy after called for #{self}".red.underline
  end

  after_destroy do |record|
    puts"after_destroy called for #{record}".red.underline
  end

  # initialize
  after_initialize do |record|
    puts"after_initialize called for #{record}".white.on_red.underline
  end

  # find
  after_find do |record|
    puts"after_find called for #{record}".white.on_red.underline
  end

  # touch
  after_touch do |record|
    puts"after_touch called for #{record}".white.on_red.underline
  end
end

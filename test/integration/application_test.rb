# encoding: utf-8
require './test/test_helper'

describe SiSINTA::Application do
  subject { SiSINTA::Application.config }

  describe 'session_store' do
    it 'usa el cache general' do
      subject.session_store.must_equal ActionDispatch::Session::CacheStore
    end
  end

  describe 'cache_store' do
    it 'usa memcached' do
      subject.cache_store.must_equal :dalli_store
      Rails.cache.must_be_instance_of ActiveSupport::Cache::DalliStore
    end
  end
end

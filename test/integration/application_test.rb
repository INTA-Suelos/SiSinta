# encoding: utf-8
require './test/test_helper'

describe SiSINTA::Application do
  subject { SiSINTA::Application.config }

  describe 'session_store' do
    it 'usa memcached' do
      subject.session_store.must_equal ActionDispatch::Session::LibmemcachedStore
    end
  end
end

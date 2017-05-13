require 'test_helper'

describe ColoresController do
  subject { create :color }

  it 'autocompleta hvc' do
    termino = subject.hvc

    get :autocomplete_color_hvc, term: termino

    must_respond_with :success
    json.size.must_equal Color.where("hvc like '%#{termino}%'").size

    json.first.include?('id').must_equal true
    json.first.include?('label').must_equal true
    json.first.include?('value').must_equal true
  end

  it 'autocompleta rgb' do
    termino = subject.rgb

    get :autocomplete_color_rgb, term: termino

    must_respond_with :success
    json.size.must_equal Color.where("rgb like '%#{termino}%'").size

    json.first.include?('id').must_equal true
    json.first.include?('label').must_equal true
    json.first.include?('value').must_equal true
  end
end

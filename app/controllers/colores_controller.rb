# encoding: utf-8
class ColoresController < ApplicationController
  autocomplete :color, :rgb, full: true
  autocomplete :color, :hvc, full: true
end

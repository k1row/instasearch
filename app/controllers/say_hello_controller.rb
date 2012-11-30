# -*- coding: utf-8 -*-
class SayHelloController < ApplicationController
  def hello_world
    # id = params['id']
    # @msg = "あなたのIDは、" + id + "です。"

    str = "テキストを入力"
    str2 = params['txt1']
    if str2 != nil then
      str = "あなたは、「" + str2 + "」と書きました。"
    end
    @msg = str
  end
end

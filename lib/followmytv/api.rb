
require 'rest-client'
require 'nokogiri'

module Followmytv
  module API

    attr_accessor :cookies

    def cookies
      @cookies ||= {}
    end


    def form_get(path, form_selector, params = {})
      form_params = fetch_init_form(path, form_selector)
      form_params.merge!(params)

      Nokogiri(perform_get(path, form_params))
    end

    def form_post(path, form_selector, params = {})
      form_params = fetch_init_form(path, form_selector)
      form_params.merge!(params)

      Nokogiri(perform_post(path, form_params))
    end

    def ajax_get(path, params = {})
      JSON.parse(perform_get(path, params, 'X-Requested-With' => 'XMLHttpRequest'))
    end

    def ajax_post(path, params = {})
      JSON.parse(perform_post(path, params, 'X-Requested-With' => 'XMLHttpRequest'))
    end





    private

    def cleanup_params(params)
      params.select { |key, value|
        !key.nil? && key.length > 0
      }
    end

    def perform_get(path, params = {}, headers = {})
      headers[:params] = cleanup_params(params)
      headers[:cookies] = cookies

      response = RestClient.get(create_url(path), headers)

      cookies.merge!(response.cookies)

      response
    end

    def perform_post(path, params = {}, headers = {})
      headers[:cookies] = cookies

      response = RestClient.post(create_url(path), params, headers)

      cookies.merge!(response.cookies)

      response
    end

    # @param form [Nokogiri::HTML::Node]
    #
    def parse_inputs(form)
      original_params = {}
      form.css('input').each do |input|
        original_params[input['name']] = input['value']
      end

      original_params
    end

    # @param path [String]
    # @param form_selector [String]
    #
    # @return [Hash]
    #
    def fetch_init_form(path, form_selector)
      init_response = perform_get(path)

      form = Nokogiri::HTML(init_response).at_css(form_selector)

      parse_inputs(form)
    end

    def create_url(path)
      "http://followmy.tv/#{path}"
    end
  end
end
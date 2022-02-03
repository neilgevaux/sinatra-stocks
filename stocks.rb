require 'sinatra'
require 'yaml/store'

get '/' do
  @title = 'Welcome to Stocks!'
  erb :index
end

post '/stocks' do
    @title = 'Thanks for picking your stock!'
    @company  = params['company']
    @store = YAML::Store.new 'companies.yml'
    @store.transaction do
        @store['companies'] ||= {}
        @store['companies'][@company] ||= 0
        @store['companies'][@company] += 1
      end
    erb :stocks
  end

  get '/results' do
    @title = 'Stocks:'
    @store = YAML::Store.new 'companies.yml'
    @companies = @store.transaction { @store['companies'] }
    erb :results
  end

Stocks = {
    'AAPL' => 'Apple Inc.',
    'GOOG' => 'Alphabet',
    'FB' => 'Meta',
    'AMZN' => 'Amazon',
  }
json.extract! purchase, :id, :date, :total_price, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)

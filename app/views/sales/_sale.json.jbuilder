json.extract! sale, :id, :date, :total_price, :created_at, :updated_at
json.url sale_url(sale, format: :json)

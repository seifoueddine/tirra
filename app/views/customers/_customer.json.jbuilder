json.extract! customer, :id, :raison, :phone, :created_at, :updated_at
json.url customer_url(customer, format: :json)

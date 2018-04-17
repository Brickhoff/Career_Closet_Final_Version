json.extract! history, :id, :suit_id, :user_id, :checkOutTime, :expectReturnTime, :returnTime, :created_at, :updated_at
json.url history_url(history, format: :json)

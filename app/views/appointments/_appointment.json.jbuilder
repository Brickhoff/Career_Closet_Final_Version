json.extract! appointment, :id, :time, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
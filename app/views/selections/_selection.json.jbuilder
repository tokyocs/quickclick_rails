json.extract! selection, :id, :student_id, :problem_id, :session_id, :answer, :response_timing, :created_at, :updated_at
json.url selection_url(selection, format: :json)
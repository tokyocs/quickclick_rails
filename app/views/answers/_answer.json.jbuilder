json.extract! answer, :id, :student_id, :problem_id, :session_id, :answer, :response_timing, :created_at, :updated_at
json.url answer_url(answer, format: :json)
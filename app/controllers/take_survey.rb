post '/surveys/:survey_id/taken_surveys' do
  current_survey = Survey.find(params[:survey_id])
  TakenSurvey.create(survey_id: current_survey.id, user_id: 2)
  redirect to "/surveys/#{current_survey.id}/questions/1"
end

get '/surveys/:survey_id/questions/:question_id' do
  @survey = Survey.find(params[:survey_id])
  @question = Question.find(params[:question_id])
  erb :question_take
end

post '/surveys/:survey_id/questions/:question_id/answers_users' do
  survey = Survey.find(params[:survey_id])
  question  = Question.find(params[:question_id])
  AnswersUser.create(user_id: 2, possible_answer_id: params[:possible_answer_id])
  next_question = next_question(survey)
  if next_question != nil
    redirect to "/surveys/#{survey.id}/questions/#{next_question.id}"
  else
    redirect to "/surveys/#{survey.id}/results"
  end
end

get '/surveys/:survey_id/results' do
  @survey = Survey.find(params[:survey_id])
  @questions = @survey.questions
  @taken_survey = TakenSurvey.find_by_user_id_and_survey_id(2,1)
  @users_responses = @survey.answers_users.where("user_id = ?", 2)
  @responses = AnswersUser.all
  erb :results
end

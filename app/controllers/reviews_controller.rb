# encoding: utf-8
class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = Review.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end

  # POST /reviews
  # POST /reviews.json
  def create
    if current_user
      @review = current_user.reviews.build(params[:review])

      respond_to do |format|
        if @review.save
          flash[:success] = 'Запись успешно добавлена!'
          format.html { redirect_to reviews_path }
          format.json { render json: @review, status: :created, location: reviews_path }
        else
          format.html { render action: "new" }
          format.json { render json: @review.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error] = 'Вы должны войти в систему!'
      redirect_to root_path
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
    end
  end
end

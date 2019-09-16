class ReviewsController < ApplicationController

  # check if loged in
  before_action :check_login, except: [:index, :show]


  def index
    # this is our list page for our reviews
    @price = params[:price]
    @cuisine = params[:cuisine]
    @location = params[:location]

    # start with all the reviews
    @reviews = Review.all

    #filtering by price
    if @price.present?
      @reviews = @reviews.where(price: @price)
    end

    #filtering by Cuisine
    if @cuisine.present?
      @reviews = @reviews.where(cuisine: @cuisine)
    end

    #search near the location
    if @location.present?
      @reviews = @reviews.near(@location)
    end

  end





  def new
    #the form for adding a new review
    @review = Review.new
  end


  def create
    # take info from form and add to model
    @review = Review.new(forms_params)

    # and then assosiate it to a user
    @review.user = @current_user

    # we want to check if the model can be saved based on params
    # if it is, we're going to the home page again
    # if not, show the new form
    if @review.save
      redirect_to root_path
    else
      #show the view for new
      render "new"
    end
  end


  def show
    #individual review page
    @review = Review.find(params[:id])
  end


  def destroy
    # find the individual review
    @review = Review.find(params[:id])
    #destroy
    @review.destroy
    # refirect to the home page
    redirect_to root_path
  end


  def edit
    #find the inidividual page
    @review = Review.find(params[:id])
  end


  def update
    #find the inidifual page
    @review = Review.find(params[:id])
    #update with the new info
    if @review.update(forms_params)
      #redirect to review
      redirect_to review_path(@review)
    else
      render "edit"
    end
  end


  def forms_params
    params.require(:review).permit(:title, :restaurant, :body, :price, :cuisine, :score, :ambiance, :address)
  end




end

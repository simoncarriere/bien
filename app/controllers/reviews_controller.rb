class ReviewsController < ApplicationController


  def index
    # this is our list page for our reviews
    @reviews = Review.all

  end


  def new
    #the form for adding a new review
    @review = Review.new
  end


  def create
    # take info from forma nd add to db
    @review = Review.new(forms_params)

    #save this to db
    @review.save

    #redirect back to homepage
    redirect_to root_path
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
    #fnd the inidividual page
    @review = Review.find(params[:id])

  end


  def update
    #find the inidifual page
    @review = Review.find(params[:id])


    #update with the new info
    @review.update(forms_params)

    #redirect to review
    redirect_to review_path(@review)

  end


  def forms_params
    params.require(:review).permit(:title, :body, :score)
  end




end

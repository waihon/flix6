require 'rails_helper'

describe "Creating a new review" do
  context "when signed in" do
    before do
      @user = User.create!(user_attributes)
      sign_in(@user)
    end

    it "saves the review from movie show page" do
      movie = Movie.create(movie_attributes)

      visit movie_url(movie)

      expect(page).to have_selector("input[type=submit][value='Post Review']")

      choose("review_stars_3")
      fill_in "Comment", with: "I laughed, I cried, I spilled my popcorn!"

      click_button "Post Review"

      expect(current_path).to eq(movie_reviews_path(movie))

      expect(page).to have_text("Thanks for your review!")
      expect(page).to have_text(@user.name)
    end

    it "saves the review from review new page" do
      movie = Movie.create(movie_attributes)

      visit movie_reviews_url(movie)

      click_link "Write Review"

      expect(current_path).to eq(new_movie_review_path(movie))

      choose("review_stars_3")
      fill_in "Comment", with: "I laughed, I cried, I spilled my popcorn!"

      click_button "Post Review"

      expect(current_path).to eq(movie_reviews_path(movie))

      expect(page).to have_text("Thanks for your review!")
      expect(page).to have_text(@user.name)
    end

    it "does not save the review if it's invalid" do
      movie = Movie.create(movie_attributes)

      visit new_movie_review_url(movie)

      expect {
        click_button "Post Review"
      }.not_to change(Review, :count)

      expect(page).to have_text("error")
    end
  end
end
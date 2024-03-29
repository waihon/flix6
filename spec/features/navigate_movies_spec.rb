require 'rails_helper'

describe "Navigating movies" do
  it "allows navigation from the detail page to the listing page" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_css("a", text: "Released", class: nil)
    expect(page).to have_css("a", text: "Upcoming", class: nil)

    click_link "Released"
    
    expect(current_path).to eq(movies_path)
    expect(page).to have_css("a", text: "Released", class: "active")
    expect(page).to have_css("a", text: "Upcoming", class: nil)
  end

  it "allows navigation from the listing page to the details page" do
    movie = Movie.create(movie_attributes)

    visit movies_url

    click_link movie.title

    expect(current_path).to eq(movie_path(movie))
  end

  it "allows navigation from the root URL to the listing page" do
    movie1 = Movie.create(movie_attributes(title: "Iron Man"))
    movie2 = Movie.create(movie_attributes(title: "Superman"))
    movie3 = Movie.create(movie_attributes(title: "Batman"))

    visit root_url

    expect(page).to have_text(movie1.title)
    expect(page).to have_text(movie2.title)
    expect(page).to have_text(movie3.title)
  end

  it "allows navigation from logo to the root page" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)
    expect(page).to have_css("img[src*='logo']")

    find(:xpath, "//a/img[@id='header-logo']/..").click
    expect(current_path).to eq(root_path)
  end
end
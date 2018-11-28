class DashboardController < ApplicationController
  def index
    load_recently_heard
    load_recomendations
  end

  private

  def load_recently_heard
    @recent_albums = current_user.recently_heards.order("created_at DESC")
                     .limit(4).map(&:album)
  end

  def load_recomendations
    heard_categories = @recent_albums.map(&:category)
    @recommended_albums = Album.joins(:category, :songs)
                               .where(category: heard_categories)
                               .order("songs.played_count")
                               .select("distinct albums.*").limit(4)
  end
end

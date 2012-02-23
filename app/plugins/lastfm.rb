# encoding: utf-8
class Lastfm
  include Cinch::Plugin

  match /^[zurg].+o que (.+) anda fazendo no lastfm[?]$/i, :use_prefix => false, :method => :recent_musics
  match /^[zurg].+mais informações sobre (.+)[!]$/i, :use_prefix => false, :method => :band_information

  def initialize(*args)
    super
    Rockstar.lastfm = { :api_key => ENV['LASTFM_KEY'], :api_secret => ENV['LASTFM_SECRET'] }
  end

  def recent_musics(m, nick)
    Rockstar::User.new(nick).recent_tracks[0,5].each do |track|
      m.reply "#{track.name} (#{track.artist} - #{track.album})", true
    end
  end

  def band_information(m, band)
    artist = Rockstar::Artist.new(band, :include_info => true)
    m.reply "#{artist.summary.gsub(/<[^>]+>/, "")}", true if !artist.summary.blank?
  end
end

module FellowshipsHelper
  def to_json(hash)
    raw(hash.to_json.gsub("'", %q(\\\')))
  end
end

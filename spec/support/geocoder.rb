Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.add_stub(
  "Los Angeles", [
    {
      'latitude'     => 34.0522342,
      'longitude'    => -118.2436849
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  "Las Vegas", [
    {
      'latitude'     => 36.1699412,
      'longitude'    => -115.1398296
    }
  ]
)

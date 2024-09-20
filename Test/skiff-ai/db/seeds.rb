# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def init_user
  return if User.exists?

  users = [
    {
      username: "effyic-test-01",
      password: "ilx6re1ehnz66qj0"
    },
    {
      username: "effyic-test-02",
      password: "k411uyr6l6k41ogo"
    },
    {
      username: "effyic-test-03",
      password: "zbi3790w21xhg0te"
    },
    {
      username: "effyic-test-04",
      password: "2r1i90krbxkguwu6"
    },
    {
      username: "effyic-test-05",
      password: "g6vq7n37ygikakm4"
    },
    {
      username: "effyic-test-06",
      password: "hvui5mz1knsa44nc"
    },
    {
      username: "effyic-test-07",
      password: "1fldwst8wk25odkg"
    },
    {
      username: "effyic-test-08",
      password: "1zc3ecjpcpz4q4yk"
    },
    {
      username: "effyic-test-09",
      password: "hhg1hbct5w9b6qtk"
    },
    {
      username: "effyic-test-10",
      password: "60w5gehrezrp4x2f"
    },
    {
      username: "effyic-test-11",
      password: "evegihzgo90ayors"
    },
    {
      username: "effyic-test-12",
      password: "3t93zcjf8xfj96hr"
    },
    {
      username: "effyic-test-13",
      password: "vbsfb7gyn8dlif4g"
    },
    {
      username: "effyic-test-14",
      password: "k4ifd7e2w583qma8"
    },
    {
      username: "effyic-test-15",
      password: "g18f139ct00d7ijb"
    },
    {
      username: "effyic-test-16",
      password: "VvkU3EW2GwNVkByW"
    },
    {
      username: "effyic-test-17",
      password: "X2GAS236jeDTOk1y"
    },
    {
      username: "effyic-test-18",
      password: "KQmKVnrkSHzxJqTR"
    },
    {
      username: "effyic-test-19",
      password: "13O3CYDfqTNFUawj"
    },
    {
      username: "effyic-test-20",
      password: "FQoOkPGOkPGhwy5O"
    },
    {
      username: "effyic-test-21",
      password: "teZwL2hdTZJQ97Uy"
    },
    {
      username: "effyic-test-22",
      password: "zFejlNRtfOgXr8Iz"
    },
    {
      username: "effyic-test-23",
      password: "bO7uSXPwCNPa6crJ"
    },
    {
      username: "effyic-test-24",
      password: "e3lQgBduBHW26PKv"
    },
    {
      username: "effyic-test-25",
      password: "F9ANUlo8kLgBuKg5"
    },
    {
      username: "effyic-test-26",
      password: "N7iI8gaW7XvzlGL7"
    },
    {
      username: "effyic-test-27",
      password: "SOlqNHVIrLI2r2ND"
    },
    {
      username: "effyic-test-28",
      password: "j5S1A8JE7ZmwEMTB"
    },
    {
      username: "effyic-test-29",
      password: "gpmvtlnH6oddqRXr"
    },
    {
      username: "effyic-test-30",
      password: "M1U7N4uvkIq97CyS"
    },
    {
      username: "effyic-test-31",
      password: "QXQiIAe8d5IFbxyX"
    },
    {
      username: "effyic-test-32",
      password: "4wuDJBhbJsSE1qgD"
    },
    {
      username: "effyic-test-33",
      password: "a8NaaXkvjGjWjOnO"
    },
    {
      username: "effyic-test-34",
      password: "fUuB5ZQiyooepYyq"
    },
    {
      username: "effyic-test-35",
      password: "NUJWvPHhpJ6Pkyvd"
    },
    {
      username: "effyic-test-36",
      password: "pwPFG4edCHFFyQ3F"
    },
    {
      username: "effyic-test-37",
      password: "4VKsZQaD5a1kiv2B"
    },
    {
      username: "effyic-test-38",
      password: "jMCcxq1986wbSrJY"
    },
    {
      username: "effyic-test-39",
      password: "F7ueswIg2IINxPDc"
    },
    {
      username: "effyic-test-40",
      password: "Go4MGgIsotpNwmQl"
    },
    {
      username: "effyic-test-41",
      password: "vfIN2WhHEqua27w4"
    },
    {
      username: "effyic-test-42",
      password: "nuwRv3uCUc5CqvL4"
    },
    {
      username: "effyic-test-43",
      password: "GIBxGSJjuHXrSphP"
    },
    {
      username: "effyic-test-44",
      password: "YiaUzRi5gVujicGk"
    },
    {
      username: "effyic-test-45",
      password: "igjSzZpfu4f6aguZ"
    },
    {
      username: "effyic-test-46",
      password: "WnpLSTfr5pkbYmeE"
    },
    {
      username: "effyic-test-47",
      password: "d8Peq4Nz4fWdWFji"
    },
    {
      username: "effyic-test-48",
      password: "j1p2ikP4dloUEJUV"
    },
    {
      username: "effyic-test-49",
      password: "kb37p8u5ruayXOfz"
    },
    {
      username: "effyic-test-50",
      password: "7ZkN5KPgN2FPhjgo"
    },
    {
      username: "effyic-test-51",
      password: "tJKVM4aK5tQ5Po0R"
    },
    {
      username: "effyic-test-52",
      password: "10KV3nusXd9ZCF1T"
    },
    {
      username: "effyic-test-53",
      password: "uSFVCisCfPaTQjqJ"
    },
    {
      username: "effyic-test-54",
      password: "tiCIrZKWW2MuIYrP"
    },
    {
      username: "effyic-test-55",
      password: "z4uMH9QQ60HqRspC"
    },
    {
      username: "effyic-test-56",
      password: "01gQSu1B4i24Zke5"
    },
    {
      username: "effyic-test-57",
      password: "Qm3qFund6ogvzdae"
    },
    {
      username: "effyic-test-58",
      password: "VexUOC3Us5eLmfTy"
    },
    {
      username: "effyic-test-59",
      password: "qOfzfgRaSfZJFRXO"
    },
    {
      username: "effyic-test-60",
      password: "n5GVSH2MOOhcEgZL"
    },
    {
      username: "effyic-test-61",
      password: "Fy8BLyCo5aw4THo1"
    },
    {
      username: "effyic-test-62",
      password: "p5uMbLJWYDPX4QL6"
    },
    {
      username: "effyic-test-63",
      password: "ZuitOPNVhU6WZGwv"
    },
    {
      username: "effyic-test-64",
      password: "Z5jlNFXOdUKr0XFm"
    },
    {
      username: "effyic-test-65",
      password: "5kyLAxYnFVS2ieTH"
    }
  ]

  users.each { |user| User.create!(username: user[:username], password: user[:password]) }
end

init_user
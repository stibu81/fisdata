tmpfile <- tempfile("fisdata_logo", fileext = ".png")

hexSticker::sticker(
  devtools::package_file("man", "figures", "racer.png"),
  package = "fisdata",
  p_size = 25, p_color = "#fcaf16",
  p_family = "sans",
  p_x = 1.5, p_y = 0.6,
  s_x = 1.1, s_y = 1.0, s_width = .7,
  h_fill = "#fffbd6",
  h_color = "#fcaf16",
  h_size = 1.5,
  filename = tmpfile,
  dpi = 500
)

usethis::use_logo(tmpfile, "360x417")
